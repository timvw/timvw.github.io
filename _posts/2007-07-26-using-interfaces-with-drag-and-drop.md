---
ID: 183
post_title: Using interfaces with Drag and Drop
author: timvw
post_date: 2007-07-26 19:10:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/07/26/using-interfaces-with-drag-and-drop/
published: true
---
<p>Earlier today i was refactoring some graphical components. I wanted to use an interface instead of concrete implementations for my drag and drop code... Although i was using an instance of Foo, and thus IFoo, the following code never allowed me to drop:</p>
[code lang="csharp"]interface IFoo { }
class Foo : IFoo { }

private void label1_MouseDown(object sender, MouseEventArgs e)
{
 this.DoDragDrop(new Foo(), DragDropEffects.All);
}

private void Form1_DragEnter(object sender, DragEventArgs e)
{
 // for an instance of Foo it returns false,
 // if you use typeof(Foo) it returns true though...
 if (e.Data.GetDataPresent(typeof(IFoo)))
 {
  e.Effect = DragDropEffects.All;
 }
}[/code]
<p>Simply wrapping the concrete instance in a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.dataobject(VS.80).aspx">DataObject</a> results in the desired behaviour:</p>
[code lang="csharp"]
private void label1_MouseDown(object sender, MouseEventArgs e)
{
 this.DoDragDrop(new DataObject(typeof(IFoo).FullName,new Foo()), DragDropEffects.All);
}[/code]