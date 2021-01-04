---
date: "2010-01-28T00:00:00Z"
guid: http://www.timvw.be/?p=1650
tags:
- CSharp
- Patterns
title: Presenting ValueType<T>
aliases:
 - /2010/01/28/presenting-valuetypet/
 - /2010/01/28/presenting-valuetypet.html
---
Here is a base class for some code that i have written once too many in my life: (In case you're an early adaptor (.Net 4.0) you may want to use System.Tuple<T1> as base class)

```csharp
public class ValueType<T> : IComparable, IComparable<valueType<T>>, IEquatable<valueType<T>> where T : IComparable<T>
{
	protected T Value { get; private set; }
	
	public ValueType(T value)
	{
		Value = value;
	}

	public override int GetHashCode()
	{
		return Value.GetHashCode();
	}

	public override string ToString()
	{
		return Value.ToString();
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as ValueType<T>);
	}

	public bool Equals(ValueType<T> other)
	{
		return Compare(this, other) == 0;
	}

	public int CompareTo(object obj)
	{
		return CompareTo(this, obj as ValueType<T>);
	}

	public int CompareTo(ValueType<T> other)
	{
		return Compare(this, other);
	}

	static int Compare(ValueType<T> instance1, ValueType<T> instance2)
	{
		if (ReferenceEquals(instance1, instance2)) return 0;
		if (ReferenceEquals(instance1, null)) return -1;
		if (ReferenceEquals(instance2, null)) return 1;

		if (ReferenceEquals(instance1.Value, instance2.Value)) return 0;
		if (ReferenceEquals(instance1.Value, null)) return -1;
		if (ReferenceEquals(instance2.Value, null)) return 1;

		return instance1.Value.CompareTo(instance2.Value);
	}

	public static bool operator ==(ValueType<T> instance1, ValueType<T> instance2)
	{
		return Compare(instance1, instance2) == 0;
	}

	public static bool operator !=(ValueType<T> instance1, ValueType<T> instance2)
	{
		return !(instance1 == instance2);
	}

	public static bool operator <(ValueType<T> instance1, ValueType<T> instance2)
	{
		return Compare(instance1, instance2) < 0; 
	} 
		public static bool operator >(ValueType<T> instance1, ValueType<T> instance2)
	{
		return Compare(instance1, instance2) > 0;
	}
}
```
