---
ID: 540
post_title: >
  Presenting a couple of custom
  MarkupExtensions
author: timvw
post_date: 2008-09-10 17:38:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/10/playing-with-xaml/
published: true
---
<p><a href="http://en.wikipedia.org/wiki/Xaml">XAML</a> provides us a way to declare objects with xml. Because i don't want to clutter my domain classes with attributes like <a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.typeconverterattribute.aspx">TypeConverterAttribute</a>, i needed a different approach to manipulate the parsing. This is where custom <a href="http://msdn.microsoft.com/en-us/library/system.windows.markup.markupextension.aspx">MarkupExtension</a>s come to the rescue. Here is an example where i use the <a href="http://msdn.microsoft.com/en-us/library/ms752340.aspx">x:Array MarkupExtension</a> in order to load a list of Lines into my IList&lt;string&gt; Lines property:</p>
[code lang="xml"]<?xml version="1.0" encoding="utf-8" ?>
<d:Address
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:s="clr-namespace:System;assembly=mscorlib"
    xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo"
    xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo">
    <d:Address.Lines>
        <x:Array Type="s:String">
            <s:String>Ikaroslaan 21</s:String>
            <s:String>B-1930 Zaventem</s:String>
        </x:Array>
    </d:Address.Lines>
</d:Address>[/code]

<p>By default all XAML documents have all the data embedded. Sometimes this is undesirable so i decided to define External and ExternalList MarkupExtensions that allow us to specify that the resource is elsewhere available. Here is an example of Jeff  who has one address in a different file, Domain\Address\Leuven\Brusselsestraat_400.xaml:</p>

[code lang="xml"]<?xml version="1.0" encoding="utf-8" ?>
<d:Person
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:s="clr-namespace:System;assembly=mscorlib"
    xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo"
    xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo"
    Name="Jeff"
    Birthday="{e:DateTime 14/10/1972}">
  <d:Person.Addresses>
    <e:ExternalList Type="XamlDemo.Domain.Address">
      <e:ExternalList.Resources>
        <x:Array Type="s:String">
          <s:String>Domain.Address.Leuven.Brusselsestraat_400</s:String>
        </x:Array>
      </e:ExternalList.Resources>
    </e:ExternalList>
  </d:Person.Addresses>
</d:Person>[/code]

<p>It is also possible to have multiple redirections. Here is an example of Tim who has two addresses defined in Domain\Address\ForPerson\Tim.xaml:</p>

[code lang="xml"]<?xml version="1.0" encoding="utf-8" ?>
<d:Person
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:s="clr-namespace:System;assembly=mscorlib"
    xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo"
    xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo"
    Name="Tim"
    Birthday="{e:DateTime 30/04/1980}">
  <d:Person.Addresses>
    <e:External Type="XamlDemo.Domain.Address" Resource="Domain.Address.ForPerson.Tim" />
  </d:Person.Addresses>
</d:Person>[/code]

<p>And here is the definition for Domain\Address\ForPerson\Tim.xaml:</p>

[code lang="xml"]<?xml version="1.0" encoding="utf-8" ?>
<e:ExternalList
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:s="clr-namespace:System;assembly=mscorlib"
    xmlns:d="clr-namespace:XamlDemo.Domain;assembly=XamlDemo"
    xmlns:e="clr-namespace:XamlDemo.Infrastructure.Extensions;assembly=XamlDemo"
    Type="XamlDemo.Domain.Address">
  <e:ExternalList.Resources>
    <x:Array Type="s:String">
      <s:String>Domain.Address.Leuven.Bondgenotenlaan_14</s:String>
      <s:String>Domain.Address.Zaventem.Ikaroslaan_21</s:String>
    </x:Array>
  </e:ExternalList.Resources>
</e:ExternalList>[/code]

<p>Anyway, feel free to download the sample application, <a href="http://www.timvw.be/wp-content/code/csharp/XamlDemo.zip">XamlDemo.zip</a>.</p>