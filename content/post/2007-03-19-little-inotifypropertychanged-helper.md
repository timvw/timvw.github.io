---
date: "2007-03-19T00:00:00Z"
tags:
- C#
- Windows Forms
title: Little INotifyPropertyChanged helper
aliases:
 - /2007/03/19/little-inotifypropertychanged-helper/
 - /2007/03/19/little-inotifypropertychanged-helper.html
---
Most implementations of INotifyPropertyChanged look as following (notice that you have to make sure that the hardcoded PropertyName is spelled correctly)

```csharp
class MyClass : INotifyPropertyChanged
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
}
```

Everytime you refactor a property you also have to make sure to refactor the string with it's name in the setter method. Here's a helper method that makes life a little easier

```csharp
protected void OnPropertyChanged()
{
	this.OnPropertyChanged(new StackTrace(false).GetFrame(1).GetMethod().Name.Substring(4));
}
```

This makes the implementation of a property as simple as (No more hardcoded strings to maintain)

```csharp 
public int X
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
}
```
