---
date: "2010-05-02T00:00:00Z"
guid: http://www.timvw.be/?p=1719
tags:
- CSharp
title: Enumerating SpecialFolders
---
[Environment.SpecialFolder](http://msdn.microsoft.com/en-us/library/system.environment.specialfolder.aspx) is a value-type that i always seem to forget about. Let's try to do something about that by posting about it here :)

```csharp
foreach (var name in Enum.GetNames(typeof(Environment.SpecialFolder)))
{
	var specialFolder = (Environment.SpecialFolder)Enum.Parse(typeof(Environment.SpecialFolder), name);
	Console.WriteLine("{0,25} => {1}", name, Environment.GetFolderPath(specialFolder));
}
```

<table>
  <tr>
    <td>
      Desktop
    </td>
    <td>
      C:\Users\timvw\Desktop
    </td>
  </tr>
  
  <tr>
    <td>
      Programs
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
    </td>
  </tr>
  
  <tr>
    <td>
      Personal
    </td>
    
    <td>
      C:\Users\timvw\Documents
    </td>
  </tr>
  
  <tr>
    <td>
      MyDocuments
    </td>
    
    <td>
      C:\Users\timvw\Documents
    </td>
  </tr>
  
  <tr>
    <td>
      Favorites
    </td>
    
    <td>
      C:\Users\timvw\Favorites
    </td>
  </tr>
  
  <tr>
    <td>
      Startup
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    </td>
  </tr>
  
  <tr>
    <td>
      Recent
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\Recent
    </td>
  </tr>
  
  <tr>
    <td>
      SendTo
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\SendTo
    </td>
  </tr>
  
  <tr>
    <td>
      StartMenu
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\Start Menu
    </td>
  </tr>
  
  <tr>
    <td>
      MyMusic
    </td>
    
    <td>
      C:\Users\timvw\Music
    </td>
  </tr>
  
  <tr>
    <td>
      DesktopDirectory
    </td>
    
    <td>
      C:\Users\timvw\Desktop
    </td>
  </tr>
  
  <tr>
    <td>
      MyComputer
    </td>
    
    <td>
    </td>
  </tr>
  
  <tr>
    <td>
      Templates
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\Templates
    </td>
  </tr>
  
  <tr>
    <td>
      ApplicationData
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming
    </td>
  </tr>
  
  <tr>
    <td>
      LocalApplicationData
    </td>
    
    <td>
      C:\Users\timvw\AppData\Local
    </td>
  </tr>
  
  <tr>
    <td>
      InternetCache
    </td>
    
    <td>
      C:\Users\timvw\AppData\Local\Microsoft\Windows\Temporary Internet Files
    </td>
  </tr>
  
  <tr>
    <td>
      Cookies
    </td>
    
    <td>
      C:\Users\timvw\AppData\Roaming\Microsoft\Windows\Cookies
    </td>
  </tr>
  
  <tr>
    <td>
      History
    </td>
    
    <td>
      C:\Users\timvw\AppData\Local\Microsoft\Windows\History
    </td>
  </tr>
  
  <tr>
    <td>
      CommonApplicationData
    </td>
    
    <td>
      C:\ProgramData
    </td>
  </tr>
  
  <tr>
    <td>
      System
    </td>
    
    <td>
      C:\Windows\system32
    </td>
  </tr>
  
  <tr>
    <td>
      ProgramFiles
    </td>
    
    <td>
      C:\Program Files
    </td>
  </tr>
  
  <tr>
    <td>
      MyPictures
    </td>
    
    <td>
      C:\Users\timvw\Pictures
    </td>
  </tr>
  
  <tr>
    <td>
      CommonProgramFiles
    </td>
    
    <td>
      C:\Program Files\Common Files
    </td>
  </tr>
</table>
