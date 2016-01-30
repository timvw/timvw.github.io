---
ID: 1650
post_title: 'Presenting ValueType&lt;T&gt;'
author: timvw
post_date: 2010-01-28 19:27:34
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/01/28/presenting-valuetypet/
published: true
---
<p>Here is a base class for some code that i have written once too many in my life: (In case you're an early adaptor (.Net 4.0) you may want to use System.Tuple&lt;T1&gt; as base class)</p>

[code lang="csharp"]public class ValueType<t> : IComparable, IComparable<valueType<t>>, IEquatable<valueType<t>>
 where T : IComparable<t>
{
 protected T Value { get; private set; }public ValueType(T value)
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
  return Equals(obj as ValueType<t>);
 }

 public bool Equals(ValueType<t> other)
 {
  return Compare(this, other) == 0;
 }

 public int CompareTo(object obj)
 {
  return CompareTo(this, obj as ValueType<t>);
 }

 public int CompareTo(ValueType<t> other)
 {
  return Compare(this, other);
 }

 static int Compare(ValueType<t> instance1, ValueType<t> instance2)
 {
  if (ReferenceEquals(instance1, instance2)) return 0;
  if (ReferenceEquals(instance1, null)) return -1;
  if (ReferenceEquals(instance2, null)) return 1;

  if (ReferenceEquals(instance1.Value, instance2.Value)) return 0;
  if (ReferenceEquals(instance1.Value, null)) return -1;
  if (ReferenceEquals(instance2.Value, null)) return 1;

  return instance1.Value.CompareTo(instance2.Value);
 }

 public static bool operator ==(ValueType<t> instance1, ValueType<t> instance2)
 {
  return Compare(instance1, instance2) == 0;
 }

 public static bool operator !=(ValueType<t> instance1, ValueType<t> instance2)
 {
  return !(instance1 == instance2);
 }

 public static bool operator <(ValueType<t> instance1, ValueType<t> instance2)
 {
   return Compare(instance1, instance2) < 0;
 }

 public static bool operator >(ValueType<t> instance1, ValueType<t> instance2)
 {
   return Compare(instance1, instance2) > 0;
 }
}[/code]