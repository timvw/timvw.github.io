---
ID: 359
post_title: Presenting NameValueCollectionHelper
author: timvw
post_date: 2008-08-08 19:22:31
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/08/presenting-namevaluecollectionhelper/
published: true
dsq_thread_id:
  - "1925951007"
---
<p>Here are a couple functions that i find extremely useful when i'm working with a <a href="http://msdn.microsoft.com/en-us/library/system.collections.specialized.namevaluecollection.aspx">NameValueCollection</a>:</p>
[code lang="csharp"]public static class NameValueCollectionHelper
{
 public static void AddOrIgnoreOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
 public static void AddOrReplaceOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
 public static void AddOrCombineOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd);
 public static void AddOrFailOnDuplicateKey(NameValueCollection collection, NameValueCollection nameValuesToAdd)
}[/code]
<p>All these methods provide a specific scenario of the more generic Add operation:</p>
[code lang="csharp"] public static class NameValueCollectionHelper
{
 private static Dictionary<duplicateKeyBehavior, Action<nameValueCollection, NameValueCollection>> duplicateKeyBehaviors;

 static NameValueCollectionHelper()
 {
  duplicateKeyBehaviors = new Dictionary<duplicateKeyBehavior, Action<nameValueCollection, NameValueCollection>>();
  duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Ignore, NameValueCollectionHelper.AddOrIgnoreOnDuplicateKey);
  duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Replace, NameValueCollectionHelper.AddOrReplaceOnDuplicateKey);
  duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Combine, NameValueCollectionHelper.AddOrCombineOnDuplicateKey);
  duplicateKeyBehaviors.Add(DuplicateKeyBehavior.Fail, NameValueCollectionHelper.AddOrFailOnDuplicateKey);
 }

 public static void Add(NameValueCollection collection, NameValueCollection nameValuesToAdd, DuplicateKeyBehavior duplicateKeyBehavior)
{
 duplicateKeyBehaviors[duplicateKeyBehavior](collection, nameValuesToAdd);
}
}[/code]
<p>You should already know that the source is available at <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>.</p>