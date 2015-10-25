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
Configuration files are typically small and can be easily read into memory.

```PowerShell
$contents = Get-Content 'c:\temp\Web.config'
```
The following lines tells Powershell to convert the contents into an XmlDocument:

```PowerShell
[xml] $document = $contents
```
Changing the value for enableFeature is as easy as:

```PowerShell
Write-Host $document.configuration.appSettings.add |Where { $_.key -eq 'enableFeature' } |% { $_.value = 'False' }
```






