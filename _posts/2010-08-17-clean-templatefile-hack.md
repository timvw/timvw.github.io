---
title: Clean TemplateFile hack
layout: post
guid: http://www.timvw.be/?p=1853
tags:
  - MSBuild
---
A while ago i wrote about a [Clever TemplateFile hack](http://www.timvw.be/clever-templatefile-hack/) to use some xml block as ReplacementValue. Today i realized there is a clean way to achieve this by defining the value as [CDATA](http://www.w3schools.com/xml/xml_cdata.asp)

```xml
<TemplateTokens Include="mex">
	<ReplacementValue>
		<![CDATA[<endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange" />]]>
	</ReplacementValue>
</TemplateTokens>
```
