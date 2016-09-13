---
ID: 2095
post_title: >
  Some PowerShell functions to work with
  SSIS packages
author: timvw
post_date: 2011-03-12 14:23:48
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/12/some-powershell-functions-to-work-with-ssis-packages/
published: true
dsq_thread_id:
  - "1933325346"
---
<p>Here are some powershell functions (using XPath) that come in handy when working with SSIS packages:</p>

[code lang="powershell"]
function FindConnectionManagerNames {
	param($fileName)
	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace(&quot;DTS&quot;, &quot;www.microsoft.com/SqlServer/Dts&quot;);
	$xml.SelectNodes(&quot;//DTS:ConnectionManager/DTS:Property[@DTS:Name='ObjectName']&quot;, $ns) | Foreach { $_.&quot;#text&quot;; }
}

function GetConnectionManagerConnectionString {
	param($fileName, $connectionManagerName)
	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace(&quot;DTS&quot;, &quot;www.microsoft.com/SqlServer/Dts&quot;);
	$xml.SelectSingleNode(&quot;//DTS:ConnectionManager[DTS:Property='$connectionManagerName']/DTS:ObjectData/DTS:ConnectionManager/DTS:Property[@DTS:Name='ConnectionString']&quot;, $ns).&quot;#text&quot;;
}

function FindVariables {
	param($fileName)
	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace(&quot;DTS&quot;, &quot;www.microsoft.com/SqlServer/Dts&quot;);
	$xml.SelectNodes(&quot;//DTS:Variable/DTS:Property[@DTS:Name='ObjectName']&quot;, $ns) | Foreach { $_.&quot;#text&quot;; }
}

function GetVariable {
	param($fileName, $variableName)
	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace(&quot;DTS&quot;, &quot;www.microsoft.com/SqlServer/Dts&quot;);
	$xml.SelectSingleNode(&quot;//DTS:Variable[DTS:Property='$variableName']/DTS:VariableValue&quot;, $ns).&quot;#text&quot;;
}
[/code]