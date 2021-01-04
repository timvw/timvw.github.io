---
date: "2008-03-14T00:00:00Z"
tags:
- CSharp
title: Using Linq for statically-typed reflection
---
I discovered the [TypedReflector](http://www.codeplex.com/Release/ProjectReleases.aspx?ProjectName=clarius&ReleaseId=9495)
   
on [Daniel Cazzulino's Blog](http://www.clariusconsulting.net/blogs/kzu/archive/2007/12/30/49063.aspx). In essence, a simplified version of the code looks like

```csharp
public static class Reflector
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
}
```

This class allows me to write the following

```csharp
PropertyInfo namePropertyInfo = Reflector.GetProperty<person, string>(p => p.Surname);
```

Not only can i be sure that the lambda (and thus the namePropertyInfo.Invoke) will always return a string, i can also use it to avoid 'hardcoded' propertynames

```csharp
//const string SurnameProperty = "Surname";
//comboBox1.DisplayMember = SurnameProperty;
comboBox1.DisplayMember = Reflector.GetProperty<person, string>(p => p.Surname).Name;
```
