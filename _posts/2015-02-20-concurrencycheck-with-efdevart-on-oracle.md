---
ID: 2461
post_title: >
  ConcurrencyCheck with EF/Devart on
  Oracle
author: timvw
post_date: 2015-02-20 10:57:59
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2015/02/20/concurrencycheck-with-efdevart-on-oracle/
published: true
---
<p>Earlier this week I was wondering how I could easily achieve optimistic concurrency in a system using EF/Devart targetting an Oracle database (Not really my preferred technologies, but whatever... :P). Here is a potential solution:</p>

<p>Using a column for optimistic concurrency is documented on the devart website:</p>

[code lang="csharp"]
[Table(&quot;TEST&quot;)]
public class Test : IRequireConcurrencyCheck
{
  ..
  [Required]
  [Column(&quot;VERSION&quot;)]
  [ConcurrencyCheck] // &lt;-- TELL EF to use this column as our &quot;timestamp/logical version&quot;
  public virtual int Version { get; protected set; } // protected, so users of this type can not touch this (easily)
}
[/code]

<p>By introducing an interface and some custom behaviour on SaveChanges we can now take away the burden of having to update the Version property correctly:</p>

[code lang="csharp"]
public interface IRequireConcurrencyCheck
{
  int Version { get; }
}
[/code]

[code lang="csharp"]
public class DataContext : DbContext
{
  public DataContext(DbConnection existingConnection)
    : base(existingConnection, true)
  {
    Database.SetInitializer&lt;DataContext&gt;(null);
  }

  public override int SaveChanges()
  {
    var = ChangeTracker
      .Entries&lt;IRequireConcurrencyCheck&gt;()
      .Where(x =&gt; x.State == EntityState.Modified)
      .ToArray();

    foreach (var entity in entitiesWhichHaveConcurrencyCheck)
    {
      entity.Property&lt;int&gt;(x =&gt; x.Version).CurrentValue++;
    }

    return base.SaveChanges();
  }

  public IDbSet&lt;Test&gt; Tests { get; set; }
}
[/code]