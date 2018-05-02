---
id: 186
title: Helper methods for DbProviderFactory
date: 2007-08-07T01:12:47+00:00
author: timvw
layout: post
guid: http://www.timvw.be/helper-methods-for-dbconnection/
permalink: /2007/08/07/helper-methods-for-dbconnection/
tags:
  - 'C#'
---
Here are a couple of functions that make it easier to take advantage of the DbProviderFactory to create DbConnections

```csharp
public DbConnection GetDbConnection(string connectionStringName)
{
	return GetDbConnection(ConfigurationManager.ConnectionStrings[connectionStringName]);
}

public DbConnection GetDbConnection(ConnectionStringSettings connectionStringSettings)
{
	return GetDbConnection(connectionStringSettings.ProviderName, connectionStringSettings.ConnectionString);
}

public DbConnection GetDbConnection(string providerInvariantName, string connectionString)
{
	DbConnection connection = DbProviderFactories.GetFactory(providerInvariantName).CreateConnection();
	connection.ConnectionString = connectionString;
	return connection;
}
```

Using these functions, the pattern for querying a database could be something as following:

```csharp
using (DbConnection conn = GetDbConnection("Local_Northwind"))
{
	conn.Open();

	using (DbCommand cmd = conn.CreateCommand())
	{
		cmd.CommandText = "SELECT EmployeeID, FirstName, LastName FROM Employees";
		using (DbDataReader reader = cmd.ExecuteReader())
		{
			// process the result
		}
	}
}
```
