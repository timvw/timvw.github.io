---
ID: 2260
post_title: 'An example of Common Table Expression and Window function usage&#8230;'
author: timvw
post_date: 2012-03-27 10:33:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2012/03/27/an-example-of-common-table-expression-and-window-function-usage/
published: true
---
<p>Earlier this week some colleague had been assigned a maintenance task and asked me how I would solve it. Every customer is permitted to have an amount of publications. All excess publications should be removed from the system (only the n most recent ones are permitted to remain on the system).</p>

<p>Here is an example of the Customer table:</p>
[code lang="sql"]
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
[/code]

<p>An example of the customer publications table:</p>
[code lang="sql"]
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
			((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'timvw'), 'tim pub3', SYSUTCDATETIME()),
			((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'timvw'), 'tim pub4', SYSUTCDATETIME()),
			((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'mike'), 'mike pub1', SYSUTCDATETIME()),
			((SELECT [CustomerId] FROM [dbo].[Customer] WHERE [CustomerName] = 'mike'), 'mike pub2', SYSUTCDATETIME());
[/code]
	
<p>My colleague was keen on using some cursor logic, but I demonstrated him how a set-based alternative:</p>

[code lang="sql"]		
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
	WHERE [PublicationRank] &gt; [Customer].[PermittedPublications]
)
	DELETE FROM [dbo].[Publication]
	WHERE [PublicationId] IN (SELECT [PublicationId] FROM [ExcessPublication]);
[/code]