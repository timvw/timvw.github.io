---
ID: 1992
post_title: >
  Convert AAC/M4A files to MP3 with VLC
  and PowerShell
author: timvw
post_date: 2010-11-20 21:19:27
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/20/convert-aacm4a-files-to-mp3-with-vlc-and-powershell/
published: true
dsq_thread_id:
  - "1927770392"
---
<p>Here is a way to convert your AAC/M4A files to MP3 using <a href="http://www.videolan.org/vlc">VLC</a> media player:</p>

[code lang="text"]
vlc.exe -I dummy old.m4a :sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst=new.mp3} vlc://quit
[/code]

<p>Let's wrap this command in a bit of PowerShell:</p>

[code lang="powershell"]
function ConvertToMp3([switch] $inputObject, [string] $vlc = 'C:\Program Files\VideoLAN\VLC\vlc.exe') {
    PROCESS {
        $codec = 'mp3';
        $oldFile = $_;
        $newFile = $oldFile.FullName.Replace($oldFile.Extension, &quot;.$codec&quot;);
        &amp;&quot;$vlc&quot; -I dummy &quot;$oldFile&quot; &quot;:sout=#transcode{acodec=$codec,vcodec=dummy}:standard{access=file,mux=raw,dst=`'$newFile`'}&quot; vlc://quit | out-null;
        #Only remove source files when you are sure that the conversion works as you want
        #Remove-Item $oldFile;
    }
}
[/code]

<p>And now we can use this function for *all* m4a files in a given folder:</p>

[code lang="powershell"]
function ConvertAllToMp3([string] $sourcePath) {
    Get-ChildItem &quot;$sourcePath\*&quot; -recurse -include *.m4a | ConvertToMp3;
}
[/code]

<p>Using the function is as easy as:</p>

[code lang="powershell"]
ConvertAllToMp3 'C:\Users\timvw\Music';
[/code]