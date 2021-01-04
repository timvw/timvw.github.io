---
date: "2008-10-17T00:00:00Z"
guid: http://www.timvw.be/?p=718
tags:
- CSharp
title: Refactoring Application Environment (Part 2)
---
[Luca Milan](http://lucamilan.blogspot.com/) notified me of a design issue. Until now the ApplicationEnvironment had an Instance property as following:

```csharp
public static ApplicationEnvironment Instance { get { ... } }
```

A lot of flexibility can be added by extracting an interface IApplicationEnvironment and use that as return type for the property:

```csharp
public static IApplicationEnvironment Instance { get { ... } }
```

Now that we have [Common Service Locator](http://www.codeplex.com/CommonServiceLocator) i have decided to completely remove the Instance property. Code that requires an instance of the IApplicationEnvironment will have to resolve it via the ServiceLocator:

```csharp
IApplicationEnvironment appEnv = ServiceLocator.Current.GetInstance<iapplicationEnvironment>();
```