---
date: "2010-11-11T00:00:00Z"
guid: http://www.timvw.be/?p=1978
tags:
- PowerShell
- SSIS
title: Update ConfigurationStrings in SSIS package with PowerShell
aliases:
 - /2010/11/11/update-configurationstrings-in-ssis-package-with-powershell/
 - /2010/11/11/update-configurationstrings-in-ssis-package-with-powershell.html
---
Here are some functions that allow you to update ConfigurationStrings in a SSIS package (dtsx) using PowerShell:

```powershell
function UpdateConfigurationStrings($file)
{
	$xml = [xml] (Get-Content $file);
	$ns = New-Object Xml.XmlNamespaceManager $xml.NameTable;
	$ns.AddNamespace("DTS", "www.microsoft.com/SqlServer/Dts");
	UpdateConfigurationNodes $xml $ns;
	Set-Content $file $xml.OuterXml;
}

function UpdateConfigurationNodes($xml, $ns)
{
	$selectConfigurationNodes = "//DTS:Configuration";
	$xml.SelectNodes($selectConfigurationNodes, $ns) | foreach { UpdateConfigurationNode $_ $ns; };
}

function UpdateConfigurationNode($configurationNode, $ns)
{
	$selectConfigurationString = "./DTS:Property[@DTS:Name='ConfigurationString']";
	$configurationStringNode = $configurationNode.SelectSingleNode($selectConfigurationString, $ns);

	$oldConfigurationStringValue = $configurationStringNode.'#text';
	$newConfigurationStringValue = GetNewConfigurationStringValue $oldConfigurationStringValue;
	$configurationStringNode.'#text' = "$newConfigurationStringValue";
}

function GetNewConfigurationStringValue($oldConfigurationStringValue)
{
	# implement some logic to determine new value
	return "new value";
}
```
