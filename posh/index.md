# DevOps for the .NET developer (using PowerShell)

Topics I would like to cover are the following:
* Manipulating XML files
* Configuring IIS
* Managing MSMQ
* Enabling windows features  

## Manipulating XML 

Configuration files are typically small and can be easily read into memory:

```PowerShell
$contents = Get-Content 'c:\temp\Web.config'
```
The following lines tells Powershell to convert the contents into an XmlDocument:

```PowerShell
[xml] $document = $contents
```

Assume that our Web.config file was the following:

```Xml
<configuration>
  <appSettings>
  </appSettings>
</configuration>
```




