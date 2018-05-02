---
id: 2095
title: Some PowerShell functions to work with SSIS packages
date: 2011-03-12T14:23:48+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2095
permalink: /2011/03/12/some-powershell-functions-to-work-with-ssis-packages/
dsq_thread_id:
  - 1933325346
categories:
  - Uncategorized
tags:
  - PowerShell
  - SSIS
  - xpath
---
Here are some powershell functions (using XPath) that come in handy when working with SSIS packages:

```powershell
function FindConnectionManagerNames {	  
	param($fileName)

	$xml = [xml] (Get-Content $fileName);	  
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;	  
	$ns.AddNamespace("DTS", "www.microsoft.com/SqlServer/Dts");	  
	$xml.SelectNodes("//DTS:ConnectionManager/DTS:Property[@DTS:Name='ObjectName']", $ns) | Foreach { $_."#text"; }

}

function GetConnectionManagerConnectionString {  
	param($fileName, $connectionManagerName)

	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace("DTS", "www.microsoft.com/SqlServer/Dts");
	$path = "//DTS:ConnectionManager[DTS:Property='$connectionManagerName']/DTS:ObjectData/DTS:ConnectionManager/DTS:Property[@DTS:Name='ConnectionString']"
	$xml.SelectSingleNode($path, $ns)."#text";
}

function FindVariables {	  
	param($fileName)

	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace("DTS", "www.microsoft.com/SqlServer/Dts");
	$xml.SelectNodes("//DTS:Variable/DTS:Property[@DTS:Name='ObjectName']", $ns) | Foreach { $_."#text"; }
}

function GetVariable {	  
	param($fileName, $variableName)

	$xml = [xml] (Get-Content $fileName);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace("DTS", "www.microsoft.com/SqlServer/Dts");
	$xml.SelectSingleNode("//DTS:Variable[DTS:Property='$variableName']/DTS:VariableValue", $ns)."#text";
}
```
