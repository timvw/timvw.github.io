---
date: "2008-09-10T00:00:00Z"
guid: http://www.timvw.be/?p=540
tags:
- C#
title: Presenting a couple of custom MarkupExtensions
aliases:
 - /2008/09/10/playing-with-xaml/
 - /2008/09/10/playing-with-xaml.html
---
[XAML](http://en.wikipedia.org/wiki/Xaml) provides us a way to declare objects with xml. Because i don't want to clutter my domain classes with attributes like [TypeConverterAttribute](http://msdn.microsoft.com/en-us/library/system.componentmodel.typeconverterattribute.aspx), i needed a different approach to manipulate the parsing. This is where custom [MarkupExtension](http://msdn.microsoft.com/en-us/library/system.windows.markup.markupextension.aspx)s come to the rescue. Here is an example where i use the [x:Array MarkupExtension](http://msdn.microsoft.com/en-us/library/ms752340.aspx) in order to load a list of Lines into my IList<string> Lines property

```xml
<?xml version="1.0" encoding="utf-8" ?>
<d:Address xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:s="clr-namespace:System;assembly=mscorlib" xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo" xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo">
	<d:Address.Lines>
		<x:Array Type="s:String">
			<s:String>Ikaroslaan 21</s:String>
			<s:String>B-1930 Zaventem</s:String>
		</x:Array>
	</d:Address.Lines>
</d:Address>
```

By default all XAML documents have all the data embedded. Sometimes this is undesirable so i decided to define External and ExternalList MarkupExtensions that allow us to specify that the resource is elsewhere available. Here is an example of Jeff who has one address in a different file, Domain\Address\Leuven\Brusselsestraat_400.xaml

```xml
<?xml version="1.0" encoding="utf-8" ?>
<d:Person xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:s="clr-namespace:System;assembly=mscorlib" xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo" xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo" Name="Jeff" Birthday="{e:DateTime 14/10/1972}">
	<d:Person.Addresses>
		<e:ExternalList Type="XamlDemo.Domain.Address">
			<e:ExternalList.Resources>
				<x:Array Type="s:String">
					<s:String>Domain.Address.Leuven.Brusselsestraat_400</s:String>
				</x:Array>
			</e:ExternalList.Resources>
		</e:ExternalList>
	</d:Person.Addresses>
</d:Person>
```

It is also possible to have multiple redirections. Here is an example of Tim who has two addresses defined in Domain\Address\ForPerson\Tim.xaml

```xml
<?xml version="1.0" encoding="utf-8" ?>
<d:Person xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:s="clr-namespace:System;assembly=mscorlib" xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo" xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo" Name="Tim" Birthday="{e:DateTime 30/04/1980}">
	<d:Person.Addresses>
		<e:External Type="XamlDemo.Domain.Address" Resource="Domain.Address.ForPerson.Tim" />
	</d:Person.Addresses>
</d:Person>
```

And here is the definition for Domain\Address\ForPerson\Tim.xaml

```xml
<?xml version="1.0" encoding="utf-8" ?>
<e:ExternalList xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:s="clr-namespace:System;assembly=mscorlib" xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo" xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo" Type="XamlDemo.Domain.Address">
	<e:ExternalList.Resources>
		<x:Array Type="s:String">
			<s:String>Domain.Address.Leuven.Bondgenotenlaan_14</s:String>
			<s:String>Domain.Address.Zaventem.Ikaroslaan_21</s:String>
		</x:Array>
	</e:ExternalList.Resources>
</e:ExternalList>
```

Anyway, feel free to download the sample application, [XamlDemo.zip](http://www.timvw.be/wp-content/code/csharp/XamlDemo.zip).
