---
ID: 1702
post_title: Exploring System.Interactive
author: timvw
post_date: 2010-02-18 20:09:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/02/18/exploring-system-interactive/
published: true
---
<p>A couple of weeks ago i was working on an application that would transfer data through a couple of components as a List&lt;object&gt;. In essence, all we were doing over and over again was the following:</p>

[code lang="csharp"]interface IMapper<tentity>
{
 TEntity FromObjectList(List<object> objectList);
 List<object> ToObjectList(TEntity entity);
}[/code]

<p>My initial implementation (using EnumerableEx operators from <a href="http://msdn.microsoft.com/en-us/devlabs/ee794896.aspx">Reactive Extensions</a>) looked like this:</p>

[code lang="csharp"]public TEntity FromObjectList(List<object> objectList)
{
 var entity = new TEntity();

 properties
  .Zip(objectList, (property, value) => AssignValueToProperty(entity, property, value))
  .Run();

 return entity;
}

int AssignValueToProperty(object entity, PropertyInfo property, object value)
{
 property.SetValue(entity, value, null);
 return 0;
}

public List<object> ToObjectList(TEntity entity)
{
 return properties
  .Select(property => property.GetValue(entity, null))
  .ToList();
 }[/code]

<p>And the consumer code looks like this:</p>

[code lang="csharp"]var person = new Person {  Id = 2, Score = 1.3, Name = "Tim", Title = "Sir" };

var personMapper = new Mapper<person>()
 .Map(x => x.Id)
 .Map(x => x.Score)
 .Map(x => x.Name)
 .Map(x => x.Title);

var data = personMapper.ToObjectList(person);
var clonedPerson = personMapper.FromObjectList(data);[/code]

<p>Wait a minute, in most situations we simply want to map all properties on the object. Let's create a mapper for this:</p>

[code lang="csharp"]class AutoMapper<tentity> : Mapper<tentity> where TEntity : new()
{
 public AutoMapper()
 {
  typeof(TEntity).GetProperties().Run(property => Map(property));
 }
}[/code]

<p>And now we don't have to waste time doing the same thing over and over again! Because we always need to map all properties of our types we ended up with the following:</p>

[code lang="csharp"]public static class Mapper
{
 public static List<object> ToObjectsList<tentity>(this TEntity entity)
 {
  return entity.GetType().GetProperties()
   .Select(property => property.GetValue(entity, null))
   .ToList();
  }

 public static TEntity ToEntity<tentity>(this List<object> objectsList) where TEntity : new()
 {
  TEntity entity = new TEntity();
  entity.GetType().GetProperties()
   .Zip(objectsList, (property, value) =>{ property.SetValue(entity, value,null); return 0;})
   .Run();
  return entity;
 }
}[/code]