---
date: "2007-08-10T00:00:00Z"
tags:
- C#
- Visual Studio
- Windows Forms
title: Debugging custom UITypeEditors
aliases:
 - /2007/08/10/debugging-custom-uitypeeditors/
 - /2007/08/10/debugging-custom-uitypeeditors.html
---
If you read this you're probably gonna think: What a moron! Anyway, i'm sharing this in the hope that i'll be the last to undergo the following. In order to test my custom [UITypeEditor](http://msdn2.microsoft.com/en-us/library/system.drawing.design.uitypeeditor.aspx) i did the following

1. Create a [UserControl](http://msdn2.microsoft.com/en-us/library/system.windows.forms.usercontrol.aspx)
2. Add a property to the control 
3. Add an [Editor](http://msdn2.microsoft.com/en-us/library/system.componentmodel.editorattribute.aspx) attribute to the property
4. Build
5. Drag a UserControl on the designer form
6. Test via Visual Studio's Property Window if the UITypeEditor works as expected
7. Everytime i changed some code: **Restart Visual Studio**, load the project and repeat 6.

A tedious task to say the least. Yesterday i figured out that i could **drag a [PropertyGrid](http://msdn2.microsoft.com/en-us/library/system.windows.forms.propertygrid.aspx) on the designer form, and set it's SelectedObject property to a class with a property that uses the custom UITypeEditor; Instead of having to reload visual studio i can simply start a debug session, and click on the property in the PropertyGrid.** Now it's a breeze to develop custom UITypeEditors.

![](http://www.timvw.be/wp-content/images/uitypeeditor.gif)
  
```csharp
private void Form1_Load(object sender, EventArgs e)
{
	// display an instance of PersonEntry,
	// a class with a property that should use the custom UITypeEditor i want to test
	this.propertyGrid1.SelectedObject = new PersonEntry(new Person("Tim", "Van Wassenhove"));
}

public class PersonEntry
{
	...

	// instruct the PropertyGrid to use my custom PersonUITypeEditor
	[Editor(typeof(PersonUITypeEditor), typeof(UITypeEditor))]
	public Person Person
	{
		get { return this.person; }
		set { this.person = value; }
	}
}

public class PersonUITypeEditor : UITypeEditor
{
	public override UITypeEditorEditStyle GetEditStyle(ITypeDescriptorContext context)
	{
		return UITypeEditorEditStyle.Modal;
	}

	public override object EditValue(ITypeDescriptorContext context, IServiceProvider provider, object value)
	{
		Person person = value as Person;

		IWindowsFormsEditorService svc = context.GetService(typeof(IWindowsFormsEditorService)) as IWindowsFormsEditorService;
		if (svc != null)
		{
			using (PersonEditorForm personEditorForm = new PersonEditorForm(person))
			{
				if (svc.ShowDialog(personEditorForm) == DialogResult.OK)
				{
					return personEditorForm.Person;
				}
			}
		}

		return value;
	}
}
```
