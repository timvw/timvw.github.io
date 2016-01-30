---
ID: 17
post_title: Selecting custom Objects from a ComboBox
author: timvw
post_date: 2006-09-03 02:10:38
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/03/selecting-custom-objects-from-a-combobox/
published: true
---
<p>Earlier this week someone asked me how he could select custom objects from a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.combobox.aspx">ComboBox</a>. Here is the code he used:</p>
[code lang="csharp"]private void FillComboBoxPersons(List<person> persons) {
 this.comboBoxPersons.Items.Clear();
 this.comboBoxPersons.Items.Add( "--- Select Person -------------------" );
 foreach ( Person person in persons ) {
  this.comboBoxPersons.Items.Add( person.Name );
 }
 this.comboBoxPersons.SelectedIndex = 0;
}[/code]

<p>In order to get the selected item he then used the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.combobox.selectedindex.aspx">SelectedIndex</a> property to lookup the Person in a cache of the persons collection.</p>

<p>Here is an approach that doesn't require you to have a cache of the collection (Since the persons are already stored in the items):</p>
[code lang="csharp"]private void FillComboBoxPersons(List<person> persons) {
 this.comboBoxPersons.Items.Clear();
 this.comboBoxPersons.Items.Add( "--- Select Person -------------------" );
 this.comboBoxPersons.DisplayMember = "Name";
 foreach ( Person person in persons ) {
  this.comboBoxPersons.Items.Add( person );
 }
 this.comboBoxPersons.SelectedIndex = 0;
}[/code]

<p>Now you can easily access the selected item through the <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.listcontrol.selectedvalue.aspx">SelectedValue</a> property.</p>