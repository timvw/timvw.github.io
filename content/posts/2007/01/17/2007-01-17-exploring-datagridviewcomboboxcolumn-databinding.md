---
date: "2007-01-17T00:00:00Z"
tags:
- CSharp
- Windows Forms
title: Exploring DataGridViewComboBoxColumn databinding
---
Let's start with a simple example: Each Person has a Name (string) and PersonTypeCode (an Enumerated value) property. We drag a DataGridView on the designer form and add two columns (DataGridViewComboBoxColumn for the PersonTypeCode property). And then we hook up the Bindingsource as following

```csharp
class Form1 : Form
{
	public Form1()
	{
		InitializeComponent();

		this.dataGridView1.AutoGenerateColumns = false;
		this.ColumnName.DataPropertyName = "Name";
		this.ColumnPersonTypeCode.DataPropertyName = "PersonTypeCode";

		BindingSource bindingSource = new BindingSource();
		bindingSource.DataSource = FindPersons();
		this.dataGridView1.DataSource = bindingSource;
	}

	private BindingList<person> FindPersons()
	{
		BindingList<person> bindingList = new BindingList<person>();
		bindingList.Add(new Person("Timvw", PersonTypeCode.Geek));
		bindingList.Add(new Person("John Doe", PersonTypeCode.Anonymous));
		bindingList.Add(new Person("An Onymous", PersonTypeCode.Anonymous));
		bindingList.Add(new Person("Jenna Jameson", PersonTypeCode.Babe));
		return bindingList;
	}
}

enum PersonTypeCode
{
	Geek = 0,
	Anonymous = 1,
	Babe = 2
}

class Person
{
	private PersonTypeCode personTypeCode;
	private string name;

	public Person(string name, PersonTypeCode personTypeCode)
	{
		this.name = name;
		this.personTypeCode = personTypeCode;
	}

	public string Name
	{
		get { return this.name; }
		set { this.name = value; }
	}

	public PersonTypeCode PersonTypeCode
	{
		get { return this.personTypeCode; }
		set { this.personTypeCode = value; }
	}
}
```

If we run this code we run in the following error:

![DataGridViewComboBoxCell value is not valid.](http://www.timvw.be/wp-content/images/databind-datagridviewcomboboxcolumn-1.gif)

Always make sure the DataGridViewComboxColumn knows about all the possible values ([Add them via the Items property](http://www.timvw.be/implementing-masterdetail-for-custom-objects-with-datagridviewcomboboxcolumns/) or use databinding). Let's extend our Form1 class as following:

```csharp
public Form1()
{
InitializeComponent();

this.dataGridView1.AutoGenerateColumns = false;
this.ColumnName.DataPropertyName = "Name";
this.ColumnPersonTypeCode.DataPropertyName = "PersonTypeCode";
this.ColumnPersonTypeCode.DataSource = FindPersonTypeCodes();

BindingSource bindingSource = new BindingSource();
bindingSource.DataSource = FindPersons();
this.dataGridView1.DataSource = bindingSource;
}

private BindingList<personTypeCode> FindPersonTypeCodes()
{
BindingList<personTypeCode> bindingList = new BindingList<personTypeCode>();
foreach (PersonTypeCode personTypeCode in Enum.GetValues(typeof(PersonTypeCode)))
{
bindingList.Add(personTypeCode);
}
return bindingList;
}
```

Allright, here is a screenshot of our first working version:

![datagridviewcomboboxcolumn with enumerated values](http://www.timvw.be/wp-content/images/databind-datagridviewcomboboxcolumn-2.gif)

Instead of displaying the bare enum values we want to display a nice label. In order to achieve this we define a class PersonType to hold both the PersonTypeCode and the label:

```csharp
class PersonType
{
private PersonTypeCode personTypeCode;
private string label;

public PersonType(string label, PersonTypeCode personTypeCode)
{
this.label = label;
this.personTypeCode = personTypeCode;
}

public string Label
{
get { return this.label; }
set { this.label = value; }
}

public PersonTypeCode PersonTypeCode
{
get { return this.personTypeCode; }
set { this.personTypeCode = value; }
}
}
```

We modify our code so that this new PersonType class is used for the ComboBoxColumn:

```csharp
public Form1()
{
InitializeComponent();

this.dataGridView1.AutoGenerateColumns = false;
this.ColumnName.DataPropertyName = "Name";
this.ColumnPersonTypeCode.DataPropertyName = "PersonTypeCode";
this.ColumnPersonTypeCode.DisplayMember = "Label";
this.ColumnPersonTypeCode.ValueMember = "PersonTypeCode";
this.ColumnPersonTypeCode.DataSource = FindPersonTypes();

BindingSource bindingSource = new BindingSource();
bindingSource.DataSource = FindPersons();
this.dataGridView1.DataSource = bindingSource;
}

private BindingList<personType> FindPersonTypes()
{
BindingList<personType> bindingList = new BindingList<personType>();
bindingList.Add(new PersonType("A geeky person", PersonTypeCode.Geek));
bindingList.Add(new PersonType("A coward", PersonTypeCode.Anonymous));
bindingList.Add(new PersonType("Feeling hot hot hot", PersonTypeCode.Babe));
return bindingList;
}
```
  

  
![datagridviewcomboboxcolumn with nice labels.](http://www.timvw.be/wp-content/images/databind-datagridviewcomboboxcolumn-3.gif)

Great! Now we'll add some functionality that limits the possible values in the ComboBoxColumn basesd on the Name (I already demonstrated this technique [here](http://www.timvw.be/implementing-masterdetail-for-custom-objects-with-datagridviewcomboboxcolumns/)). Simply handle the EditingControlShowing Event on the DataGridView as following:

```csharp
void dataGridView1_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
{
BindingSource bindingSource = this.dataGridView1.DataSource as BindingSource;
Person person = bindingSource.Current as Person;
BindingList<personType> bindingList = this.FindPersonTypes(person);

DataGridViewComboBoxEditingControl comboBox = e.Control as DataGridViewComboBoxEditingControl;
comboBox.DataSource = bindingList;
}

private BindingList<personType> FindPersonTypes(Person person)
{
// by default, all persons simply have one of the available persontypecodes
BindingList<personType> bindingList = FindPersonTypes();

if (person.PersonTypeCode == PersonTypeCode.Geek)
{
// geeks are doomed to stay geeks
bindingList.RemoveAt(2);
bindingList.RemoveAt(1);
}

return bindingList;
}
```

If you open the combox for "Timvw" you see that you can only choose "A geeky person":

![datagridviewcomboboxcolumn with limited options.](http://www.timvw.be/wp-content/images/databind-datagridviewcomboboxcolumn-4.gif)

Instead of using an enum we could have used a regular class too. The key is to override the Equals method:

```csharp
class PersonTypeCode
{
public static PersonTypeCode Geek
{
get { return new PersonTypeCode(0); }
}

public static PersonTypeCode Anonymous
{
get { return new PersonTypeCode(1); }
}

public static PersonTypeCode Babe
{
get { return new PersonTypeCode(2); }
}

private int id;

public PersonTypeCode(int id)
{
this.id = id;
}

public override bool Equals(object obj)
{
if (obj == null) return false;
if (obj == this) return true;
PersonTypeCode personTypeCode = obj as PersonTypeCode;
if (personTypeCode == null) return false;
return this.id == personTypeCode.id;
}

public override int GetHashCode()
{
return this.id.GetHashCode();
}
}

private BindingList<personType> FindPersonTypes(Person person)
{
// by default, all persons simply have one of the available persontypecodes
BindingList<personType> bindingList = FindPersonTypes();

//if (person.PersonTypeCode == PersonTypeCode.Geek)
if (person.PersonTypeCode.Equals(PersonTypeCode.Geek))
{
// geeks are doomed to stay geeks
bindingList.RemoveAt(2);
bindingList.RemoveAt(1);
}

return bindingList;
}
```

And now you're thinking: But i want the user to not select a PersonTypeCode (null). We'll represent that with an empty string "":

```csharp
private BindingList<person> FindPersons()
{
BindingList<person> bindingList = new BindingList<person>();
bindingList.Add(new Person("Timvw", PersonTypeCode.Geek));
bindingList.Add(new Person("John Doe", PersonTypeCode.Anonymous));
bindingList.Add(new Person("An Onymous", PersonTypeCode.Anonymous));
bindingList.Add(new Person("Jenna Jameson", PersonTypeCode.Babe));
bindingList.Add(new Person("Null Able", null));
return bindingList;
}

private BindingList<personType> FindPersonTypes()
{
BindingList<personType> bindingList = new BindingList<personType>();
bindingList.Add(new PersonType("A geeky person", PersonTypeCode.Geek));
bindingList.Add(new PersonType("A coward", PersonTypeCode.Anonymous));
bindingList.Add(new PersonType("Feeling hot hot hot", PersonTypeCode.Babe));
bindingList.Add(new PersonType(string.Empty, null));
return bindingList;
}

private BindingList<personType> FindPersonTypes(Person person)
{
// by default, all persons simply have one of the available persontypecodes
BindingList<personType> bindingList = FindPersonTypes();

if (person.PersonTypeCode != null && person.PersonTypeCode.Equals(PersonTypeCode.Geek))
{
// geeks are doomed to stay geeks
bindingList.RemoveAt(2);
bindingList.RemoveAt(1);
}

return bindingList;
}
```
  
![datagridviewcomboboxcolumn with null option.](http://www.timvw.be/wp-content/images/databind-datagridviewcomboboxcolumn-5.gif)

When the user starts editing the record, the combobox will choose the first item in the list (A geeky person). Now we change this behaviour so that the actual PersonTypeCode is selected:

```csharp
void dataGridView1_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
{
if (this.dataGridView1.CurrentCell.ColumnIndex == this.ColumnPersonTypeCode.Index)
{
BindingSource bindingSource = this.dataGridView1.DataSource as BindingSource;
Person person = bindingSource.Current as Person;
BindingList<personType> bindingList = this.FindPersonTypes(person);

DataGridViewComboBoxEditingControl comboBox = e.Control as DataGridViewComboBoxEditingControl;
comboBox.DataSource = bindingList;
if (person.PersonTypeCode != null)
{
comboBox.SelectedValue = person.PersonTypeCode;
}
else
{
comboBox.SelectedValue = string.Empty;
}
}
}
```
  

  
![datagridviewcomboboxcolumn with selected item.](http://www.timvw.be/wp-content/images/databind-datagridviewcomboboxcolumn-6.gif)

In order to make the DataGridView more usable we set the EditMode property to EditOnEnter. Selected values in the ComboBox are only commited when the user leaves the current cell. Handling the SelectionChangeCommited event on the ComboBox allows us to commit that value without requiring the user to leave the current cell:

```csharp
void dataGridView1_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
{
if (this.dataGridView1.CurrentCell.ColumnIndex == this.ColumnPersonTypeCode.Index)
{
BindingSource bindingSource = this.dataGridView1.DataSource as BindingSource;
Person person = bindingSource.Current as Person;
BindingList<personType> bindingList = this.FindPersonTypes(person);

DataGridViewComboBoxEditingControl comboBox = e.Control as DataGridViewComboBoxEditingControl;
comboBox.DataSource = bindingList;
if (person.PersonTypeCode != null)
{
comboBox.SelectedValue = person.PersonTypeCode;
}
else
{
comboBox.SelectedValue = string.Empty;
}

comboBox.SelectionChangeCommitted -= this.comboBox_SelectionChangeCommitted;
comboBox.SelectionChangeCommitted += this.comboBox_SelectionChangeCommitted;
}
}

void comboBox_SelectionChangeCommitted(object sender, EventArgs e)
{
this.dataGridView1.EndEdit();
}
```

Now it's up to you to apply these simple techniques and build great software. Feel free to download the complete source: [DataGridViewComboBoxBinding.zip](http://www.timvw.be/wp-content/code/csharp/DataGridViewComboBoxBinding.zip).
