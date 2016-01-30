---
ID: 1091
post_title: 'Beyond the basics: IPropertyAccessor'
author: timvw
post_date: 2009-06-27 15:51:20
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/06/27/beyond-the-basics-ipropertyaccessor/
published: true
---
<p>Consider the following classes: an abstract Account and a concrete SavingAccount</p>

[code lang="csharp"]abstract class Account
{
 int Id { get; protected set; }
 int CustomerId { get; protected set; }
 abstract AccountType Type { get; }
}

class SavingAccount : Account, ISavingAccount
{
 private SavingAccount() { }
 public SavingAccount(int customerId) {  CustomerId = customerId; }
 public override AccountType Type { get { return AccountType.SavingAccount; } }
}[/code]

<p>And this is the schema on which we want to map these classes:</p>

<img src="http://www.timvw.be/wp-content/images/accounts_schema.png" alt="screenshot of accounts schema" />

<p>We define a <a href="http://fluentnhibernate.org/">Fluent</a> NHibernate mapping as following:</p>

[code lang="csharp"]public class AccountMap : ClassMap<account>
{
 public AccountMap()
 {
  WithTable("Accounts");
  Id(a => a.Id).ColumnName("account_id");
  Map(a => a.CustomerId).ColumnName("customer_id");
  Map(a => a.Type).ColumnName("account_type");
  SetAttribute("lazy", "false");

  JoinedSubClass<savingAccount>("saving_account_id", MapSavingAccount);
 }

 public void MapSavingAccount(JoinedSubClassPart<savingAccount> jscp)
 {
  jscp.WithTableName("SavingAccounts");
  jscp.SetAttribute("lazy", "false");
 }
}[/code]

<p>As soon as we try to use this mapping we run into an "Could not find a setter for property 'Type' in class 'Banking.Domain.CheckingAccount" exception. A quick look with reflector teaches us there are a couple of strategies, but none of them suits our needs.</p>

<img src="http://www.timvw.be/wp-content/images/accounts_property_accessors.png" alt="screenshot of available property accessors in NHibernate assembly" />

<p>Thus we decide to implement a custom PropertyAccessor as following:</p>

[code lang="csharp"]public class ReadOnlyProperty : IPropertyAccessor
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
}[/code]

<p>And now we can instruct NHibernate to use our custom PropertyAccessor as following:</p>

[code lang="csharp"]public AccountMap()
{
 ...
 Map(a => a.Type).Access.Using<readOnlyProperty>().ColumnName("account_type");
 ...
}[/code]

<p>A couple of searches later it appears that <a href="http://blog.schuager.com/2008/12/nhibernate-read-only-property-access.html">this problem had already been solved</a>, but is not available in the version of NHibernate that comes with Fluent NHibernate. Oh well, we learned something new ;)</p>