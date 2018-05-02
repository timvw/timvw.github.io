---
id: 1853
title: Clean TemplateFile hack
date: 2010-08-17T20:59:42+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=1853
permalink: /2010/08/17/clean-templatefile-hack/
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
