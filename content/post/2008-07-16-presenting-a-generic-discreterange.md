---
date: "2008-07-16T00:00:00Z"
guid: http://www.timvw.be/?p=242
tags:
- Patterns
title: Presenting a generic DiscreteValuesRange
aliases:
 - /2008/07/16/presenting-a-generic-discreterange/
 - /2008/07/16/presenting-a-generic-discreterange.html
---
Let me start with a real world example demonstrating the usefulness of a generic DiscreteValuesRange. Imagine that i run a grid computing business and my clients want to book capacity on the grid for a given period. Before their booking is approved, i have to verify that the client has contracts that allow him to use the system for each day of the booking period. Usually, such a check is implemented as following

```csharp
bool CheckEachDayIsCovered(Booking booking, Client client)
{
	DateRange periodToCheck = booking.Period;
	DateTime endOfTime = new DateTime(9999, 12, 31);

	DateTime dayToCheck = periodToCheck.Begin;
	while (dayToCheck <= periodToCheck.End) 
	{ 
		bool dayIsCovered = false; 
		foreach (Contract contract in client.Contracts) 
		{ 
			if (contract.Period.Includes(dayToCheck)) 
			{ 
				dayIsCovered = true; 
				if (contract.Period.End < endOfTime) 
				{ 
					dayToCheck = contract.Period.End.AddDays(1); 
				} 
				else 
				{ 
					return true; 
				} 
			} 
		} 
		if (!dayIsCovered) 
		{ 
			return false; 
		} 
	} 
	return true; 
}
``` 

After a while clients want to buy licenses for only a couple of hours instead of a full day. I realise that my check can remain the same, but that the concept "EndOfTime" has become DateTime(9999, 12, 31, 23, 59, 59) and that i can advance only an hour instead of a day. Since i want to reuse my code i define the IDiscreteValueProvider<T> interface (See [Discrete Space](http://en.wikipedia.org/wiki/Discrete_space))

```csharp
interface IDiscreteValuesProvider<T>
{
	T GetNextValue(T value);
	T MaxValue { get; }
}
```

After this i'm able to implement a DiscreteValuesRange<T> that implements the following interface (See: [Generic Range](http://www.timvw.be/presenting-a-generic-range/))

```csharp
interface IDiscreteValuesRange<T> : IRange<T>
{
	bool IsCoveredByRanges(IEnumerable<idiscreteValuesRange<T>> ranges);
}
```

Now, with all this infrastructure i can rewrite my original method as following:

```csharp
bool CheckEachDayIsCovered(Booking booking, Client client)
{
	return booking.Period.IsCoveredByRanges(client.GetContractPeriods());
}

class Client
{
	...
	IEnumerable<range<dateTime>> GetContractPeriods()
	{
		foreach (Contract contract in this.Contracts)
		{
			yield return contract.Period;
		}
	}
}
```

Feel free to download all this infrastructure: [DiscreteRange.zip](http://www.timvw.be/wp-content/code/csharp/DiscreteRange.zip) and use it for your next coverage check.
