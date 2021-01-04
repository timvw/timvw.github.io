---
date: "2006-11-25T00:00:00Z"
tags:
- C#
- Windows Forms
title: Master-Slave for databound ComboBoxes
aliases:
 - /2006/11/25/master-slave-for-databound-comboboxes/
 - /2006/11/25/master-slave-for-databound-comboboxes.html
---
In most examples on the Internet you'll find that the Master has a property that returns the allowed Slaves. Here's an example that does not require such a property. Let's start with a simple class that represents a Person.

```csharp
public class Person
{
	private string name;

	public Person(string name)
	{
		this.name = name;
	}

	public string Name
	{
		get { return this.name; }
		set { this.name = value; }
	}
}
```

And now we define a class to hold the choosen Master and Slave persons.

```csharp
public class MasterSlave
{
	private Person master;
	private Person slave;

	public MasterSlave()
	{
		Person[] masters = this.GetMasters();
		this.master = masters[0];

		Person[] slaves = this.GetSlaves(this.master);
		this.slave = slaves[0];
	}

	public Person Master
	{
		get { return this.master; }
		set { this.master = value; }
	}

	public Person Slave
	{
		get { return this.slave; }
		set { this.slave = value; }
	}

	public Person[] GetMasters()
	{
		List<person> masters = new List<person>();
		masters.Add(new Person("master1"));
		masters.Add(new Person("master2"));
		return masters.ToArray();
	}

	public Person[] GetSlaves(Person person)
	{
		List<person> slaves = new List<person>();

		switch (person.Name)
		{
		case "master1":
		slaves.Add(new Person("master1-slave1"));
		slaves.Add(new Person("master1-slave2"));
		break;
		case "master2":
		slaves.Add(new Person("master2-slave1"));
		slaves.Add(new Person("master2-slave2"));
		slaves.Add(new Person("master2-slave3"));
		break;
		}
		return slaves.ToArray();
	}
}
```

And now we can hook these objects to your Form.

```csharp
public partial class Form1 : Form
{
	public Form1()
	{
		InitializeComponent();

		MasterSlave masterSlave = new MasterSlave();

		BindingSource masterBindingSource = new BindingSource();
		masterBindingSource.DataSource = masterSlave.GetMasters();
		masterBindingSource.CurrentChanged += new EventHandler(masterBindingSource_CurrentChanged);

		this.comboBoxMaster.DataSource = masterBindingSource;
		this.comboBoxMaster.DisplayMember = "Name";
		this.comboBoxMaster.DataBindings.Add("SelectedItem", masterSlave, "Master");

		BindingSource slaveBindingSource = new BindingSource();
		slaveBindingSource.DataSource = masterSlave.GetSlaves(masterBindingSource.Current as Person);

		this.comboBoxSlave.DataSource = slaveBindingSource;
		this.comboBoxSlave.DisplayMember = "Name";
		this.comboBoxSlave.DataBindings.Add("SelectedItem", masterSlave, "Slave");
	}

	private void masterBindingSource_CurrentChanged(object sender, EventArgs e)
	{
		BindingSource masterBindingSource = this.comboBoxMaster.DataSource as BindingSource;
		Person master = masterBindingSource.Current as Person;

		BindingSource slaveBindingSource = this.comboBoxSlave.DataSource as BindingSource;
		MasterSlave masterSlave = this.comboBoxSlave.DataBindings["SelectedItem"].DataSource as MasterSlave;
		slaveBindingSource.DataSource = masterSlave.GetSlaves(master);
	}
}
```
