---
ID: 19
post_title: List the month names
author: timvw
post_date: 2006-09-03 02:12:35
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/03/list-the-month-names/
published: true
---
<p>As i wrote in <a href="http://www.timvw.be/generate-a-menu-with-month-names/">Generate a menu with month names</a> it's silly to hardcode month names. Here's a C# sample using localization/globalization:</p>
[code lang="csharp"]using System;
using System.Globalization;
using System.Threading;

namespace ConsoleApplication1 {
 class Program {
  static void ListMonths() {
   for ( int i = 1; i < 13; ++i ) {
    DateTime dateTime = new DateTime( DateTime.Now.Year, i, 1 );
    Console.WriteLine( dateTime.ToString( "MMMM" ) );
   }

   Console.WriteLine();
  }

  static void Main( string[] args ) {
   Thread.CurrentThread.CurrentCulture = new CultureInfo( "en-US", false );
   ListMonths();

   Thread.CurrentThread.CurrentCulture = new CultureInfo( "nl-BE", false );
   ListMonths();

   Console.Write( "{0}Press any key to continue...", Environment.NewLine );
   Console.ReadKey();
  }
 }
}[/code]