---
date: "2007-08-21T00:00:00Z"
tags:
- CSharp
- Visual Studio
- Windows Forms
title: Bending the code generation of IExtenderProvider to your will
---
In [Exploring CodeDomSerializer](http://www.timvw.be/exploring-codedomserializer/) i already explained how we can modify the code that the Visual Studio designer generates for us. With a typical [IExtenderProvider](http://msdn2.microsoft.com/en-us/library/system.componentmodel.iextenderprovider.aspx) the designer generates an initializer, SetXXX methods and a variable declaration, which looks like

```csharp
this.constantsExtenderProvider1 = new WindowsApplication1.ConstantsExtenderProvider();

this.constantsExtenderProvider1.SetConstants(this.button1, new string[] {
"Operation1",
"Operation5"});

this.constantsExtenderProvider1.SetConstants(this, null);

private ConstantsExtenderProvider constantsExtenderProvider1;
```

Now, what if we're not happy with those generated SetXXX methods on each Component? The problem is that this code is not generated by the serializer for the ConstantsExtenderProvider but by the serializers for the Components. An easy workaround for this problem is to set the [DesignerSerializationVisibilityAttribute](http://msdn2.microsoft.com/en-us/library/system.componentmodel.designerserializationvisibilityattribute.aspx) on the GetXXX method in our IExtenderProvider to [Hidden](http://msdn2.microsoft.com/en-us/library/system.componentmodel.designerserializationvisibility.aspx).

With those ugly SetXXX methods out of the way it's up to us to do it better. We do this by implementing a custom serializer for our ConstantsExtenderProvider

```csharp
class ConstantsSerializer<T> : CodeDomSerializer
{
	public override object Serialize(IDesignerSerializationManager manager, object value)
	{
		ConstantsExtenderProvider provider = value as ConstantsExtenderProvider;

		CodeDomSerializer baseClassSerializer = manager.GetSerializer(typeof(ConstantsExtenderProvider).BaseType, typeof(CodeDomSerializer)) as CodeDomSerializer;
		CodeStatementCollection statements = baseClassSerializer.Serialize(manager, value) as CodeStatementCollection;

		IDesignerHost host = (IDesignerHost)manager.GetService(typeof(IDesignerHost));
		ComponentCollection components = host.Container.Components;
		this.SerializeExtender(manager, provider, components, statements);

		return statements;
	}

	private void SerializeExtender(IDesignerSerializationManager manager, ConstantsExtenderProvider provider, ComponentCollection components, CodeStatementCollection statements)
	{
		foreach (IComponent component in components)
		{
			Control control = component as Control;
			if (control != null && (control as Form == null))
			{
				CodeMethodInvokeExpression methodcall = new CodeMethodInvokeExpression(base.SerializeToExpression(manager, provider), "SetConstants");
				methodcall.Parameters.Add(new CodeFieldReferenceExpression(new CodeThisReferenceExpression(), control.Name));

				string[] constants = provider.GetConstants(control);
				if (constants != null)
				{
					StringBuilder sb = new StringBuilder();
					sb.Append("new string[] { ");

					foreach (string constant in constants)
					{
						sb.Append(typeof(T).FullName);
						sb.Append(".");
						sb.Append(constant);
						sb.Append(", ");
					}

					sb.Remove(sb.Length -- 2, 2);
					sb.Append(" }");

					methodcall.Parameters.Add(new CodeSnippetExpression(sb.ToString()));
				}
				else
				{
					methodcall.Parameters.Add(new CodePrimitiveExpression(null));
				}

				statements.Add(methodcall);
			}
		}
	}
}
```

And now the generated code looks like

```csharp
this.constantsExtenderProvider1.SetConstants(this.button1, new string[] { WindowsApplication1.Constants.Operation1, WindowsApplication1.Constants.Operation5 });
```

As always, feel free to download the [ConstantsExtenderProvider](http://www.timvw.be/wp-content/code/csharp/ConstantsExtenderProvider.zip) source.
