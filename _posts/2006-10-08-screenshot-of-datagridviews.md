---
ID: 6
post_title: Screenshot of DataGridViews
author: timvw
post_date: 2006-10-08 01:42:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/10/08/screenshot-of-datagridviews/
published: true
---
<p>The problem with a regular screenshot is that you only get to see a part of the DataGridViews. Here's an example of a typical form:</p>
<img src="http://www.timvw.be/wp-content/images/datagridviews-with-scrollbars.jpg" alt="image of datagridview with scrollbars"/>
<p>Here is a snippet that makes a screenshot of the complete DataGridViews:</p>
[code lang="csharp"]
List<bitmap> bitmaps = new List<bitmap>();
Size size = new Size();

for (int i = 1; i < 4; ++i)
{
 // lookup the datagridview
 DataGridView dataGridView = (DataGridView)this.Controls["dataGridView" + i];

 // maximize the datagridview size (choosing between current and preferred)
 Size oldSize = dataGridView.Size;
 Size newSize = dataGridView.PreferredSize;

 if (dataGridView.Size.Width > newSize.Width)
 {
  newSize.Width = dataGridView.Size.Width;
 }

 if (dataGridView.Size.Height > newSize.Height)
 {
  newSize.Height = dataGridView.Size.Height;
 }

 dataGridView.Size = newSize;

 // draw the datagridview into a bitmap
 Bitmap bitmap = new Bitmap(dataGridView.Width, dataGridView.Height);
 dataGridView.DrawToBitmap(bitmap, new Rectangle(0, 0, dataGridView.Width, dataGridView.Height));

 // restore the datagridview to it's original size
 dataGridView.Size = oldSize;

 bitmaps.Add(bitmap);

 // update total bitmap size
 if (newSize.Width > size.Width)
 {
  size.Width = newSize.Width;
 }
 size.Height += newSize.Height;
}

// copy all the bitmaps into one large bitmap
Bitmap bitmapComplete = new Bitmap(size.Width, size.Height);
Graphics g = Graphics.FromImage(bitmapComplete);

int height = 0;
for (int i = 1; i < 4; ++i)
{
 g.DrawImageUnscaled(bitmaps[i - 1], 0, height);
 height += bitmaps[i - 1].Height;
}

// bitmapComplete is ready for use
// eg: pictureBox1.Image = bitmapComplete
// eg: bitmapComplete.Save(@"C:\screenshot.jpg", ImageFormat.Jpeg);
[/code]
<br/>
<img src="http://www.timvw.be/wp-content/images/datagridviews-without-scrollbars.jpg" alt="image of generated screenshot"/>