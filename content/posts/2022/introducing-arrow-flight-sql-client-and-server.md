---
date: 2022-04-28
title: Introducing Arrow Flight SQL client and server
draft: true
---
When you ask me, [Apache Arrow](https://arrow.apache.org/) is the one project that will have significant on data processing systems in the coming years.

In order to become somewhat familiar with the eco-system (and learn some [rust](https://www.rust-lang.org/) while doing so) I have implemented a simple CLI application that allows one to explore [Flight SQL](https://arrow.apache.org/blog/2022/02/16/introducing-arrow-flight-sql/).

The client app can be found here:. 

Because not every system has a Flight SQL interface yet, I have decided to implement a bridge to ODBC which can be found here: [arrow-flightsql-odbc](https://github.com/timvw/arrow-flightsql-odbc)