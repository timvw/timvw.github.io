---
ID: 1417
post_title: About databinding and composite views
author: timvw
post_date: 2009-10-13 16:44:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/13/about-databinding-and-composite-views/
published: true
---
<p>A couple of days ago i had a databound ItemsControl (collection of Model.Cell) which instantiated sub views (with their own viewmodel).</p>

[code lang="xml"><grid x:Name="LayoutRoot"]
 <grid.Resources>
  <dataTemplate x:Key="CellTemplate">
   <views:CellView />
  </dataTemplate>
 </grid.Resources>
 <itemsControl
   ItemTemplate="{StaticResource CellTemplate}"
   ItemsSource="{Binding Cells}" />
</grid>[/code]

<p>Because each CellViewModel needs to know which cell they manage i used the following dirty hack:</p>

[code lang="csharp"]public CellView()
{
 Loaded += CellView_Loaded;
}

void CellView_Loaded(object sender, RoutedEventArgs e)
{
 DataContext = new CellViewModel(DataContext);
}[/code]

<p>Later on that day i realised there was a much cleaner solution: Let the BoardViewModel expose a collection of ViewModels.CellViewModel instead of Model.Cell. What a relief that i don't have to use the Loaded event hack :)</p>