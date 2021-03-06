---
date: "2010-11-20T00:00:00Z"
guid: http://www.timvw.be/?p=1992
tags:
- AAC
- M4A
- MP3
- PowerShell
- VLC
title: Convert AAC/M4A files to MP3 with VLC and PowerShell
---
Here is a way to convert your AAC/M4A files to MP3 using [VLC](http://www.videolan.org/vlc) media player:

```text
vlc.exe -I dummy old.m4a :sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst=new.mp3} vlc://quit
```

Let's wrap this command in a bit of PowerShell:

```powershell  
function ConvertToMp3([switch] $inputObject, [string] $vlc = 'C:\Program Files\VideoLAN\VLC\vlc.exe') {      
  PROCESS {            
    $codec = 'mp3';        
    $oldFile = $_;

    $newFile = $oldFile.FullName.Replace($oldFile.Extension, ".$codec");

    &"$vlc" -I dummy "$oldFile" ":sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst=\`'$newFile\`'}" vlc://quit | out-null;

    #Only remove source files when you are sure that the conversion works as you want          
    #Remove-Item $oldFile;
  }  
}
```

And now we can use this function for \*all\* m4a files in a given folder:

```powershell
function ConvertAllToMp3([string] $sourcePath) {
  Get-ChildItem "$sourcePath\*" -recurse -include *.m4a | ConvertToMp3;
}
```

Using the function is as easy as:

```powershell
ConvertAllToMp3 'C:\Users\timvw\Music';
```
