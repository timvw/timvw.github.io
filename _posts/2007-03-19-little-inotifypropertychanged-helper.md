---
ID: 156
post_title: Little INotifyPropertyChanged helper
author: timvw
post_date: 2007-03-19 10:58:53
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/03/19/little-inotifypropertychanged-helper/
published: true
---
<p>Most implementations of INotifyPropertyChanged look as following (notice that you have to make sure that the hardcoded PropertyName is spelled correctly):</p>
[code lang="csharp"]class MyClass : INotifyPropertyChanged
{
 public event PropertyChangedEventHandler PropertyChanged;

 private int x;

 public int X
 {
  get { return this.x; }
  set
  {
   if (this.x != value)
   {
    this.x = value;
    this.OnPropertyChanged("X");
   }
  }
 }

 [MethodImpl(MethodImplOptions.NoInlining)]
 private void Fire(Delegate del, params object[] args)
 {
  if (del != null)
  {
   foreach (Delegate sink in del.GetInvocationList())
   {
    try { sink.DynamicInvoke(args); }
    catch { }
   }
  }
 }

 protected virtual void OnPropertyChanged( string propertyName )
 {
  this.Fire( this.PropertyChanged, new PropertyChangedEventArgs( propertyName ) );
 }
}[/code]
<p>Everytime you refactor a property you also have to make sure to refactor the string with it's name in the setter method. Here's a helper method that makes life a little easier:</p>
[code lang="csharp"]
protected void OnPropertyChanged()
{
 this.OnPropertyChanged(new StackTrace(false).GetFrame(1).GetMethod().Name.Substring(4));
}[/code]
<p>This makes the implementation of a property as simple as (No more hardcoded strings to maintain):</p>
[code lang="csharp"] public int X
{
 get { return this.x; }
 set
 {
  if (this.x != value)
  {
   this.x = value;
   this.OnPropertyChanged();
  }
 }
}[/code]