---
ID: 228
post_title: Exploring the Microsoft Sync Framework
author: timvw
post_date: 2008-05-24 16:03:45
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/05/24/exploring-the-microsoft-sync-framework/
published: true
---
<p>Earlier this week i've been experimenting with the <a href="http://msdn.microsoft.com/en-us/sync/default.aspx">Microsoft Sync Framework</a>. In a typical n-tier architecture the client can't access the remote database directly but uses a proxy instead. The available <a href="http://msdn.microsoft.com/en-us/library/microsoft.synchronization.data.serversyncproviderproxy(SQL.100).aspx">ServerSyncProviderProxy </a> has only one constructor which accepts an object. With reflector i found out that the proxy simply uses reflection to call some methods. Here are a couple of helper classes that help you prevent runtime errors due to this approach: </p>
[code lang="csharp"]
[ServiceContract(Namespace = "http://www.timvw.be/Synchronization")]
public interface IServerSyncProvider
{
 [OperationContract]
 SyncServerInfo GetServerInfo(SyncSession syncSession);

 [OperationContract]
 SyncSchema GetSchema(Collection<string> tableNames, SyncSession syncSession);

 [OperationContract]
 SyncContext GetChanges(SyncGroupMetadata groupMetadata, SyncSession syncSession);

 [OperationContract]
 SyncContext ApplyChanges(SyncGroupMetadata groupMetadata, DataSet dataSet, SyncSession syncSession);
}

public class MyServerSyncProviderProxy : ServerSyncProviderProxy
{
 public MyServerSyncProviderProxy(IServerSyncProvider serverSyncProvider)
  : base(serverSyncProvider)
 {
 }
}[/code]
<p>And now you can easily consume a ServerSyncProviderProxy as following:</p>
[code lang="csharp"]
SyncAgent syncAgent = new SyncAgent();

EndpointAddress address = new EndpointAddress("http://somewhere/Be.Timvw.Demo.Host/ServerSyncProvider.svc");
BasicHttpBinding binding = new BasicHttpBinding();
ChannelFactory<iserverSyncProvider> factory = new ChannelFactory<iserverSyncProvider>(binding, address);
IServerSyncProvider serverSyncProvider = factory.CreateChannel();
syncAgent.RemoteProvider = new SafeServerSyncProviderProxy(serverSyncProvider);
[/code]