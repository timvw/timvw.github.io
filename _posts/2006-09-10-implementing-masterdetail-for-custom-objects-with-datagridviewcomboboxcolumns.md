---
ID: 13
post_title: >
  Implementing Master/Detail for Custom
  Objects with DataGridViewComboBoxColumns
author: timvw
post_date: 2006-09-10 02:07:17
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/10/implementing-masterdetail-for-custom-objects-with-datagridviewcomboboxcolumns/
published: true
dsq_thread_id:
  - "1920133928"
---
<p>Imagine you have the following two classes:</p>
[code lang="csharp"]public class Parent {
 private int id;
 private string name;

 public Parent( int id, string name ) {
  this.id = id;
  this.name = name;
 }

 public int Id {
  get { return this.id; }
 }

 public string Name {
  get { return this.name; }
 }
}

public class Child : Parent {
 private int parentId;

 public Child( int id, int parentId, string name )
  : base( id, name ) {
  this.parentId = parentId;
 }

 public int ParentId {
  get { return this.parentId; }
 }
}[/code]
<p>In the first ComboBoxColumn you display a list of possible Parents. In the second ComboBoxColumn you display Children, but only those that belong to the Chosen Parent. Here is how it goes:</p>
[code lang="csharp"]public partial class Form1 : Form {
private Object selectedValue;

public Form1() {
 InitializeComponent();

 // Add a couple of Parents
 for ( int i = 0; i < 3; ++i ) {
  Parent parent = new Parent( i, String.Format( "Parent{0:00}", i ) );
  this.Column1.Items.Add( parent );
  // Add a couple of Children to each parent
  for ( int j = 0; j < 5; ++j ) {
   Child child = new Child( j, i, String.Format( "Child{0:00}", i * 10 + j ) );
   this.Column2.Items.Add( child );
  }
 }

 this.Column1.DisplayMember = "Name";
 this.Column2.DisplayMember = "Name";
}

private void dataGridView1_CellParsing( object sender, DataGridViewCellParsingEventArgs e ) {
 e.Value = this.selectedValue;
 e.ParsingApplied = true;
}

private void dataGridView1_EditingControlShowing( object sender, DataGridViewEditingControlShowingEventArgs e ) {
 ComboBox cb = e.Control as ComboBox;
 if ( cb != null ) {
  // remove all the children that do not belong to the choosen parent
  int currentColumnIndex = this.dataGridView1.CurrentCell.ColumnIndex;
  if ( currentColumnIndex == 1 ) {
   cb.Items.Clear();

   int currentRowIndex = this.dataGridView1.CurrentCell.RowIndex;
   Object currentCellValue = this.dataGridView1.Rows[currentRowIndex].Cells[0].Value;
   if ( currentCellValue != null ) {
    int parentId = ( (Parent)currentCellValue ).Id;

    foreach ( Child child in this.Column2.Items ) {
     if ( child.ParentId == parentId ) {
      cb.Items.Add( child );
     }
    }
   }
  }

  cb.SelectedIndexChanged -= cb_SelectedIndexChanged;
  cb.SelectedIndexChanged += cb_SelectedIndexChanged;
 }

 void cb_SelectedIndexChanged(object sender, EventArgs e) {
  ComboBox comboBox = sender as ComboBox;
  this.selectedValue = comboBox.SelectedItem;
 }
}[/code]