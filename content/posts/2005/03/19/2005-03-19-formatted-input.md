---
date: "2005-03-19T00:00:00Z"
tags:
- Java
title: Formatted input
---
I was in need for formatted input and the decomposition of the input into a stream of tokens so i came up with the following:

Code: [java/TokSequence.java.txt](/wp-content/code/java/TokSequence.java.txt)
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
