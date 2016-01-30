---
ID: 1978
post_title: >
  Update ConfigurationStrings in SSIS
  package with PowerShell
author: timvw
post_date: 2010-11-11 13:50:12
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/11/update-configurationstrings-in-ssis-package-with-powershell/
published: true
dsq_thread_id:
  - "1925959837"
---
<p>Here are some functions that allow you to update ConfigurationStrings in a SSIS package (dtsx) using PowerShell:</p>

[code lang="powershell"]
function UpdateConfigurationStrings($file)
{
 $xml = [xml] (Get-Content $file);
 $ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
 $ns.AddNamespace(&quot;DTS&quot;, &quot;www.microsoft.com/SqlServer/Dts&quot;);
 UpdateConfigurationNodes $xml $ns;
 Set-Content $file $xml.OuterXml;
}

function UpdateConfigurationNodes($xml, $ns)
{
 $selectConfigurationNodes = &quot;//DTS:Configuration&quot;;
 $xml.SelectNodes($selectConfigurationNodes, $ns) | foreach { UpdateConfigurationNode $_ $ns; };
}

function UpdateConfigurationNode($configurationNode, $ns)
{   
 $selectConfigurationString = &quot;./DTS:Property[@DTS:Name='ConfigurationString']&quot;;
 $configurationStringNode = $configurationNode.SelectSingleNode($selectConfigurationString, $ns);
    
 $oldConfigurationStringValue = $configurationStringNode.'#text';
 $newConfigurationStringValue = GetNewConfigurationStringValue $oldConfigurationStringValue;
 $configurationStringNode.'#text' = &quot;$newConfigurationStringValue&quot;; 
}

function GetNewConfigurationStringValue($oldConfigurationStringValue)
{
 # implement some logic to determine new value
 return &quot;new value&quot;;
}
[/code]