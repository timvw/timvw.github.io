---
ID: 2147
post_title: Set variables in SSIS package at runtime
author: timvw
post_date: 2011-05-19 20:23:48
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/05/19/set-variables-in-ssis-package-at-runtime/
published: true
---
<p>The documentation on <a href="http://msdn.microsoft.com/en-us/library/ms162810.aspx">dtexec Utility (SSIS Tool)</a> says the following:</p>

<blockquote>
/Set propertyPath;value

(Optional). Overrides the configuration of a variable, property, container, log provider, Foreach enumerator, or connection within a package. When this option is used, /Set changes the propertyPath argument to the value specified. Multiple /Set options can be specified.
</blockquote>

<p>At first sight this works like a charm but as soon as your value has a space dtexec seems to get confused :( It took me a couple of websearches to find a <a href="http://www.sqldev.org/sql-server-integration-services/escape-character-for-set-option-of-dtexec-34546.shtml">post that suggests the following</a>:

<blockquote>
dtexec /SET \Package.Variables[User::TheVariable].Properties[Value];\""; space"\"
</blockquote>

<p>It seems that this works like a charm :) Because i'm lazy i wrapped this in a powershell function:</p>

[code lang="powershell"]
function PackageOption()
{
	param($name, $value);
	&quot;$name;\`&quot;`&quot;$value\`&quot;`&quot;&quot;;
}
[/code]

<p>And now you can use it as following in your deployment script:</p>

[code lang="powershell"]
$TheVariableOption = PackageOption -Name &quot;\Package.Variables[User::TheVariable].Properties[Value]&quot; -Value &quot;some thing&quot;;
&amp;dtexec /File &quot;$package&quot; /Set $TheVariableOption;
[/code]