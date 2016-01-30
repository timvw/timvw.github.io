---
ID: 187
post_title: Debugging custom UITypeEditors
author: timvw
post_date: 2007-08-10 18:26:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/10/debugging-custom-uitypeeditors/
published: true
---
<p>If you read this you're probably gonna think: What a moron! Anyway, i'm sharing this in the hope that i'll be the last to undergo the following. In order to test my custom <a href="http://msdn2.microsoft.com/en-us/library/system.drawing.design.uitypeeditor.aspx">UITypeEditor</a> i did the following:</p>
<ol>
<li>Create a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.usercontrol.aspx">UserControl</a></li>
<li>Add a property to the control </li>
<li>Add an <a href="http://msdn2.microsoft.com/en-us/library/system.componentmodel.editorattribute.aspx">Editor</a> attribute to the property</li>
<li>Build</li>
<li>Drag a UserControl on the designer form</li>
<li>Test via Visual Studio's Property Window if the UITypeEditor works as expected</li>
<li>Everytime i changed some code: <b>Restart Visual Studio</b>, load the project and repeat 6.</li>
</ol>
<p>A tedious task to say the least. Yesterday i figured out that i could <b>drag a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.propertygrid.aspx">PropertyGrid</a> on the designer form, and set it's SelectedObject property to a class with a property that uses the custom UITypeEditor; Instead of having to reload visual studio i can simply start a debug session, and click on the property in the PropertyGrid.</b> Now it's a breeze to develop custom UITypeEditors :)</p>
<img src="http://www.timvw.be/wp-content/images/uitypeeditor.gif" alt=""/>
[code lang="csharp"]private void Form1_Load(object sender, EventArgs e)
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
}[/code]