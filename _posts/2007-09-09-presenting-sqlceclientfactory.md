---
ID: 202
post_title: Presenting SqlCeClientFactory
author: timvw
post_date: 2007-09-09 16:15:41
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/09/09/presenting-sqlceclientfactory/
published: true
---
<p>Apart from Microsoft.SqlServerCe.Client.SqlCeClientFactory in Microsoft.SqlServerCe.Client (an undocumented and unsupported library) there is no DbProviderFactory for System.Data.SqlServerCe. Today i decided to write a SqlCeClientFactory:</p>
[code lang="csharp"]
public class SqlCeClientFactory : DbProviderFactory
{
 public static readonly SqlCeClientFactory Instance = new SqlCeClientFactory();

 public override DbCommand CreateCommand()
 {
  return new SqlCeCommand();
 }

 public override DbCommandBuilder CreateCommandBuilder()
 {
  return new SqlCeCommandBuilder();
 }

 public override DbConnection CreateConnection()
 {
  return new SqlCeConnection();
 }

 public override DbDataAdapter CreateDataAdapter()
 {
  return new SqlCeDataAdapter();
 }

 public override DbParameter CreateParameter()
 {
  return new SqlCeParameter();
 }
}[/code]
<p>As you can see, the implementation is trivial, so i still wonder why microsoft didn't provide it. Anyway, here is how our App.config would look like if we wanted to register and use the SqlCeClientFactory (we could also install the assembly in the GAC and edit machine.config so that all applications can take advantage of it):</p>
[code lang="xml"]<configuration>
 <connectionStrings>
  <add name="localdb" providerName="System.Data.SqlServerCe" connectionString="Data Source='localdb.sdf';"/>
 </connectionStrings>
 <system.data>
  <dbProviderFactories>
   <add name="SQL Server Everywhere Edition Data Provider"
        invariant="System.Data.SqlServerCe"
        description=".NET Framework Data Provider for Microsoft SQL Server Everywhere Edition"
        type="SqlCeApplication.SqlCeClientFactory, SqlCeApplication" />
  </dbProviderFactories>
 </system.data>
</configuration>[/code]
<p>And now we can use the <a href="http://www.timvw.be/helper-methods-for-dbconnection/">DbConnectionHelper</a> to create a DbConnection and do some work:</p>
[code lang="csharp"]
static void Main(string[] args)
{
 using (DbConnection conn = DbConnectionHelper.GetConnection("localdb"))
 {
  conn.Open();
  // do some work...
 }

 Console.Write("{0}Press any key to continue...", Environment.NewLine);
 Console.ReadKey();
}[/code]