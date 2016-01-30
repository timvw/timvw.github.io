---
ID: 171
post_title: >
  Improvements for the SortableBindingList
  (and TypedList)
author: timvw
post_date: 2007-05-10 18:01:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/05/10/improvements-for-the-sortablebindinglist-and-typedlist/
published: true
dsq_thread_id:
  - "1923258156"
---
<p>I found out that the sorting didn't work for 'Expression' properties. My first thought was to add another switch to the logic of the already existing code:</p>
[code lang="csharp"]object value1 = t1;
object value2 = t2;

if (prop.Name.StartsWith("||"))
{
 // do something to find the 'ExpressionProperty' values
}
else
{
 foreach (string property in prop.Name.Split('.'))
 {
  // navigate through the relations
  PropertyInfo propertyInfo = value1.GetType().GetProperty(property);
  value1 = propertyInfo.GetValue(value1, null);
  value2 = propertyInfo.GetValue(value2, null);
 }
}[/code]
<p>Since i already have a PropertyDescriptor it seems a lot smarter to use it's GetValue instead:</p>
[code lang="csharp"]object value1 = prop.GetValue(t1);
object value2 = prop.GetValue(t2);[/code]
<p>At <a href="http://blog.developpez.com/index.php?blog=121&title=typedlistalt_tagt&more=1&c=1&tb=1&pb=1">Matthieu MEZIL</a>'s blog i found a suggestion to use <a href="http://msdn2.microsoft.com/en-us/library/cfttsh47(VS.80).aspx">Comparer&lt;T&gt;</a>. This allowed me to reduce:</p>
[code lang="csharp"]IComparable comparable = value1 as IComparable;
if (comparable != null)
{
 return reverse * comparable.CompareTo(value2);
}
else
{
 comparable = value2 as IComparable;
 if (comparable != null)
 {
  return -1 * reverse * comparable.CompareTo(value1);
 }
 else
 {
  return 0;
 }
}[/code]
<p>with:</p>
[code lang="csharp"]// Notice that this requires that atleast value1 or value2 are an instance of a type that implements IComparable
return reverse * Comparer.Default.Compare(value1, value2);[/code]
<p>Feel free to get yet another version of <a href="http://www.timvw.be/wp-content/code/csharp/TypedList.zip">TypedList.zip</a>.</p>