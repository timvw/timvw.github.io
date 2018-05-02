---
id: 138
title: Print a Control
date: 2006-12-31T02:50:50+00:00
author: timvw
layout: post
guid: http://www.timvw.be/print-a-control/
permalink: /2006/12/31/print-a-control/
dsq_thread_id:
  - 1933324936
tags:
  - 'C#'
  - Windows Forms
---
A while ago i discovered the [DrawToBitmap](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.drawtobitmap.aspx) method on the [Control](http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.aspx) class. The availability of this method makes it relatively easy to implement a [PrintPageEventHandler](http://msdn2.microsoft.com/en-us/library/system.drawing.printing.printpageeventhandler.aspx) for the [PrintDocument](http://msdn2.microsoft.com/en-us/library/system.drawing.printing.printdocument.aspx) class. Here is an example implementation that prints a DataGridView

```csharp
private void buttonPrint_Click(object sender, EventArgs e)
{
	this.printDocument1.Print();
}

void printDocument1_BeginPrint(object sender, PrintEventArgs e)
{
	this.currentPage = 0;
}

private void printDocument1_PrintPage(object sender, System.Drawing.Printing.PrintPageEventArgs e)
{
	Size oldSize = this.dataGridView1.Size;
	this.dataGridView1.Height = Math.Max(this.dataGridView1.Height, this.dataGridView1.PreferredSize.Height);
	this.dataGridView1.Width = Math.Max(this.dataGridView1.Width, this.dataGridView1.PreferredSize.Width);

	int requiredPagesForWidth = ((int)this.dataGridView1.Width / e.MarginBounds.Width) + 1;
	int requiredPagesForHeight = ((int)this.dataGridView1.Height / e.MarginBounds.Height) + 1;
	int requiredPages = requiredPagesForWidth * requiredPagesForHeight;
	e.HasMorePages = (this.currentPage < requiredPages - 1); 
	int posX = ((int)this.currentPage % requiredPagesForWidth) \* e.MarginBounds.Width; 
	int posY = ((int)this.currentPage / requiredPagesForWidth) \* e.MarginBounds.Height; 
	Graphics graphics = e.Graphics; 
	Bitmap bitmap = new Bitmap(this.dataGridView1.Width, this.dataGridView1.Height); 
	this.dataGridView1.DrawToBitmap(bitmap, this.dataGridView1.Bounds); 
	graphics.DrawImage(bitmap, new Rectangle(e.MarginBounds.X, e.MarginBounds.Y, e.MarginBounds.Width, e.MarginBounds.Height), new Rectangle(posX, posY, e.MarginBounds.Width, e.MarginBounds.Height), GraphicsUnit.Pixel); 
	this.dataGridView1.Size = oldSize; 
	++this.currentPage; 
}
``` 

Now that you understand the main idea, let's wrap it in a class and make it reusable: [ResizedControlPrintPageEventHandler](http://www.timvw.be/wp-content/code/csharp/ResizedControlPrintPageEventHandler.txt). Using this class is as simple as

```csharp
// Initialise a controlPrintPageEventHandler and register the PrintPage method...
ResizedControlPrintPageEventHandler resizedControlPrintPageEventHandler = new ResizedControlPrintPageEventHandler(this.dataGridView1);
this.printDocument1.PrintPage += resizedControlPrintPageEventHandler.PrintPage;

// Print the control
private void buttonPrint_Click(object sender, EventArgs e)
{
	this.printDocument1.Print();
}

// Give the user a preview
private void buttonPreview_Click(object sender, EventArgs e)
{
	this.printPreviewDialog1.Show();
}
```

Here are a couple of screenshots

![Screenshot of demo application that has a datagridview with scrollbars.](http://www.timvw.be/wp-content/images/print-datagridview1.gif)
  
![Screenshot of print preview. Notice that the scrollbars are gone.](http://www.timvw.be/wp-content/images/print-datagridview2.gif)
  
![Screenshot of the print document.](http://www.timvw.be/wp-content/images/print-datagridview3.gif)

Feel free to download the class and demo application: [ControlPrintPageEventHandler.zip](http://www.timvw.be/wp-content/code/csharp/ControlPrintPageEventHandler.zip).
