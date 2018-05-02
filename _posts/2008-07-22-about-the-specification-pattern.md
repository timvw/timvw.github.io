---
id: 269
title: About the Specification pattern
date: 2008-07-22T17:32:09+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=269
permalink: /2008/07/22/about-the-specification-pattern/
tags:
  - Patterns
---
A couple of days ago i mentionned [Yves Goeleven's blog](http://www.goeleven.com) as a reference for solutions using [DDD](http://en.wikipedia.org/wiki/Domain-driven_design) principles. Let's have a look at his implementation of the AndSpecification and OrSpecification in [Design Patterns -- The Specification Pattern -- Part I](http://www.goeleven.com/blog/entryDetail.aspx?entry=57)

```csharp
class AndSpecification<T> : CompositeSpecification<T>
{
	public override bool IsSatisfiedBy(T candidate)
	{
		bool isSatisfied = true;
		foreach( ISpecification<T> spec in Specifications)
		{
			isSatisfied &= spec.IsSatisfiedBy(candidate);
		}
		return isSatisfied;
	}
}

class OrSpecification<T> : CompositeSpecification<T>
{
	public override bool IsSatisfiedBy(T obj)
	{
		bool isSatisfied = false;
		foreach( ISpecification<T> spec in Specifications)
		{
			isSatisfied |= spec.IsSatisfiedBy(obj);
		}
		return isSatisfied;
	}
}
```

I believe that it would be better if the implementations had the same lazy evaluation behaviour as the C# && and || operators. Eg: in C# one can write (a && b) and if a evaluates to false, then b is not evaluated anymore. Consider the following code

```csharp
if (person != null && person.Age > 18) { }
```

Let's rewrite that same code using Specifications

```csharp
class NotNullSpecification<T> : ISpecification<T> where T : class
{
	public bool IsSatisfiedBy(T item)
	{
		return item != null;
	}
}

class OlderThanSpecification : ISpecification<person> {
	private int age;

	public OlderThanSpecification(int age)
	{
		this.age = age;
	}

	public bool IsSatisfiedBy(Person person)
	{
		return person.Age > this.age;
	}
}

class PersonNotNullAndOlderThan18Specification : AndSpecification<person> 
{
	public PersonNotNullAndOlderThan18Specification()
	: base(new NotNullSpecification<person>(), new OlderThanSpecification(18))
	{
	}
}
```

Using the mentionned AndSpecification implementation the following unittest will fail

```csharp
[TestMethod]
public void TestPersonNotNullAndOlderThan18Specification()
{
	Person person = null;

	ISpecification<person> specification = new PersonNotNullAndOlderThan18Specifictation();
	Assert.IsFalse(specification.IsSatisfiedBy(person));
}
```

In order to make that test pass we could rewrite the specifications as following

```csharp
public abstract class CompositeSpecification<T> : ISpecification<T>
{
	private readonly IEnumerable<ispecification<T>> specifications;

	public CompositeSpecification(IEnumerable<ispecification<T>> specifications)
	{
		this.specifications = specifications;
	}

	protected IEnumerable<ispecification<T>> Specifications
	{
		get { return this.specifications; }
	}

	abstract public bool IsSatisfiedBy(T item);
}

public class AndSpecification<T> : CompositeSpecification<T>
{
	public AndSpecification(IEnumerable<ispecification<T>> specifications)
	:base(specifications)
	{ }

	override public bool IsSatisfiedBy(T item)
	{
		foreach (ISpecification<T> specification in this.Specifications)
		{
			if (!specification.IsSatisfiedBy(item))
			{
			return false;
			}
		}

		return true;
	}
}

public class OrSpecification<T> : CompositeSpecification<T>
{
	public OrSpecification(IEnumerable<ispecification<T>> specifications)
	: base(specifications)
	{ }

	override public bool IsSatisfiedBy(T item)
	{
		foreach (ISpecification<T> specification in this.Specifications)
		{
			if (specification.IsSatisfiedBy(item))
			{
				return true;
			}
		}

		return false;
	}
}
```
