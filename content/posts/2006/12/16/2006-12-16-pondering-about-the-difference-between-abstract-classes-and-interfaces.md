---
date: "2006-12-16T00:00:00Z"
tags:
- CSharp
title: Pondering about the difference between abstract classes and interfaces
aliases:
 - /2006/12/16/pondering-about-the-difference-between-abstract-classes-and-interfaces/
 - /2006/12/16/pondering-about-the-difference-between-abstract-classes-and-interfaces.html
---
Back in May i was asked to explain the difference between an [interface](http://msdn.microsoft.com/library/en-us/csref/html/vcreftheinterfacetype.asp) and an [abstract class](http://msdn.microsoft.com/library/en-us/csspec/html/vclrfcsharpspec_10_1_1_1.asp) at a job interview. Obviously the interviewer wanted me to tell him that an abstract class allows you to provide a partial implementation... I answered that the major difference is the fact that with interface-based programming you're not forced into an inheritance tree that might not make sense and that i didn't see much use for abstract classes (I'm not sure he saw that one coming :P). For some unknown reason this kept spinning in my head... Here's an example of an abstract class and a concrete implementation

```csharp
abstract class FooAbstract
{
	public void DoX()
	{
		DoY();
	}

	protected abstract void DoY();
}

class FooConcrete : FooAbstract
{
	protected override void DoY()
	{
		Console.WriteLine("FooConcrete does Y");
	}
}
```

I find the interface-based implementation below a lot cleaner because it still provides the partial implementation but a concrete implementation is not forced into the inheritance relationship anymore. Another advantage is that the implementation only depends on the interface (the unimplemented parts) so you get some looser coupling than with abstract classes. A disadvantage is that an interface requires you to make all the unimplemented methods public

```csharp
class Foo
{
	private IAbstract myAbstract;

	public Foo(IAbstract myAbstract)
	{
		if (myAbstract == null)
		{
			throw new ArgumentNullException();
		}

		this.myAbstract = myAbstract;
	}

	public void DoX()
	{
		this.myAbstract.DoY();
	}
}

interface IAbstract
{
	void DoY();
}

class Concrete : IAbstract
{
	public void DoY()
	{
		Console.WriteLine("Concrete does Y");
	}
}
```

Conclusion: I still don't see much use for abstract classes.
