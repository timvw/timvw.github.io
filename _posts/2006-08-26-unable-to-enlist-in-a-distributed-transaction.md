---
ID: 46
post_title: >
  Unable to enlist in a distributed
  transaction
author: timvw
post_date: 2006-08-26 19:57:43
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/08/26/unable-to-enlist-in-a-distributed-transaction/
published: true
dsq_thread_id:
  - "1927478948"
---
<p>Earlier today we were confronted with the following <a href="http://msdn2.microsoft.com/en-US/library/system.data.oracleclient.oracleexception.aspx">OracleException</a>: <b>Unable to enlist in a distributed transaction</b>. Our code (and accompanying tests) had been running fine for the last two weeks thus we expected there was a problem with the database. A member of the DBA team assurred  us there was nothing wrong with the database. Finally we discovered that we had created a circular reference and thus the program ended up in an endless loop (well untill the database decided it had been enough anyway :p). Here is a simplified version of the problem:</p>

[code lang="csharp"]public void DoA() {
 using (TransactionScope scope = new TransactionScope()) {
  using (OracleConnection con = new OracleConnection(connectionString)) {
   con.Open();
   DoB();
   scope.Complete();
  }
 }
}

public void DoB() {
 using (TransactionScope scope = new TransactionScope()) {
  using (OracleConnection con = new OracleConnection(connectionString)) {
   con.Open();
   DoA();
   scope.Complete();
  }
 }
}[/code]

<p>Without the use of <a href="http://msdn2.microsoft.com/en-us/library/system.transactions.transactionscope.aspx">TransactionScope</a> this results in a <b>Connection request timed out</b> exception.</p>