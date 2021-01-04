---
date: "2006-08-26T00:00:00Z"
tags:
- CSharp
title: Unable to enlist in a distributed transaction
---
Earlier today we were confronted with the following [OracleException](http://msdn2.microsoft.com/en-US/library/system.data.oracleclient.oracleexception.aspx): **Unable to enlist in a distributed transaction**. Our code (and accompanying tests) had been running fine for the last two weeks thus we expected there was a problem with the database. A member of the DBA team assurred us there was nothing wrong with the database. Finally we discovered that we had created a circular reference and thus the program ended up in an endless loop (well untill the database decided it had been enough anyway :p). Here is a simplified version of the problem

```csharp
public void DoA() 
{
	using (TransactionScope scope = new TransactionScope()) 
	{
		using (OracleConnection con = new OracleConnection(connectionString)) 
		{
			con.Open();
			DoB();
			scope.Complete();
		}
	}
}

public void DoB() 
{
	using (TransactionScope scope = new TransactionScope()) 
	{
		using (OracleConnection con = new OracleConnection(connectionString)) 
		{
			con.Open();
			DoA();
			scope.Complete();
		}
	}
}
```

Without the use of [TransactionScope](http://msdn2.microsoft.com/en-us/library/system.transactions.transactionscope.aspx) this results in a **Connection request timed out** exception.
