# DevOps for the .NET developer (using PowerShell)

Topics I would like to cover are the following:
* Manipulating XML files
* Configuring IIS
* Managing MSMQ
* Enabling windows features  

## Manipulating XML 

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






