---
ID: 16
post_title: >
  Selecting custom Objects from a
  DataGridView
author: timvw
post_date: 2006-09-03 02:09:56
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/03/selecting-custom-objects-from-a-datagridview/
published: true
---
<p>Here is a way that allows the user to select a row (custom object properties are used as column values) from a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.aspx">DataGridView</a> assuming that the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datagridview.selectionmode.aspx">SelectionMode</a> property is set FullRowSelect:</p>
[code lang="csharp"]
private void FillDataGridViewPersons( List<person> persons ) {
 this.dataGridViewPersons.Rows.Clear();

 for ( int i = 0; i < persons.Count; ++i ) {
  this.dataGridViewPersons.Rows.Add();
  this.dataGridViewPersons.Rows[i].Tag = persons[i];
  this.dataGridViewPersons.Rows[i].SetValues( new object[] { persons[i].Id, persons[i].Name } );
 }
}

private void buttonDoSomething_Click( object sender, EventArgs e ) {
 if ( this.dataGridViewPersons.SelectedRows.Count == 1 ) {
  int selectedRowIndex = this.dataGridViewPersons.SelectedCells[0].RowIndex;
  Person selectedPerson = (Person)this.dataGridViewPersons.Rows[selectedRowIndex].Tag;
  MessageBox.Show( String.Format( "You selected the person with id: {0}", selectedPerson.Id ) );
 }
}
[/code]