# DevOps for the .NET developer (using PowerShell)

Topics I would like to cover are the following:
* Working with XML
* Configuring IIS
* Managing MSMQ
* Enabling windows features  

## Working with XML 

Assume that we have a Web.config file in which we want to change the value for enableFeature from True to False.

```Xml
<configuration>
  <appSettings>
    <add key="enableFeature" value="True" />
  </appSettings>
</configuration>
```

Configuration files are typically small and can be easily read into memory. The following snippet reads the contents of the file, create an XmlDocument from the contents and then navigates to the 'add' node with key 'enableFeature' and sets the 'value' attribute to 'False':

```PowerShell
$file = 'c:\temp\Web.config'
$contents = Get-Content $file
[xml] $document = $contents
$document.configuration.appSettings.add |Where { $_.key -eq 'enableFeature' } |% { $_.value = 'False' }
$document.Save($file)
```

Another example is reporting which nuget packages are being used in a solution. Here is an example of a typical packages.config file:

```Xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
  <package id="AutoMapper" version="1.1.0.118" targetFramework="net45" />
  <package id="Log4net" version="2.0.3" targetFramework="net45" />
  <package id="Newtonsoft.Json" version="6.0.4" targetFramework="net45" />
  <package id="NServiceBus.Interfaces" version="4.4.2" targetFramework="net45" />
</packages>
```

```PowerShell
function GetPackageIds {
  param(
    $File
  )
  
  [xml] $xml = Get-Content $File; 
  $xml.packages.package |% { $_.id }
}
```

And now we can call this function for each file in the solution:

```PowerShell
$configFiles = Get-ChildItem c:\src\Solution -Filter packages.config -Recurse
$packageIds = $configFiles |% { GetPackageIds -File $_.FullName }
```

One annoyance you will encounter is when you try to navigate over an empty collection, here is an example:

```Xml
<configuration>
  <appSettings>
  </appSettings>
</configuration>
```


```PowerShell
[xml] $xml = Get-Content $file

$element = $xml.CreateElement('add')
$element.setAttribute('key', 'enableFeature')
$element.setAttribute('value', 'True')

$xml.configuration.appSettings.AppendChild($element)
```

In order to avoid the null exception you will need an XPath query:

```PowerShell
$appSettings = $xml.SelectSingleNode('/configuration/appSettings')
$appSettings.AppendChild($element)
```










