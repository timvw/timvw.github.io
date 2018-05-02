---
id: 154
title: 'Don&#039;t wait until the DateTimePicker has lost focus to write back the values'
date: 2007-02-07T22:52:52+00:00
author: timvw
layout: post
guid: http://www.timvw.be/dont-wait-until-the-datetimepicker-has-lost-focus-to-write-back-the-values/
permalink: /2007/02/07/dont-wait-until-the-datetimepicker-has-lost-focus-to-write-back-the-values/
dsq_thread_id:
  - 1933325636
tags:
  - 'C#'
  - Windows Forms
---
Drag a TextBox and a DateTimePicker control on a Form and databind them to a DateTime property, eg

```csharp
public partial class Form1 : Form
{
	public Form1()
	{
		InitializeComponent();

		SimpleObject simpleObject = new SimpleObject();
		simpleObject.Birthday = DateTime.Now;

		this.dateTimePicker1.DataBindings.Add("Value", simpleObject, "Birthday");
		this.textBox1.DataBindings.Add("Text", simpleObject, "Birthday", true, DataSourceUpdateMode.OnPropertyChanged);
	}
}

public class SimpleObject : INotifyPropertyChanged
{
	private DateTime birthday;

	public event PropertyChangedEventHandler PropertyChanged;

	public DateTime Birthday
	{
		get { return this.birthday; }
		set
		{
		this.birthday = value;
		this.OnPropertyChanged("Birthday");
		}
	}

	private void OnPropertyChanged(string propertyName)
	{
		if (this.PropertyChanged != null)
		{
			this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
		}
	}
}
```

The annoying bit is that every time the user picks a datetime, he has to move the focus before the changes in the DateTimePicker control are written back to the datasource... You can circumvent this by handling the CloseUp event of the DataTimePicker as following

```csharp
private void dateTimePicker1_CloseUp(object sender, EventArgs e)
{
	DateTimePicker dateTimePicker = sender as DateTimePicker;
	if (dateTimePicker != null)
	{
		foreach (Binding binding in dateTimePicker.DataBindings)
		{
			binding.WriteValue();
		}
	}
}
```

I think mosts users will appreciate this new behaviour 🙂 We can also apply this technique on a ComboBox (using the SelectionChangeCommitted event). Instead of manually hooking up to all these events, i've implemented an IExtenderProvider that takes care of this tedious task (only showing the part for the datetimepicker)

```csharp
[ProvideProperty("WriteValuesAfterCloseUp", typeof(DateTimePicker))]
class WriteValueAfterEventExtender : Component, IExtenderProvider
{
	private Dictionary<dateTimePicker, bool> writeValuesAfterCloseUp;

	public WriteValueAfterEventExtender()
	{
		this.writeValuesAfterCloseUp = new Dictionary<dateTimePicker, bool>();
	}

	public bool CanExtend(object extendee)
	{
		return extendee is DateTimePicker;
	}

	[Description("Gets a boolean indicating if the values are written to the datasource after a CloseUp event.")]
	public bool GetWriteValuesAfterCloseUp(DateTimePicker dateTimePicker)
	{
		bool value;
		if (!this.writeValuesAfterCloseUp.TryGetValue(dateTimePicker, out value))
		{
			value = false;
		}
		return value;
	}

	public void SetWriteValuesAfterCloseUp(DateTimePicker dateTimePicker, bool value)
	{
		if (this.writeValuesAfterCloseUp.ContainsKey(dateTimePicker))
		{
			this.writeValuesAfterCloseUp[dateTimePicker] = value;
		}
		else
		{
			this.writeValuesAfterCloseUp.Add(dateTimePicker, value);
		}

		if (value)
		{
			dateTimePicker.CloseUp += this.dateTimePicker_CloseUp;
		}
		else
		{
			dateTimePicker.CloseUp -= this.dateTimePicker_CloseUp;
		}
	}

	private void dateTimePicker_CloseUp(object sender, EventArgs e)
	{
		DateTimePicker dateTimePicker = sender as DateTimePicker;
		if (dateTimePicker != null)
		{
			foreach (Binding binding in dateTimePicker.DataBindings)
			{
				binding.WriteValue();
			}
		}
	}
}
```

As soon as you drop an instance of the WriteValueAfterEditExtender component on your designer form you will see the that an extra property appears on the datetimepicker

![image of the propertylist for datetimepicker](http://www.timvw.be/wp-content/images/writevalueaftereventextender.gif)

As always, feel free to download the [ExtenderProvider.zip](http://www.timvw.be/wp-content/code/csharp/ExtenderProvider.zip).
