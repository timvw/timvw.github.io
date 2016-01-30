---
ID: 93
post_title: Formatted input
author: timvw
post_date: 2005-03-19 01:31:34
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/03/19/formatted-input/
published: true
---
<p>I was in need for formatted input and the decomposition of the input into a stream of tokens so i came up with the following:</p>

<code src="java/TokSequence.java.txt" lang="java"/>

<p>And now i am ready for formatted input like this:</p>

[code lang="java"]
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
    } catch (Exception e) {
      System.err.println(e);
      System.exit(1);
    }
  }
}
[/code]