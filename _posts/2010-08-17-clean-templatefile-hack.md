---
ID: 1853
post_title: Clean TemplateFile hack
author: timvw
post_date: 2010-08-17 20:59:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/08/17/clean-templatefile-hack/
published: true
---
<p>A while ago i wrote about a <a href="http://www.timvw.be/clever-templatefile-hack/">Clever TemplateFile hack</a> to use some xml block as ReplacementValue. Today i realized there is a clean way to achieve this by defining the value as <a href="http://www.w3schools.com/xml/xml_cdata.asp">CDATA</a>:</p>

[code lang="xml"]&lt;TemplateTokens Include=&quot;mex&quot;&gt;
 &lt;ReplacementValue&gt;
  &lt;![CDATA[&lt;endpoint address=&quot;mex&quot; binding=&quot;mexHttpBinding&quot; contract=&quot;IMetadataExchange&quot; /&gt;]]&gt;
 &lt;/ReplacementValue&gt;
&lt;/TemplateTokens&gt;[/code]