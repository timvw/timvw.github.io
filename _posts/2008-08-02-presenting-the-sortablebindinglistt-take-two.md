---
ID: 314
post_title: 'Presenting the SortableBindingList&lt;T&gt; (take two)'
author: timvw
post_date: 2008-08-02 12:47:49
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/02/presenting-the-sortablebindinglistt-take-two/
published: true
dsq_thread_id:
  - "1920126406"
---
<p>I'm in the progress of adding classes that i find interesting to the <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a> project. The original implementation of my <a href="http://www.timvw.be/presenting-the-sortablebindinglistt/">SortableBindingList&lt;T&gt;</a> relied on <a href="http://msdn.microsoft.com/en-us/library/system.icomparable.aspx">IComparable</a> to implement ApplySortCore(PropertyDescriptor property, ListSortDirection direction). I received some good feedback and <a href="http://www.timvw.be/improvements-for-the-sortablebindinglist-and-typedlist/">blogged about those improvements</a>.</p>

<p>Because some of my classes only implement <a href="http://msdn.microsoft.com/en-us/library/4d7sx9hd.aspx">IComparable&lt;T&gt;</a> i needed support for this too. My first thought was to use Comparer&lt;T&gt;:</p>

[code lang="csharp"]IComparer comparer = Comparer<t>.Default;
itemsList.Sort(delegate(T t1, T t2)
{
 object property1 = prop.GetValue(t1);
 object property2 = prop.GetValue(t2);
 return reverse * comparer.Compare(property1, property2);
});[/code]

<p>Obviously that didn't work. The problem is that i received the default Comparer for T, instead of the Comparer for the type of the property. Anyway, with a bit of reflection i got access to that Comparer:</p>

[code lang="csharp"]Type comparablePropertyType = typeof(Comparer<>).MakeGenericType(property.PropertyType);
IComparer comparer = (IComparer)comparablePropertyType.InvokeMember("Default", BindingFlags.Static | BindingFlags.GetProperty | BindingFlags.Public, null, null, null);
[/code]

<p>After a bit of refactoring i ended up with a PropertyComparer&lt;T&gt; which allowed me to implement the sorting as following:</p>

[code lang="csharp"]Type propertyType = property.PropertyType;

// this cache minimizes the cost of reflection in the PropertyComparer constructor
PropertyComparer<t> comparer;
if (!this.comparers.TryGetValue(propertyType, out comparer))
{
 comparer = new PropertyComparer<t>(property, direction);
 this.comparers.Add(propertyType, comparer);
}
else
{
 comparer.SetListSortDirection(direction);
}

itemsList.Sort(comparer);[/code]

<p>In order to write unittests, i needed a way to get instances of a <a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.propertydescriptor.aspx">PropertyDescriptor</a>. This was achieved by using the <a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.typedescriptor_methods.aspx">TypeDescriptor</a> as following:</p>

[code lang="csharp"]PropertyDescriptor GetPropertyDescriptor(object component, string propertyName)
{
 PropertyDescriptorCollection propertyDescriptors = TypeDescriptor.GetProperties(component);
 foreach (PropertyDescriptor propertyDescriptor in propertyDescriptors)
 {
  if (propertyDescriptor.Name == propertyName)
  {
   return propertyDescriptor;
  }
 }

 throw new ArgumentException(string.Format("The property '{0}' was not found.", propertyName));
}[/code]

<p>Feel free to download the updated demo application: <a href="http://www.timvw.be/wp-content/code/csharp/SortableBindingList.zip">sortablebindinglist.zip</a>. There are even real applications that use this class, eg: <a href="http://vstrac.devjavu.com/">VSTrac</a> and <a href="http://monotorrent.com/">MonoTorrent</a>. If you're interested in the unittests you'll have to get the code at <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>.</p>