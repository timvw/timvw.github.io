---
date: "2006-09-16T00:00:00Z"
tags:
- C#
- Windows Forms
title: Drag and Drop on a DataGridView
aliases:
 - /2006/09/16/drag-and-drop-on-a-datagridview/
 - /2006/09/16/drag-and-drop-on-a-datagridview.html
---
Here is a bit of sample code that allows you to drag and drop a cellvalue in a DataGridView (don't forget to set the AllowDrop property of the DataGridView to true). Notice that you need to translate the X and Y properties of the DragEventArgs first (unlike the X and Y properties of the MouseEventArgs)

```csharp
private void dataGridView1_MouseDown( object sender, MouseEventArgs e )
{
	DataGridView.HitTestInfo info = this.dataGridView1.HitTest( e.X, e.Y );
	if ( info.RowIndex != -1 && info.ColumnIndex != -1 )
	{
		Object value = this.dataGridView1.Rows[info.RowIndex].Cells[info.ColumnIndex].Value;
		if ( value != null )
		{
			this.dataGridView1.Rows[info.RowIndex].Cells[info.ColumnIndex].Value = null;
			this.DoDragDrop( value, DragDropEffects.Move );
		}
	}
}

private void dataGridView1_DragDrop( object sender, DragEventArgs e )
{
	Point p = this.dataGridView1.PointToClient( new Point( e.X, e.Y ) );
	DataGridView.HitTestInfo info = this.dataGridView1.HitTest( p.X, p.Y );
	if ( info.RowIndex != -1 && info.ColumnIndex != -1 )
	{
		Object value = (Object)e.Data.GetData( typeof( string ) );
		this.dataGridView1.Rows[info.RowIndex].Cells[info.ColumnIndex].Value = value;
	}
}

private void dataGridView1_DragEnter( object sender, DragEventArgs e )
{
	e.Effect = DragDropEffects.Move;
}
```
