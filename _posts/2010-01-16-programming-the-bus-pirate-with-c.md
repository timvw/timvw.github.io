---
ID: 1614
post_title: 'Programming the Bus Pirate with C#'
author: timvw
post_date: 2010-01-16 12:10:21
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/01/16/programming-the-bus-pirate-with-c/
published: true
dsq_thread_id:
  - "1923792238"
---
<p>A while ago i received my <a href="http://code.google.com/p/the-bus-pirate/">Bus Pirate</a> from <a href="http://www.seeedstudio.com/depot/">Seeed Studio Depot</a>. In essence it is a universal serial bus interface and i would love to program it using c#. I know that i can use the DataReceived event and then fiddle with bits (read <a href="http://msmvps.com/blogs/coad/archive/2005/03/23/39466.aspx#usb">here</a> if you're into that kind of self-punishment) but spawning a separate thread to do the blocking work is ten times less work to get it up and running:</p>

[code lang="csharp"]static void Main()
{
 using (var serialPort = new SerialPort("COM9", 115200, Parity.None, 8, StopBits.One))
 {
  serialPort.Open();

  new Thread(() => WriteLinesFrom(serialPort)).Start();

  while (true)
  {
   var command = Console.ReadLine();
   if (command == "EXIT") break;
   serialPort.WriteLine(command);
  }
 }
}

static void WriteLinesFrom(SerialPort serialPort)
{
 try
 {
  while (true) Console.WriteLine(serialPort.ReadLine());
 }
 catch (Exception)
 {
  break;
  }
 }
}[/code]