---
date: "2006-09-03T00:00:00Z"
tags:
- CSharp
title: List the month names
aliases:
 - /2006/09/03/list-the-month-names/
 - /2006/09/03/list-the-month-names.html
---
As i wrote in [Generate a menu with month names](http://www.timvw.be/generate-a-menu-with-month-names/) it's silly to hardcode month names. Here's a C# sample using localization/globalization

```csharp
using System;
using System.Globalization;
using System.Threading;

namespace ConsoleApplication1 
{
	class Program 
	{
		static void ListMonths() 
		{
			for ( int i = 1; i < 13; ++i ) 
			{ 
				DateTime dateTime = new DateTime( DateTime.Now.Year, i, 1 ); 
				Console.WriteLine( dateTime.ToString( "MMMM" ) ); 
			} 
			Console.WriteLine(); 
		} 
		
		static void Main( string[] args ) 
		{ 
			Thread.CurrentThread.CurrentCulture = new CultureInfo( "en-US", false );
			ListMonths(); 
			Thread.CurrentThread.CurrentCulture = new CultureInfo( "nl-BE", false ); 
			ListMonths(); 
			Console.Write( "{0}Press any key to continue...", Environment.NewLine ); 
			Console.ReadKey(); 
		} 
	} 
}
```
