---
date: "2006-09-16T00:00:00Z"
tags:
- CSharp
title: Anonymous methods
---
Suppose you add a couple of buttons to a panel as shown below. What do you think the message in the MessageBoxes will be?

```csharp
public partial class Form1 : Form 
{
	public Form1() 
	{
		InitializeComponent();

		for (int i = 0; i < 10; ++i) 
		{ 
			Button button = new Button(); 
			button.Text = String.Format("{0:00}", i); 
			this.flowLayoutPanel1.Controls.Add( button ); 
			button.Click += new EventHandler(delegate(Object sender, EventArgs e) 
			{ 
				MessageBox.Show(String.Format("You clicked button {0:00}", i)); 
			}); 
		} 
	} 
}
``` 

In case you're wondering why they all have the message "You clicked button 10" i suggest you read the following articles

* [Part 1](http://blogs.msdn.com/oldnewthing/archive/2006/08/02/686456.aspx)
* [Part 2](http://blogs.msdn.com/oldnewthing/archive/2006/08/03/687529.aspx)
* [Part 3](http://blogs.msdn.com/oldnewthing/archive/2006/08/04/688527.aspx)
