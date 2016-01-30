---
ID: 186
post_title: Helper methods for DbProviderFactory
author: timvw
post_date: 2007-08-07 01:12:47
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/07/helper-methods-for-dbconnection/
published: true
---
<p>Here are a couple of functions that make it easier to take advantage of the DbProviderFactory to create DbConnections:</p>
[code lang="csharp"]public DbConnection GetDbConnection(string connectionStringName)
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
}[/code]
<p>Using these functions, the pattern for querying a database could be something as following:</p>
[code lang="csharp"]using (DbConnection conn = GetDbConnection("Local_Northwind"))
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
}[/code]