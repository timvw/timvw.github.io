---
date: "2006-10-23T00:00:00Z"
tags:
- C#
- SQL
title: Using a collection as parameter for a stored procedure
aliases:
 - /2006/10/23/using-a-collection-as-parameter-for-a-stored-procedure/
 - /2006/10/23/using-a-collection-as-parameter-for-a-stored-procedure.html
---
Sometimes you want to select rows where a value is in a specific collection. Here's an example that show how you can select all the rows in the TEST table with an id of 1, 2 or 3. First we create an SQL type to contain a list of numbers

```sql
CREATE TYPE LIST_NUMBER AS TABLE OF NUMBER(10);
/
```

Next thing to do is add a custom type and function header to the package specification

```sql
PACKAGE TIMVW.TESTPACKAGE AS

TYPE CRSR_REF IS REF CURSOR;
TYPE ARR\_IDS IS TABLE OF TEST.TEST\_ID%Type INDEX BY BINARY_INTEGER;

PROCEDURE GET_TESTS
(
P_IDS IN ARR_IDS,
P_CURSOR OUT CRSR_REF
);
END;
```

And offcourse we have to implement the function in the body

```sql
PROCEDURE GET_TESTS
(
P_IDS IN ARR_IDS,
P_CURSOR OUT CRSR_REF
)

AS

V_IDS LIST_NUMBER := LIST_NUMBER();

BEGIN

V_IDS.EXTEND(P_IDS.COUNT);
FOR i IN P_IDS.FIRST .. P_IDS.LAST LOOP
	V_IDS(i) := P_IDS(i);
END LOOP;

OPEN P_CURSOR FOR
SELECT
TEST.TEST_ID,
TEST.NAME,
TEST.TYPE_CODE
FROM
TEST
WHERE
TEST_ID IN (SELECT * FROM TABLE(V_IDS))
ORDER BY
TEST.TEST_ID ASC;
END;
```

Now that we have done all this we can consume the function from our client code

```csharp
using (OracleConnection conn = new OracleConnection("User Id=u;password=p;Data Source=ORCL"))
{
	conn.Open();

	OracleCommand command = conn.CreateCommand();
	command.CommandType = CommandType.StoredProcedure;

	command.CommandText = "TIMVW.TESTPACKAGE.GET_TESTS";
	command.Parameters.Add("P_IDS", OracleDbType.Int32, new int[] { 1, 2, 3 }, ParameterDirection.Input);
	command.Parameters["P_IDS"].CollectionType = OracleCollectionType.PLSQLAssociativeArray;
	command.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, ParameterDirection.Output);

	OracleDataReader reader = command.ExecuteReader();
	while (reader.Read())
	{
		Console.WriteLine("test 	}

	Console.Write("{0}Press any key to continue...", Environment.NewLine);
	Console.ReadKey();
}
```
