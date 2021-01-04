---
date: "2008-07-28T00:00:00Z"
guid: http://www.timvw.be/?p=303
tags:
- CSharp
title: NHibernate SessionFactory configuration
aliases:
 - /2008/07/28/nhibernate-sessionfactory-configuration/
 - /2008/07/28/nhibernate-sessionfactory-configuration.html
---
My preferred way for configuring [NHibernate](http://www.nhibernate.org) is as following

* Create a hibernate.cfg.xml file for session-factory settings.
* Add mapping files, named type.hbm.xml, as embedded resources to the library project that implements the repository.

When i looked at the [documentation](http://www.hibernate.org/hib_docs/nhibernate/1.2/reference/en/html_single/#configuration-programmatic) i found the following

> Another alternative (probably the best) way is to let NHibernate load all of the mapping files contained in an Assembly:

```csharp
Configuration cfg = new Configuration(); 
cfg.AddAssembly( "NHibernate.Auction" );
``` 

Whenever i tried that code i received an InvalidOperationException: Could not find the dialect in the configuration. In order to make the configuration work the way i prefer you have to do the following

```csharp
Configuration cfg = new Configuration().Configure();
cfg.AddAssembly(typeof(MyRepository).Assembly);
```

Another attention point is the fact that i believe that all connectionStrings belong in App.Config. This can be realised by using the connection.connection_string_name attribute

```xml
<?xml version="1.0" encoding="utf-8" ?>
<hibernate-configuration xmlns="urn:nhibernate-configuration-2.2">
	<session-factory> 
		<property name="connection.provider">NHibernate.Connection.DriverConnectionProvider</property>
		<property name="dialect">NHibernate.Dialect.MsSql2005Dialect</property> 
		<property name="connection.driver_class">NHibernate.Driver.SqlClientDriver</property> 
		<property name="connection.connection_string_name">AdventureWorks</property> 
	</session-factory>
</hibernate-configuration>
```
