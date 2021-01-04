---
date: "2007-09-09T00:00:00Z"
tags:
- CSharp
title: Build your own netstat.exe with c#
---
Earlier today i wrote ManagedIpHelper, a wrapper for [IP Helper API](http://msdn2.microsoft.com/en-us/library/aa366073.aspx) it's [GetExtendedTcpTable](http://msdn2.microsoft.com/en-us/library/aa365928.aspx). Using this wrapper i could easily create my own version of netstat.exe. The following code generates the same output (but much faster) than "netstat.exe -anvbp tcp"

```csharp
static void Main(string[] args)
{
	Console.WriteLine("Active Connections");
	Console.WriteLine();

	Console.WriteLine(" Proto Local Address Foreign Address State PID");
	foreach (TcpRow tcpRow in ManagedIpHelper.GetExtendedTcpTable(true))
	{
		Console.WriteLine(" {0,-7}{1,-23}{2, -23}{3,-14}{4}", "TCP", tcpRow.LocalEndPoint, tcpRow.RemoteEndPoint, tcpRow.State, tcpRow.ProcessId);

		Process process = Process.GetProcessById(tcpRow.ProcessId);
		if (process.ProcessName != "System")
		{
			foreach (ProcessModule processModule in process.Modules)
			{
				Console.WriteLine(" {0}", processModule.FileName);
			}

			Console.WriteLine(" [{0}]", Path.GetFileName(process.MainModule.FileName));
		}
		else
		{
			Console.WriteLine(" -- unknown component(s) --");
			Console.WriteLine(" [{0}]", "System");
		}

		Console.WriteLine();
	}

	Console.Write("{0}Press any key to continue...", Environment.NewLine);
	Console.ReadKey();
}
```

As always, feel free to download the code for the [ManagedIpHelper and demo](http://www.timvw.be/wp-content/code/csharp/managediphelperanddemo.zip).
