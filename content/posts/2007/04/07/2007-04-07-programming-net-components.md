---
date: "2007-04-07T00:00:00Z"
tags:
- Book reviews
- CSharp
title: Programming .NET Components
---
I couple of weeks ago i got a copy of [Programming .NET Components](http://www.oreilly.com/catalog/pnetcomp2/)... I can only suggest to read it yourself because i found it really good 😉 Anyway, in one of the chapters [Juval Lowy](http://www.oreillynet.com/pub/au/741) talks about context and interception ([msdnmag article](http://msdn.microsoft.com/msdnmag/issues/03/03/ContextsinNET/default.aspx)). I got inspired and implemented my own log4net LoggingSink

```csharp
public class LoggingSink : IMessageSink
{
	...

	public IMessage SyncProcessMessage(IMessage msg)
	{
		IMethodMessage methodMessage = msg as IMethodMessage;
		ILog log = LogManager.GetLogger(methodMessage.TypeName);
		log.Debug(methodMessage);

		IMessage message = this.nextSink.SyncProcessMessage(msg);

		IMethodReturnMessage methodReturnMessage = message as IMethodReturnMessage;
		if (methodReturnMessage != null)
		{
			log.Debug(methodReturnMessage);
		}

		return message;
	}
}
```

I also implemented my own MethodMessageRenderer and MethodReturnMessageRenderer using an ObjectRenderer that was inspired on the ObjectDumper that comes with the [LINQ CTP samples](http://blogs.msdn.com/charlie/archive/2007/03/01/february-ctp-now-available.aspx)

```csharp
public class MethodReturnMessageRenderer : IObjectRenderer
{
	public MethodReturnMessageRenderer()
	{
	}

	public void RenderObject(RendererMap rendererMap, object obj, TextWriter writer)
	{
		IMethodReturnMessage methodReturnMessage = obj as IMethodReturnMessage;
		writer.WriteLine("{0}Called: {1}{2}Params:", Environment.NewLine, methodReturnMessage.MethodName, Environment.NewLine);
		ObjectRenderer.RenderObject(methodReturnMessage.Args, writer);
		if (methodReturnMessage.MethodName != ".ctor")
		{
			writer.WriteLine("{0}ReturnValue:", Environment.NewLine);
			ObjectRenderer.RenderObject(methodReturnMessage.ReturnValue, writer);
		}
		if (methodReturnMessage.Exception != null)
		{
			writer.WriteLine("{0}Exception:", Environment.NewLine);
			ObjectRenderer.RenderObject(methodReturnMessage.Exception, writer);
		}
		writer.WriteLine();
	}
}
```

Adding an [assembly: XmlConfigurator(Watch = true)] attribute to the AssemblyInfo.cs of projects that use log4Net seems the easiest way to get the configuration right. In your configuration you still have to register the IObjectRenderers

```xml
<renderer renderingClass="EndPointTools.MethodReturnMessageRenderer, EndPointTools" renderedClass="System.Runtime.Remoting.Messaging.IMethodReturnMessage, mscorlib"/>
```

Have a look at the generated [log](http://www.timvw.be/wp-content/code/csharp/log4net.txt) and feel free to download the complete solution: [ContextBoundSamples.zip](http://www.timvw.be/wp-content/code/csharp/ContextBoundSamples.zip).
