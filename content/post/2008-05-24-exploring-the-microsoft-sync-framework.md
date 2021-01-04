---
date: "2008-05-24T00:00:00Z"
guid: http://www.timvw.be/?p=228
tags:
- C#
title: Exploring the Microsoft Sync Framework
aliases:
 - /2008/05/24/exploring-the-microsoft-sync-framework/
 - /2008/05/24/exploring-the-microsoft-sync-framework.html
---
Earlier this week i've been experimenting with the [Microsoft Sync Framework](http://msdn.microsoft.com/en-us/sync/default.aspx). In a typical n-tier architecture the client can't access the remote database directly but uses a proxy instead. The available [Earlier this week i've been experimenting with the [Microsoft Sync Framework](http://msdn.microsoft.com/en-us/sync/default.aspx). In a typical n-tier architecture the client can't access the remote database directly but uses a proxy instead. The available](http://msdn.microsoft.com/en-us/library/microsoft.synchronization.data.serversyncproviderproxy(SQL.100).aspx) has only one constructor which accepts an object. With reflector i found out that the proxy simply uses reflection to call some methods. Here are a couple of helper classes that help you prevent runtime errors due to this approach

```csharp
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
}

public class MyServerSyncProviderProxy : ServerSyncProviderProxy
{
		public MyServerSyncProviderProxy(IServerSyncProvider serverSyncProvider)
		: base(serverSyncProvider)
		{
		}
}
```

And now you can easily consume a ServerSyncProviderProxy as following

```csharp
SyncAgent syncAgent = new SyncAgent();
EndpointAddress address = new EndpointAddress("http://somewhere/Be.Timvw.Demo.Host/ServerSyncProvider.svc");
BasicHttpBinding binding = new BasicHttpBinding();
ChannelFactory<iserverSyncProvider> factory = new ChannelFactory<iserverSyncProvider>(binding, address);
IServerSyncProvider serverSyncProvider = factory.CreateChannel();
syncAgent.RemoteProvider = new SafeServerSyncProviderProxy(serverSyncProvider);
```
