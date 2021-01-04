---
date: "2010-02-18T00:00:00Z"
guid: http://www.timvw.be/?p=1702
tags:
- CSharp
title: Exploring System.Interactive
aliases:
 - /2010/02/18/exploring-system-interactive/
 - /2010/02/18/exploring-system-interactive.html
---
A couple of weeks ago i was working on an application that would transfer data through a couple of components as a List<object>. In essence, all we were doing over and over again was the following:

```csharp
interface IMapper
{
	TEntity FromObjectList(List objectList);
	List ToObjectList(TEntity entity);
}
```
My initial implementation (using EnumerableEx operators from <a href="http://msdn.microsoft.com/en-us/devlabs/ee794896.aspx">Reactive Extensions</a>) looked like this

```csharp
public TEntity FromObjectList(List objectList)
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

public List ToObjectList(TEntity entity)
{
	return properties
	.Select(property => property.GetValue(entity, null))
	.ToList();
}
```

And the consumer code looks like this:

```csharp
var person = new Person { Id = 2, Score = 1.3, Name = "Tim", Title = "Sir" };

var personMapper = new Mapper()
	.Map(x => x.Id)
	.Map(x => x.Score)
	.Map(x => x.Name)
	.Map(x => x.Title);

var data = personMapper.ToObjectList(person);
var clonedPerson = personMapper.FromObjectList(data);
```

Wait a minute, in most situations we simply want to map all properties on the object. Let's create a mapper for this

```csharp
class AutoMapper : Mapper where TEntity : new()
{
	public AutoMapper()
	{
		typeof(TEntity).GetProperties().Run(property => Map(property));
	}
}
```

And now we don't have to waste time doing the same thing over and over again! Because we always need to map all properties of our types we ended up with the following

```csharp
public static class Mapper
{
	public static List ToObjectsList(this TEntity entity)
	{
		return entity.GetType().GetProperties()
		.Select(property => property.GetValue(entity, null))
		.ToList();
	}
	
	public static TEntity ToEntity(this List objectsList) where TEntity : new()
	{
		TEntity entity = new TEntity();
		entity.GetType().GetProperties()
			.Zip(objectsList, (property, value) =>{ property.SetValue(entity, value,null); return 0;})
			.Run();
		return entity;
	}
}
```
