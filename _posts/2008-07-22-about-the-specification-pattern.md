---
ID: 269
post_title: About the Specification pattern
author: timvw
post_date: 2008-07-22 17:32:09
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/07/22/about-the-specification-pattern/
published: true
---
<p>A couple of days ago i mentionned <a href="http://www.goeleven.com">Yves Goeleven's blog</a> as a reference for solutions using <a href="http://en.wikipedia.org/wiki/Domain-driven_design">DDD</a> principles. Let's have a look at his implementation of the AndSpecification and OrSpecification in <a href="http://www.goeleven.com/blog/entryDetail.aspx?entry=57">Design Patterns - The Specification Pattern - Part I</a>:</p>

[code lang="csharp"]class AndSpecification<t> : CompositeSpecification<t>
{
 public override bool IsSatisfiedBy(T candidate)
 {
  bool isSatisfied = true;
  foreach( ISpecification<t> spec in Specifications)
  {
   isSatisfied &= spec.IsSatisfiedBy(candidate);
  }
  return isSatisfied;
 }
}
class OrSpecification<t> : CompositeSpecification<t>
{
 public override bool IsSatisfiedBy(T obj)
 {
  bool isSatisfied = false;
  foreach( ISpecification<t> spec in Specifications)
  {
   isSatisfied |= spec.IsSatisfiedBy(obj);
  }
  return isSatisfied;
 }
}[/code]

<p>I believe that it would be better if the implementations had the same lazy evaluation behaviour as the C# &amp;&amp; and || operators. Eg: in C# one can write (a && b) and if a evaluates to false, then b is not evaluated anymore. Consider the following code:</p>

[code lang="csharp"]
if (person != null && person.Age > 18) { }
[/code]

<p>Let's rewrite that same code using Specifications:</p>

[code lang="csharp"]
class NotNullSpecification<t> : ISpecification<t>
 where T : class
{
 public bool IsSatisfiedBy(T item)
 {
  return item != null;
 }
}

class OlderThanSpecification : ISpecification<person>
{
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
[/code]

<p>Using the mentionned AndSpecification implementation the following unittest will fail:</p>

[code lang="csharp"][TestMethod]
public void TestPersonNotNullAndOlderThan18Specification()
{
 Person person = null;

 ISpecification<person> specification = new PersonNotNullAndOlderThan18Specifictation();
 Assert.IsFalse(specification.IsSatisfiedBy(person));
}[/code]

<p>In order to make that test pass we could rewrite the specifications as following:</p>

[code lang="csharp"]public abstract class CompositeSpecification<t> : ISpecification<t>
{
 private readonly IEnumerable<ispecification<t>> specifications;

 public CompositeSpecification(IEnumerable<ispecification<t>> specifications)
 {
  this.specifications = specifications;
 }

 protected IEnumerable<ispecification<t>> Specifications
 {
  get { return this.specifications; }
 }

 abstract public bool IsSatisfiedBy(T item);
}

public class AndSpecification<t> : CompositeSpecification<t>
{
 public AndSpecification(IEnumerable<ispecification<t>> specifications)
  :base(specifications)
 { }

 override public bool IsSatisfiedBy(T item)
 {
  foreach (ISpecification<t> specification in this.Specifications)
  {
   if (!specification.IsSatisfiedBy(item))
   {
    return false;
   }
  }

  return true;
 }
}

public class OrSpecification<t> : CompositeSpecification<t>
{
 public OrSpecification(IEnumerable<ispecification<t>> specifications)
  : base(specifications)
 { }

 override public bool IsSatisfiedBy(T item)
 {
  foreach (ISpecification<t> specification in this.Specifications)
  {
   if (specification.IsSatisfiedBy(item))
   {
    return true;
   }
  }

  return false;
 }
}[/code]