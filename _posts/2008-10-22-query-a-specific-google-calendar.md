---
ID: 728
post_title: Query a specific Google Calendar
author: timvw
post_date: 2008-10-22 16:50:52
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/10/22/query-a-specific-google-calendar/
published: true
---
<p>Despite the multiple copies of the <a href="http://code.google.com/apis/calendar/developers_guide_dotnet.html">API Developer's Guide: .NET</a> i found i was unable to find how i should query a specific calendar (not the default). Anyway, it can be done by using the CalendarEntry.Content.BaseUri as the query uri. Here is an example:</p>
[code lang="csharp"]public class CalendarHelper
{
 public const string OwnedCalendarsUrl = "http://www.google.com/calendar/feeds/default/owncalendars/full";

 private readonly CalendarService svc;

 public CalendarHelper(string username, string password)
 {
  this.svc = new CalendarService("demo");
  this.svc.setUserCredentials(username, password);
 }

 public IEnumerable<calendarEntry> FindOwnedCalendars()
 {
  CalendarQuery query = new CalendarQuery(OwnedCalendarsUrl);
  CalendarFeed result = this.svc.Query(query);
  foreach (CalendarEntry entry in result.Entries) yield return entry;
 }

 public CalendarEntry GetCalendar(string name)
 {
  return (
   from calendar in this.FindOwnedCalendars()
   where calendar.Title.Text == name
   select calendar).SingleOrDefault();
 }

 public IEnumerable<atomEntry> FindEvents(CalendarEntry calendar, DateTime begin, DateTime end)
 {
  EventQuery myQuery = new EventQuery(calendar.Content.AbsoluteUri);
  myQuery.StartTime = begin;
  myQuery.EndTime = end;
  EventFeed result = this.svc.Query(myQuery);
  for (int i = 0; i < result.Entries.Count; ++i) yield return result.Entries[i];
 }
}

private static void Main()
{
 CalendarHelper helper = new CalendarHelper("user@gmail.com", "xxx");

 DateTime begin = new DateTime(2008, 1, 1);
 DateTime end= new DateTime(2009, 12, 31);

 IEnumerable<calendarEntry> calendars = helper.FindOwnedCalendars();
 foreach (CalendarEntry calendar in calendars)
 {
  Console.WriteLine(calendar.Title.Text);

  IEnumerable<atomEntry> calendarEvents = helper.FindEvents(calendar, begin, end);
  foreach(AtomEntry calendarEvent in calendarEvents)
  {
   Console.WriteLine("{0}: {1}", calendarEvent.Updated, calendarEvent.Title.Text);
  }

  Console.WriteLine();
 }

 Console.Write("{0}Press any key to continue...", Environment.NewLine);
 Console.ReadKey();
}[/code]