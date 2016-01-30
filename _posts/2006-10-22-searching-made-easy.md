---
ID: 123
post_title: Searching made easy
author: timvw
post_date: 2006-10-22 11:09:28
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/10/22/searching-made-easy/
published: true
---
<p>Very often i have to write queries that return all the rows where one or more columns match a specific value. If i add for every column the condition 'P_COLUMN IS NULL OR COLUMN = P_COLUMN' to the WHERE clause i only have to write one query. Here's an example of such a query:</p>

[code lang="sql"]
PROCEDURE FIND_TESTS
(
 P_ID              IN        TEST.ID%Type,
 P_TITLE         IN        TEST.TITLE%Type,
 P_TYPE_CODE IN        TEST.TYPE_CODE%Type,
 P_CURSOR      OUT     CURSOR REF
)

AS

BEGIN

OPEN
              P_CURSOR FOR
SELECT
              ID,
              TITLE,
              TYPE_CODE
FROM
              TEST
WHERE
              (P_ID IS NULL OR ID = P_ID)
              AND (P_TITLE IS NULL OR TITLE LIKE P_TITLE)
              AND (P_TYPE_CODE IS NULL OR TYPE_CODE LIKE P_TYPE_CODE)
ORDER BY
              ID ASC;
END;
[/code]

<p>A couple of examples how you can use this query:</p>

[code lang="csharp"]
using (OracleConnection conn = new OracleConnection("User Id=u;password=p;Data Source=ORCL"))
{
 conn.Open();

 OracleCommand command = conn.CreateCommand();
 command.CommandText = "TIMVW.MYPACKAGE.FIND_TESTS";
 command.CommandType = CommandType.StoredProcedure;

 // select all tests of type_code "book" that have a title that starts with "Myst"
 command.Parameters.Add("P_ID", OracleDbType.Int32, 10, DBNull.Value, ParameterDirection.Input);
 command.Parameters.Add("P_TITLE", OracleDbType.Varchar2, 20, "Myst%", ParameterDirection.Input);
 command.Parameters.Add("P_TYPE_CODE", OracleDbType.Varchar2, 20, "book", ParameterDirection.Input);
 command.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, ParameterDirection.Output);

 // select the test with id 1
 //command.Parameters.Add("P_ID", OracleDbType.Int32, 10, 1, ParameterDirection.Input);
 //command.Parameters.Add("P_TITLE", OracleDbType.Varchar2, 20, DBNull.Value, ParameterDirection.Input);
 //command.Parameters.Add("P_TYPE_CODE", OracleDbType.Varchar2, 20, DBNull.Value, ParameterDirection.Input);
 //command.Parameters.Add("P_CURSOR", OracleDbType.RefCursor, ParameterDirection.Output);

 OracleDataReader reader = command.ExecuteReader();
 while (reader.Read())
 {
  Console.WriteLine("test id: " + reader.GetDecimal(0));
 }

 Console.Write("{0}Press any key to continue...", Environment.NewLine);
 Console.ReadKey();
}
[/code]