---
title: ConcurrencyCheck with EF/Devart on Oracle
layout: post
guid: http://www.timvw.be/?p=2461
categories:
  - Uncategorized
---
Earlier this week I was wondering how I could easily achieve optimistic concurrency in a system using EF/Devart targetting an Oracle database (Not really my preferred technologies, but whatever:P). Here is a potential solution:

Using a column for optimistic concurrency is documented on the devart website:

```csharp
[Table("TEST")]
public class Test : IRequireConcurrencyCheck  
{
	...
	[Required]
	[Column("VERSION")]
	[ConcurrencyCheck] // TELL EF to use this column as our "timestamp/logical version"
	public virtual int Version { get; protected set; } // protected, so users of this type can not touch this (easily)
}
```

By introducing an interface that exposes a version number like below:

```csharp
public interface IRequireConcurrencyCheck
{
	int Version { get; } 
}
```

With some custom behaviour on SaveChanges we can now take away the burden of having to update the Version property correctly:

```csharp 
public class DataContext : DbContext
{
	public DataContext(DbConnection existingConnection)  
		: base(existingConnection, true)    
	{ 
		Database.SetInitializer<DataContext>(null);
	}

	public override int SaveChanges()
	{
		var = ChangeTracker        
			.Entries<IRequireConcurrencyCheck>()
			.Where(x => x.State == EntityState.Modified)	
			.ToArray();

		foreach (var entity in entitiesWhichHaveConcurrencyCheck)
		{
			entity.Property<int>(x => x.Version).CurrentValue++;  
		}

		return base.SaveChanges();
	}

	public IDbSet<Test> Tests { get; set; }
}
```