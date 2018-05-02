---
id: 93
title: Formatted input
date: 2005-03-19T01:31:34+00:00
author: timvw
layout: post
guid: http://www.timvw.be/formatted-input/
permalink: /2005/03/19/formatted-input/
tags:
  - Java
---
I was in need for formatted input and the decomposition of the input into a stream of tokens so i came up with the following:

<code src="java/TokSequence.java.txt" lang="java" />

And now i am ready for formatted input like this:

```java
public class Main {
  public static void main(String[] args) {
    try {
      BufferedReader input = new BufferedReader(new FileReader("file.txt"));

      for (String in = input.readLine()) {
        TokSequence ts = new TokSequence(new StringTokenizer(in));
        int userId = ts.getIn();
        double score = ts.getDouble();
        String name = ts.getString();
        // do stuff with userId, score and name
      }
    } 
    catch (Exception e) {
      System.err.println(e);
      System.exit(1);
    }
  }  
} 
```
