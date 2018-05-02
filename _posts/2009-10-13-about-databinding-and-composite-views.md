---
id: 1417
title: About databinding and composite views
date: 2009-10-13T16:44:43+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1417
permalink: /2009/10/13/about-databinding-and-composite-views/
tags:
  - Patterns
  - Silverlight
  - WPF
---
A couple of days ago i had a databound ItemsControl (collection of Model.Cell) which instantiated sub views (with their own viewmodel).

```xml 
<grid>
	<grid.Resources>
		<dataTemplate x:Key="CellTemplate">
			<views:CellView />
		</dataTemplate>
	</grid.Resources>
	<itemsControl ItemTemplate="{StaticResource CellTemplate}" ItemsSource="{Binding Cells}" />
</grid>
```

Because each CellViewModel needs to know which cell they manage i used the following dirty hack

```csharp
public CellView()
{
	Loaded += CellView_Loaded;
}

void CellView_Loaded(object sender, RoutedEventArgs e)
{
	DataContext = new CellViewModel(DataContext);
}
```

Later on that day i realised there was a much cleaner solution: Let the BoardViewModel expose a collection of ViewModels.CellViewModel instead of Model.Cell. What a relief that i don't have to use the Loaded event hack.
