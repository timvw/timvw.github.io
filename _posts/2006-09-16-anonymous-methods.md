---
ID: 8
post_title: Anonymous methods
author: timvw
post_date: 2006-09-16 02:01:46
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/16/anonymous-methods/
published: true
---
<p>Suppose you add a couple of buttons to a panel as shown below. What do you think the message in the MessageBoxes will be?</p>

[code lang="csharp"]public partial class Form1 : Form {
 public Form1() {
  InitializeComponent();

  for (int i = 0; i < 10; ++i) {
   Button button = new Button();
   button.Text = String.Format("{0:00}", i);
   this.flowLayoutPanel1.Controls.Add( button );

   button.Click += new EventHandler(delegate(Object sender, EventArgs e) {
    MessageBox.Show(String.Format("You clicked button {0:00}", i));
   });
  }
 }
}[/code]

<p>In case you're wondering why they all have the message "You clicked button 10" i suggest you read the following articles:</p>

<ul>
<li><a href="http://blogs.msdn.com/oldnewthing/archive/2006/08/02/686456.aspx">Part 1</a></li>
<li><a href="http://blogs.msdn.com/oldnewthing/archive/2006/08/03/687529.aspx">Part 2</a></li>
<li><a href="http://blogs.msdn.com/oldnewthing/archive/2006/08/04/688527.aspx">Part 3</a></li>
</ul>