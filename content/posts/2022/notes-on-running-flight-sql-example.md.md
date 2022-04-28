---
date: 2022-04-28
title: Notes on running (java) FlightSqlExample
---
Here are my notes on how to run the sample java [Arrow Flight SQL](https://arrow.apache.org/blog/2022/02/16/introducing-arrow-flight-sql/) server and client.

1. Clone https://github.com/apache/arrow/:

```bash
git clone git@github.com:apache/arrow.git
```

2. Install snapshot versions of arrow:

```bash
cd java
mvn clean install -DskipTests=true
```

3. Add Application entry point:

```bash
cd flight/flight-sql
cat << EOF > ./src/test/java/org/apache/arrow/flight/sql/example/Main.java
package org.apache.arrow.flight.sql.example;

import org.apache.arrow.flight.FlightServer;
import org.apache.arrow.flight.Location;
import org.apache.arrow.memory.BufferAllocator;
import org.apache.arrow.memory.RootAllocator;

public class Main {

    public static void main(String args[]) throws Exception {

        BufferAllocator allocator = new RootAllocator(Integer.MAX_VALUE);

        final String LOCALHOST = "localhost";

        final Location serverLocation = Location.forGrpcInsecure(LOCALHOST, 52358);
        final FlightServer server = FlightServer.builder(allocator, serverLocation, new FlightSqlExample(serverLocation))
                .build()
                .start();

        System.out.println("server is up and running at port: " + server.getPort());
        Thread.sleep(Long.MAX_VALUE);
    }
}
EOF

4. Run the server:

```bash
mvn test exec:java -Dcheckstyle.skip -DskipTests=true -Drat.skip=true -Dexec.mainClass="org.apache.arrow.flight.sql.example.Main" -Dexec.classpathScope="test"
```

5. Compile the client:

```bash
mvn compile -Dcheckstyle.skip -Drat.skip=true
```

6. Run client without arguments:

```bash
mvn exec:java -Dcheckstyle.skip -Drat.skip=true \
    -Dexec.mainClass="org.apache.arrow.flight.sql.example.FlightSqlClientDemoApp"
```

Output:
```text
Missing required option: command
usage: FlightSqlClientDemoApp -host localhost -port 32010 ...
 -catalog,--catalog         Catalog
 -command,--command <arg>   Method to run
 -host,--host <arg>         Host to connect to
 -port,--port <arg>         Port to connect to
 -query,--query             Query
 -schema,--schema           Schema
 -table,--table             Table
[WARNING] 
org.apache.commons.cli.MissingOptionException: Missing required options: host, port, command
```

7. List tables in APP schema:

```bash
mvn exec:java -Dcheckstyle.skip -Drat.skip=true \
    -Dexec.mainClass="org.apache.arrow.flight.sql.example.FlightSqlClientDemoApp" \
    -Dexec.args="-host localhost -port 52358 -command GetTables -schema APP"
```

Output:
```text
catalog_name    db_schema_name  table_name      table_type
null    APP     FOREIGNTABLE    TABLE
null    APP     INTTABLE        TABLE
```

8. Execute a query:

```bash
mvn exec:java -Dcheckstyle.skip -Drat.skip=true \
    -Dexec.mainClass="org.apache.arrow.flight.sql.example.FlightSqlClientDemoApp" \
    -Dexec.args='-host localhost -port 52358 -command Execute -query "select * from APP.INTTABLE"'
```

Output:
```text
ID      KEYNAME VALUE   FOREIGNID
1       one     1       1
2       zero    0       1
3       negative one    -1      1
```