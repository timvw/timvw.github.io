---
ID: 303
post_title: NHibernate SessionFactory configuration
author: timvw
post_date: 2008-07-28 17:03:36
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/07/28/nhibernate-sessionfactory-configuration/
published: true
dsq_thread_id:
  - "1928261292"
---
<p>My preferred way for configuring <a href="http://www.nhibernate.org">NHibernate</a> is as following:</p>

<ul>
<li>Create a hibernate.cfg.xml file for session-factory settings.</li>
<li>Add mapping files, named type.hbm.xml, as embedded resources to the library project that implements the repository.</li>
</ul>

<p>When i looked at the <a href="http://www.hibernate.org/hib_docs/nhibernate/1.2/reference/en/html_single/#configuration-programmatic">documentation</a> i found the following:</p>

<blockquote>
<p>Another alternative (probably the best) way is to let NHibernate load all of the mapping files contained in an Assembly:</p>
[code lang="csharp"]Configuration cfg = new Configuration();
  .AddAssembly( "NHibernate.Auction" );[/code]
</blockquote>

<p>Whenever i tried that code i received an InvalidOperationException: Could not find the dialect in the configuration. In order to make the configuration work the way i prefer you have to do the following:</p>

[code lang="csharp"]Configuration cfg = new Configuration().Configure();
cfg.AddAssembly(typeof(MyRepository).Assembly);[/code]

<p>Another attention point is the fact that i believe that all connectionStrings belong in App.Config. This can be realised by using the connection.connection_string_name attribute:</p>

[code lang="xml"]<?xml version="1.0" encoding="utf-8" ?>
<hibernate-configuration xmlns="urn:nhibernate-configuration-2.2">
 <session-factory>
  <property name="connection.provider">NHibernate.Connection.DriverConnectionProvider</property
  <property name="dialect">NHibernate.Dialect.MsSql2005Dialect</property>
  <property name="connection.driver_class">NHibernate.Driver.SqlClientDriver</property>
  <property name="connection.connection_string_name">AdventureWorks</property>
 </session-factory>
</hibernate-configuration>[/code]