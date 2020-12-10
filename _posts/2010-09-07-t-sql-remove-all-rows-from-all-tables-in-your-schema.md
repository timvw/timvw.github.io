---
title: 'T-SQL: Remove all rows from all tables in your schema'
layout: post
guid: http://www.timvw.be/?p=1901
tags:
  - SQL
  - t-sql
---
Sometimes i want to quickly clean up a database and start from fresh. Here is a small script that does exactly that.. (I just run the script a couple of times, untill no affected rows remain... Far more efficient than figuring out which constraints exist, building up a dependency tree, and cleanly deleting all rows):

```sql
-- Remove all rows from all tables
DECLARE @tableName VARCHAR(255)
DECLARE tableNames CURSOR FOR SELECT name FROM sys.Tables;

OPEN tableNames
FETCH NEXT FROM tableNames INTO @tableName
WHILE @@FETCH_STATUS = 0 
BEGIN
	EXEC('DELETE FROM [' + @tableName + ']')
	FETCH NEXT FROM tableNames INTO @tableName
END
CLOSE tableNames
DEALLOCATE tableNames
```
