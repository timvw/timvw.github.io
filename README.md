# DevOps for the .NET developer (using PowerShell)

Topics I would like to cover are the following:
* Working with XML (System.Xml.XmlDocument)
* Configuring IIS (appcmd.exe)
* Managing MSMQ (System.Messaging.MessageQueue)
* Enabling windows features (dism.exe)
* Teamcity
* Managing windows services (sc.exe)
* Windows Registry

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

When a namespace is defined on the Xml document, you will have to register this. 
Here is an example to find all references in a csproj file:

```Xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="4.0">
  <ItemGroup>
    <Reference Include="KeePass">
      <HintPath>..\..\keepass\Build\KeePass\Debug\KeePass.exe</HintPath>
    </Reference>
    <Reference Include="Newtonsoft.Json">
      <HintPath>Newtonsoft.Json.dll</HintPath>
    </Reference>
    <Reference Include="System" />
    <Reference Include="System.Core" />
    <Reference Include="System.Drawing" />
    <Reference Include="System.Windows.Forms" />
    <Reference Include="System.Xml.Linq" />
    <Reference Include="System.Data.DataSetExtensions" />
    <Reference Include="System.Data" />
    <Reference Include="System.Xml" />
  </ItemGroup>
</Project>
```

```PowerShell
[xml] $xml = Get-Content 'c:\temp\Project.csproj'
$ns = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
$ns.AddNamespace("msb", $xml.DocumentElement.NamespaceURI)
$nodes = $WebConfigXml.SelectNodes('//msb:Reference', $ns)
```

## Configuring IIS

[appcmd.exe](http://www.iis.net/learn/get-started/getting-started-with-iis/getting-started-with-appcmdexe) is the command line tool to manage IIS. In combination with PowerShell it becomes plain easy.
PowerShell can easily consume the output from appcmd.exe when  using the /xml flag

```PowerShell
[xml] $result = &appcmd.exe list app /xml
result.appcmd.APP
```

Here we show how to stop each application pool:

```PowerShell
([xml](appcmd.exe list apppool /xml)).appcmd.APPPOOL.'APPPOOL.NAME' |% { appcmd.exe stop apppool /apppool.name:$_ }
```



## Teamcity

There seems to be an issue with basic auth implementation in Tomcat/Teamcity. Here is how you can workaround this:

```PowerShell
$webclient = new-object System.Net.WebClient
$credentials = [System.Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($username + ":" + $password))
$webClient.Headers["Authorization"] = "Basic {0}" -f $credentials   
    
$url = "$teamcityUrl/httpAuth/app/rest/builds?count=1&buildType=id:$buildTypeId&locator=branch:name:$branchName,status:SUCCESS"
[xml]$xml = $webClient.DownloadString($url)

$url = "$teamcityUrl/repository/downloadAll/{0}/{1}:id" -f $buildTypeId, $buildId
$artifactPath = "$downloadDir\$buildTypeId.zip"
$webclient.DownloadFile($url, $artifactPath)
        
[System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem') | Out-Null
[System.IO.Compression.ZipFile]::ExtractToDirectory($artifactPath, $extractDir)
```

* Windows registry

Here is an example that writes an NServiceBus license key to the registry

```PowerShell
New-Item -Path HKLM:\Software\ParticularSoftware\NServiceBus
$content = Get-Content '\\files.icteam.be\data\nservicebus.license' | Out-String; 
Set-ItemProperty -Path HKLM:\Software\ParticularSoftware\NServiceBus -Name License -Force -Value $content"
```

* Issuing SQL commands on Oracle via sqlplus

```PowerShell

function GetSqlPlusPath {
	$path = 'C:\oraclexe\app\oracle\product\11.2.0\server\bin\sqlplus.exe'
	$path
}

function GetConnectionString {
	param(
		[string] $Username = 'SYSTEM',
		[string] $Password = 'password',
		[string] $Hostname = 'localhost',
		[string] $Port = '1521',
		[string] $Instance = 'xe'
	)

	$connectionString = '{0}/{1}@//{2}:{3}/{4}' -f $Username, $Password, $Hostname, $Port, $Instance
	$connectionString
}

function InvokeSqlPlus {
    param(
        [string] $SqlCommand = '',
        [string] $ConnectionString = (GetConnectionString),
		[string] $SqlPlus = (GetSqlPlusPath)
    )
    
    echo "$SqlCommand;" | & "$SqlPlus" -silent "$ConnectionString" | Out-Null
}
```

## Manage MSMQ

When using WCF MSMQ one has to create the queues manually. Here is some sample code that discovers the queues in Web.config files and creates them.

```PowerShell
function FindLocalQueues {
    param(
		[string] $BasePath = 'C:\src\trunk'
    )

	$AppConfigFiles = Get-ChildItem $BasePath -Name 'Web.Config' -Recurse |% { "$BasePath\$_" }
	
	$AppConfigFiles |% { 
		[xml] $Xml = Get-Content $_
		$Xml.SelectNodes("//endpoint") | Where { $_.address -like 'net.msmq://localhost/*' } |% { $_.GetAttribute("address") } |% { $_.Replace("net.msmq://localhost/private/", ".\private$\")  }
	}
}

function CreateLocalQueues {
	param(
		$BasePath = 'C:\src\trunk',
		$UserToGrantPermissions = 'EVERYONE'
	)
	
    [void] [Reflection.Assembly]::LoadWithPartialName("System.Messaging")

    FindLocalQueues -BasePath "$BasePath" |% { 
		[System.Messaging.MessageQueue]::Create("$_", $true) 
		$Queue = New-Object System.Messaging.MessageQueue("$_")
		$Queue.UseJournalQueue = $True; 
		$Queue.Authenticate = $False;
        $Queue.SetPermissions($UserToGrantPermissions, [System.Messaging.MessageQueueAccessRights]::ReceiveMessage, [System.Messaging.AccessControlEntryType]::Allow)
        $Queue.SetPermissions($UserToGrantPermissions, [System.Messaging.MessageQueueAccessRights]::PeekMessage, [System.Messaging.AccessControlEntryType]::Allow)
        $Queue.SetPermissions($UserToGrantPermissions, [System.Messaging.MessageQueueAccessRights]::WriteMessage, [System.Messaging.AccessControlEntryType]::Allow)		
	}
}

function PurgePrivateQueues {
    [void] [Reflection.Assembly]::LoadWithPartialName("System.Messaging")
    [System.Messaging.MessageQueue]::GetPrivateQueuesByMachine(".") |% { $_.Purge(); }
}

function DropPrivateQueues {
    [void] [Reflection.Assembly]::LoadWithPartialName("System.Messaging")
    [System.Messaging.MessageQueue]::GetPrivateQueuesByMachine(".") |% { [System.Messaging.MessageQueue]::Delete($_.Path) }
}

function PurgeSystemJournalAndDeadLetterQueues {
    [void] [Reflection.Assembly]::LoadWithPartialName("System.Messaging")
	
	$JournalQueue = New-Object System.Messaging.MessageQueue("FORMATNAME:DIRECT=OS:.\SYSTEM$;JOURNAL")
	$JournalQueue.Purge()
	
	$DeadLetterQueue = New-Object System.Messaging.MessageQueue("FORMATNAME:DIRECT=OS:.\SYSTEM$;DEADLETTER")
	$DeadLetterQueue.Purge()

	$DeadLetterTxQueue = New-Object System.Messaging.MessageQueue("FORMATNAME:DIRECT=OS:.\SYSTEM$;DEADXACT")
	$DeadLetterTxQueue.Purge()	
}
```
