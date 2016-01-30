---
ID: 144
post_title: 'Databinding a Nullable &lt;T&gt; property'
author: timvw
post_date: 2007-01-10 01:21:55
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/01/10/databinding-a-nullable-t-property/
published: true
---
<p>I find it frustrating that data binding does not really support Nullable&lt;T&gt;. Anyway, it's relatively easy to workaround this shortcoming:</p>
[code lang="csharp"]public partial class Form1 : Form
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
[/code]
<br/>
<img src="http://www.timvw.be/wp-content/images/databind-nullabletext1.gif" alt="screenshot of double value in textbox"/>
<img src="http://www.timvw.be/wp-content/images/databind-nullabletext2.gif" alt="screenshot of null value in textbox"/>