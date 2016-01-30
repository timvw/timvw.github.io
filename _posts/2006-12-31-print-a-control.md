---
ID: 138
post_title: Print a Control
author: timvw
post_date: 2006-12-31 02:50:50
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/12/31/print-a-control/
published: true
dsq_thread_id:
  - "1933324936"
---
<p>A while ago i discovered the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.drawtobitmap.aspx">DrawToBitmap</a> method on the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.control.aspx">Control</a> class. The availability of this method makes it relatively easy to implement a <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.printing.printpageeventhandler.aspx">PrintPageEventHandler</a> for the <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.printing.printdocument.aspx">PrintDocument</a> class. Here is an example implementation that prints a DataGridView:</p>
[code lang="csharp"]private void buttonPrint_Click(object sender, EventArgs e)
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

 int posX = ((int)this.currentPage % requiredPagesForWidth) * e.MarginBounds.Width;
 int posY = ((int)this.currentPage / requiredPagesForWidth) * e.MarginBounds.Height;

 Graphics graphics = e.Graphics;
 Bitmap bitmap = new Bitmap(this.dataGridView1.Width, this.dataGridView1.Height);
 this.dataGridView1.DrawToBitmap(bitmap, this.dataGridView1.Bounds);
 graphics.DrawImage(bitmap, new Rectangle(e.MarginBounds.X, e.MarginBounds.Y, e.MarginBounds.Width, e.MarginBounds.Height), new Rectangle(posX, posY, e.MarginBounds.Width, e.MarginBounds.Height), GraphicsUnit.Pixel);

 this.dataGridView1.Size = oldSize;
 ++this.currentPage;
}[/code]
<p>Now that you understand the main idea, let's wrap it in a class and make it reusable: <a href="http://www.timvw.be/wp-content/code/csharp/ResizedControlPrintPageEventHandler.txt">ResizedControlPrintPageEventHandler</a>. Using this class is as simple as:</p>
[code lang="csharp"]
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
}[/code]
<p>Here are a couple of screenshots:</p>
<img src="http://www.timvw.be/wp-content/images/print-datagridview1.gif" alt="Screenshot of demo application that has a datagridview with scrollbars."/>
<img src="http://www.timvw.be/wp-content/images/print-datagridview2.gif" alt="Screenshot of print preview. Notice that the scrollbars are gone."/>
<img src="http://www.timvw.be/wp-content/images/print-datagridview3.gif" alt="Screenshot of the print document."/>
<p>Feel free to download the class and demo application: <a href="http://www.timvw.be/wp-content/code/csharp/ControlPrintPageEventHandler.zip">ControlPrintPageEventHandler.zip</a>.</p>