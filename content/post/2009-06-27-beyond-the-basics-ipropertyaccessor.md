---
date: "2009-06-27T00:00:00Z"
guid: http://www.timvw.be/?p=1091
tags:
- NHibernate
title: 'Beyond the basics: IPropertyAccessor'
aliases:
 - /2009/06/27/beyond-the-basics-ipropertyaccessor/
 - /2009/06/27/beyond-the-basics-ipropertyaccessor.html
---
Consider the following classes: an abstract Account and a concrete SavingAccount

```csharp
abstract class Account
{
	int Id { get; protected set; }
	int CustomerId { get; protected set; }
	abstract AccountType Type { get; }
}

class SavingAccount : Account, ISavingAccount
{
	private SavingAccount() { }
	public SavingAccount(int customerId) { CustomerId = customerId; }
	public override AccountType Type { get { return AccountType.SavingAccount; } }
}
```

And this is the schema on which we want to map these classes

![screenshot of accounts schema](http://www.timvw.be/wp-content/images/accounts_schema.png)

We define a [Fluent](http://fluentnhibernate.org/) NHibernate mapping as following:

```csharp
public class AccountMap : ClassMap<account>
{
	public AccountMap()
	{
		WithTable("Accounts");
		Id(a => a.Id).ColumnName("account_id");
		Map(a => a.CustomerId).ColumnName("customer_id");
		Map(a => a.Type).ColumnName("account_type");
		SetAttribute("lazy", "false");

		JoinedSubClass<savingAccount>("saving\_account\_id", MapSavingAccount);
	}

	public void MapSavingAccount(JoinedSubClassPart<savingAccount> jscp)
	{
		jscp.WithTableName("SavingAccounts");
		jscp.SetAttribute("lazy", "false");
	}
}
```

As soon as we try to use this mapping we run into an "Could not find a setter for property 'Type' in class 'Banking.Domain.CheckingAccount" exception. A quick look with reflector teaches us there are a couple of strategies, but none of them suits our needs.

![screenshot of available property accessors in NHibernate assembly](http://www.timvw.be/wp-content/images/accounts_property_accessors.png)

Thus we decide to implement a custom PropertyAccessor as following

```csharp
public class ReadOnlyProperty : IPropertyAccessor
{
	public bool CanAccessTroughReflectionOptimizer
	{
		get { return false; }
	}

	public IGetter GetGetter(Type theClass, string propertyName)
	{
		var basicPropertyAccessor = new BasicPropertyAccessor();
		var getter = basicPropertyAccessor.GetGetter(theClass, propertyName);
		return getter;
	}

	public ISetter GetSetter(Type theClass, string propertyName)
	{
		var setter = new NoOpSetter();
		return setter;
	}

	public class NoOpSetter : ISetter
	{
		public MethodInfo Method { get { return null; } }
		public string PropertyName { get { return null; } }
		public void Set(object target, object value) { }
	}
}
```

And now we can instruct NHibernate to use our custom PropertyAccessor as following:

```csharp
public AccountMap()
{
	...
	Map(a => a.Type).Access.Using<readOnlyProperty>().ColumnName("account_type");
	...
}
```

A couple of searches later it appears that [this problem had already been solved](http://blog.schuager.com/2008/12/nhibernate-read-only-property-access.html), but is not available in the version of NHibernate that comes with Fluent NHibernate. Oh well, we learned something new.
