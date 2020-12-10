---
title: Using interfaces with Drag and Drop
layout: post
tags:
  - 'C#'
  - Windows Forms
---
Earlier today i was refactoring some graphical components. I wanted to use an interface instead of concrete implementations for my drag and drop code... Although i was using an instance of Foo, and thus IFoo, the following code never allowed me to drop

```csharp
interface IFoo { }
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
}
```

Simply wrapping the concrete instance in a [DataObject](http://msdn2.microsoft.com/en-us/library/system.windows.forms.dataobject(VS.80).aspx) results in the desired behaviour

```csharp
private void label1_MouseDown(object sender, MouseEventArgs e)
{
	this.DoDragDrop(new DataObject(typeof(IFoo).FullName,new Foo()), DragDropEffects.All);
}
```
