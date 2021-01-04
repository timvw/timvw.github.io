---
date: "2012-03-27T00:00:00Z"
guid: http://www.timvw.be/?p=2260
tags:
- SQL
- t-sql
title: An example of Common Table Expression and Window function usage...
---
Earlier this week some colleague had been assigned a maintenance task and asked me how I would solve it. Every customer is permitted to have an amount of publications. All excess publications should be removed from the system (only the n most recent ones are permitted to remain on the system).

Here is an example of the Customer table:

```sql
CREATE TABLE [dbo].[Customer](  
	[CustomerId] [int] IDENTITY(1,1) NOT NULL, 
	[CustomerName] [nvarchar](50) NOT NULL,  
	[PermittedPublications] [int] NOT NULL
);

INSERT INTO [dbo].[Customer]		  
	([CustomerName], [PermittedPublications])
VALUES
	('timvw', 2),		  
	('mike', 3);
```

An example of the customer publications table:

```sql
CREATE TABLE [dbo].[Publication](	  
	[PublicationId] [int] IDENTITY(1,1) NOT NULL,	  
	[CustomerId] [int] NOT NULL,	  
	[PublicationName] [nvarchar](50) NOT NULL,	  
	[PublicationTime] [datetime2] NOT NULL
);

INSERT INTO [dbo].[Publication]
  	([CustomerId], [PublicationName],[PublicationTime])
VALUES
	((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'timvw'), 'tim pub1', SYSUTCDATETIME()),		  
	((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'timvw'), 'tim pub2', SYSUTCDATETIME()),		  
	((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'timvw'), 'tim pub', SYSUTCDATETIME()),
	((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'timvw'), 'tim pub4', SYSUTCDATETIME()),
	((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'mike'), 'mike pub1', SYSUTCDATETIME()),
	((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'mike'), 'mike pub2', SYSUTCDATETIME()); 
```

My colleague was keen on using some cursor logic, but I demonstrated him how a set-based alternative:

```sql
WITH [RankedPublication] AS (	  
	SELECT [CustomerId]
		,[PublicationId]
		,[PublicationName]
		,[PublicationTime]
		,ROW_NUMBER() OVER(PARTITION BY [CustomerId] ORDER BY [PublicationTime]) AS [PublicationRank]
	FROM [dbo].[Publication]
), [ExcessPublication] AS (	  
	SELECT [PublicationId]	  
	FROM [RankedPublication]	  
	INNER JOIN [dbo].[Customer] ON [Customer].[CustomerId] = [RankedPublication].[CustomerId]	  
	WHERE [PublicationRank] > [Customer].[PermittedPublications]
)
DELETE FROM [dbo].[Publication]	  
WHERE [PublicationId] IN (SELECT [PublicationId] FROM [ExcessPublication]);
```
