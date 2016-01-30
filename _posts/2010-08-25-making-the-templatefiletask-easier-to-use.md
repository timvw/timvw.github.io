---
ID: 1871
post_title: 'Making the TemplateFileTask easier to use&#8230;'
author: timvw
post_date: 2010-08-25 20:19:52
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/08/25/making-the-templatefiletask-easier-to-use/
published: true
---
<p>One of the disadvantages of the TemplateFile task (<a href="http://msbuildtasks.tigris.org/">msbuildtasks</a>) is the fact that it requires a lot of typing to define template values:</p>

[code lang="xml"]
&lt;ItemGroup Condition= &quot; '$(ConfigurationEnvironment)'=='build' &quot;&gt;
 &lt;Tokens Include=&quot;a&quot;&gt;
  &lt;ReplacementValue&gt;localhost&lt;/ReplacementValue&gt;
 &lt;/Tokens&gt;
 &lt;Tokens Include=&quot;b&quot;&gt;
  &lt;ReplacementValue&gt;&lt;mynode/&gt;&lt;/ReplacementValue&gt;
 &lt;/Tokens&gt;
&lt;/ItemGroup&gt;
[/code]

<p>Here is a format proposition to make this a lot more finger friendly:</p>

[code lang="xml"]
&lt;configuration&gt;
 &lt;variables env=&quot;build&quot;&gt;
  &lt;x name=&quot;a&quot;&gt;localhost&lt;/x&gt;
  &lt;x name=&quot;b&gt;&lt;mynode/&gt;&lt;/x&gt;
 &lt;/variables&gt;
&lt;/configuration&gt;
[/code]

<p>Here is the msbuild script we need to achieve that:</p>

[code lang="xml"]
&lt;PropertyGroup&gt;
 &lt;ConfigurationFile&gt;configuration.xml&lt;/ConfigurationFile&gt;
 &lt;ConfigurationEnvironment&gt;build&lt;/ConfigurationEnvironment&gt;
&lt;/PropertyGroup&gt;

&lt;!-- Retreive all template values for the specific environment --&gt;
&lt;XmlQuery XmlFileName=&quot;$(ConfigurationFile)&quot; XPath = &quot;//variables[@env='$(ConfigurationEnvironment)']/*&quot;&gt;
 &lt;Output TaskParameter=&quot;Values&quot; ItemName=&quot;Values&quot; /&gt;
&lt;/XmlQuery&gt;

&lt;!-- Construct @Tokens --&gt;
&lt;ItemGroup&gt;
 &lt;Tokens Include=&quot;%(Values.name)&quot;&gt;
  &lt;ReplacementValue&gt;%(Values._innerxml)&lt;/ReplacementValue&gt;
 &lt;/Tokens&gt;
&lt;/ItemGroup&gt;

&lt;!-- Generate the configuration files --&gt;
&lt;Message Text=&quot;Available variables:&quot; /&gt;
&lt;Message Text=&quot;====================&quot; /&gt;
&lt;Message Text=&quot;%(Tokens.Identity): %(Tokens.ReplacementValue)&quot; /&gt;
[/code]

<p>Happy coding!</p>