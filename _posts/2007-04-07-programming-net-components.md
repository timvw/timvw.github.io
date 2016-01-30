---
ID: 160
post_title: Programming .NET Components
author: timvw
post_date: 2007-04-07 01:50:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/04/07/programming-net-components/
published: true
---
<p>I couple of weeks ago i got a copy of <a href="http://www.oreilly.com/catalog/pnetcomp2/">Programming .NET Components</a>... I can only suggest to read it yourself because i found it really good ;) Anyway, in one of the chapters <a href="http://www.oreillynet.com/pub/au/741">Juval Lowy</a> talks about context and interception (<a href="http://msdn.microsoft.com/msdnmag/issues/03/03/ContextsinNET/default.aspx">msdnmag article</a>). I got inspired and implemented my own log4net LoggingSink:</p>
[code lang="csharp"]
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
}[/code]
<p>I also implemented my own MethodMessageRenderer and MethodReturnMessageRenderer using an ObjectRenderer that was inspired on the ObjectDumper that comes with the <a href="http://blogs.msdn.com/charlie/archive/2007/03/01/february-ctp-now-available.aspx">LINQ CTP samples</a></p>
[code lang="csharp"]
public class MethodReturnMessageRenderer : IObjectRenderer
{
 #region Constructors

 public MethodReturnMessageRenderer()
 {
 }

 #endregion

 #region IObjectRenderer Members

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

 #endregion
}[/code]
<p>Adding an [assembly: XmlConfigurator(Watch = true)] attribute to the AssemblyInfo.cs of projects that use log4Net seems the easiest way to get the configuration right. In your configuration you still have to register the IObjectRenderers:</p>
[code lang="xml"]
<renderer renderingClass="EndPointTools.MethodReturnMessageRenderer, EndPointTools" renderedClass="System.Runtime.Remoting.Messaging.IMethodReturnMessage, mscorlib"/>
[/code]
<p>Have a look at the generated <a href="http://www.timvw.be/wp-content/code/csharp/log4net.txt">log</a> and feel free to download the complete solution: <a href="http://www.timvw.be/wp-content/code/csharp/ContextBoundSamples.zip">ContextBoundSamples.zip</a>.</p>