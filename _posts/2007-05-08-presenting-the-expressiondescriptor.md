---
ID: 169
post_title: Presenting the ExpressionDescriptor
author: timvw
post_date: 2007-05-08 21:07:47
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/05/08/presenting-the-expressiondescriptor/
published: true
---
<p>A couple of days ago i presented you the <a href="http://www.timvw.be/presenting-the-typedlistt/">TypedList</a> which supports navigation through subproperties. Another common feature request is the possibility to add a column that has a value based on other values in the row (like a DataColumn with it's Expression property set). With the plumbing code i've written it's as simple as implementing the following interface:</p>
[code lang="csharp"]public interface IExpressionProvider<componentType, PropertyType>
{
 /// <summary>
 /// Gets the name of the property
 /// </summary>
 string Name { get; }

 /// <summary>
 /// Returns the value of the expression for the given component
 /// </summary>
 /// <param name="component"></param>
 /// <returns></returns>
 PropertyType GetValue(ComponentType component);
}[/code]
<p>An example implementation could be an expression that represents the duration of an Appointment:</p>
[code lang="csharp"]public class DurationExpressionProvider : IExpressionProvider<appointment, TimeSpan>
{
 #region IExpressionProvider<appointment,TimeSpan> Members

 public string Name { get { return "||Duration"; } }

 public TimeSpan GetValue(Appointment component)
 {
  return component.DateTimeRange.End - component.DateTimeRange.Start;
 }

 #endregion
}[/code]
<p>I've changed the constructor of TypedList a bit so that it accepts an enumeration of PropertyDescriptors. In my example you can initialise the list as following:</p>
[code lang="csharp"]List<propertyDescriptor> propertyDescriptors = new List<propertyDescriptor>();

// create the subpropertydescriptors
string[] propertyNames = new string[] { "Patient.Name", "Patient.Address.Municipality", "DateTimeRange.Start", "DateTimeRange.End" };
propertyDescriptors.AddRange(Array.ConvertAll<string, SubPropertyDescriptor<appointment>>(propertyNames, delegate(string propertyName) { return new SubPropertyDescriptor<appointment>(propertyName); }));

// add an expressiondescriptor
IExpressionProvider<appointment, TimeSpan> expressionProvider = new DurationExpressionProvider();
ExpressionDescriptor<appointment, TimeSpan> durationDescriptor = new ExpressionDescriptor<appointment, TimeSpan>(expressionProvider);
propertyDescriptors.Add(durationDescriptor);

TypedBindingList<appointment> appointments = new TypedBindingList<appointment>(propertyDescriptors);[/code]
<p>And this is how it looks like at runtime:</p>
<img src="http://www.timvw.be/wp-content/images/typedlist-3.gif" alt="image of the typedlist"/>
<p>As always, feel free to download the code: <a href="http://www.timvw.be/wp-content/code/csharp/TypedList.zip">TypedList.zip</a>.</p>