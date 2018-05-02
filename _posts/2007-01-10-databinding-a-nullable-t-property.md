---
id: 144
title: 'Databinding a Nullable &lt;T&gt; property'
date: 2007-01-10T01:21:55+00:00
author: timvw
layout: post
guid: http://www.timvw.be/experimenting-with-iextenderprovider/
permalink: /2007/01/10/databinding-a-nullable-t-property/
tags:
  - 'C#'
  - Windows Forms
---
I find it frustrating that data binding does not really support Nullable<T>. Anyway, it's relatively easy to workaround this shortcoming

```csharp
public partial class Form1 : Form
{
	private MyDataSource myDataSource;

	public Form1()
	{
		InitializeComponent();

		this.myDataSource = new MyDataSource();
		this.textBox1.DataBindings.Add("Text", this.myDataSource, "Double", true);
		this.textBox1.DataBindings["Text"].Parse += this.Text_Parse;
	}

	void Text_Parse( object sender, ConvertEventArgs e )
	{
		if( e.Value == null || e.Value.ToString().Length == 0 )
		{
			e.Value = null;
		}
	}

	private void buttonTellMe_Click(object sender, EventArgs e)
	{
		if (this.myDataSource.Double.HasValue)
		{
			MessageBox.Show("The double is: " + this.myDataSource.Double);
		}
		else
		{
			MessageBox.Show("The double is null");
		}
	}
}

class MyDataSource
{
	private double? _double;

	public double? Double
	{
		get { return this._double; }
		set { this._double = value; }
	}
}
```
  
  
![screenshot of double value in textbox](http://www.timvw.be/wp-content/images/databind-nullabletext1.gif)
  
![screenshot of null value in textbox](http://www.timvw.be/wp-content/images/databind-nullabletext2.gif)
