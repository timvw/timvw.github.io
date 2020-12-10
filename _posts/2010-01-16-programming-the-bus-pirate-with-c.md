---
title: 'Programming the Bus Pirate with C#'
layout: post
guid: http://www.timvw.be/?p=1614
tags:
  - 'C#'
---
A while ago i received my [Bus Pirate](http://code.google.com/p/the-bus-pirate/) from [Seeed Studio Depot](http://www.seeedstudio.com/depot/). In essence it is a universal serial bus interface and i would love to program it using c#. I know that i can use the DataReceived event and then fiddle with bits (read [here](http://msmvps.com/blogs/coad/archive/2005/03/23/39466.aspx#usb) if you're into that kind of self-punishment) but spawning a separate thread to do the blocking work is ten times less work to get it up and running

```csharp
static void Main()
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
```
