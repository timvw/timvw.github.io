---
ID: 216
post_title: >
  Using Linq for statically-typed
  reflection
author: timvw
post_date: 2008-03-14 19:00:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/03/14/using-linq-for-statically-typed-reflection/
published: true
---
<p>I discovered the <a href="http://www.codeplex.com/Release/ProjectReleases.aspx?ProjectName=clarius&ReleaseId=9495">TypedReflector</a>
 on <a href="http://www.clariusconsulting.net/blogs/kzu/archive/2007/12/30/49063.aspx">Daniel Cazzulino's Blog</a>. In essence, a simplified version of the code looks like:</p>
[code lang="csharp"]public static class Reflector
{
 public static PropertyInfo GetProperty<t, TRet>(Expression<func<t, TRet>> expression)
 {
  return GetMemberInfo(expression) as PropertyInfo;
 }

 public static FieldInfo GetField<t, TRet>(Expression<func<t, TRet>> expression)
 {
  return GetMemberInfo(expression) as FieldInfo;
 }

 public static MethodInfo GetMethod<t, TRet>(Expression<func<t, TRet>> expression)
 {
  return GetMemberInfo(expression) as MethodInfo;
 }

 public static MemberInfo GetMemberInfo(Expression memberInfoExpression)
 {
  Expression lambdaBodyExpression = ((LambdaExpression)memberInfoExpression).Body;
  switch (lambdaBodyExpression.NodeType)
  {
   case ExpressionType.MemberAccess:
    return ((MemberExpression)lambdaBodyExpression).Member;
   case ExpressionType.Call:
    return ((MethodCallExpression)lambdaBodyExpression).Method;
   default:
    throw new ArgumentException("Unsupported NodeType");
  }
 }
}[/code]
<p>This class allows me to write the following:</p>
[code lang="csharp"]
PropertyInfo namePropertyInfo = Reflector.GetProperty<person, string>(p => p.Surname);
[/code]
<p>Not only can i be sure that the lambda (and thus the namePropertyInfo.Invoke) will always return a string, i can also use it to avoid 'hardcoded' propertynames:</p>
[code lang="csharp"]
//const string SurnameProperty = "Surname";
//comboBox1.DisplayMember = SurnameProperty;
comboBox1.DisplayMember = Reflector.GetProperty<person, string>(p => p.Surname).Name;
[/code]