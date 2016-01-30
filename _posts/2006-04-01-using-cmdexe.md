---
ID: 115
post_title: Using cmd.exe
author: timvw
post_date: 2006-04-01 02:30:07
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/04/01/using-cmdexe/
published: true
---
<p>Earlier someone asked me how he could use <a href="http://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/cmd.mspx?mfr=true">windows cmd.exe</a> with PHP. People run into trouble as soon as there are quotes needed because there are special characters (&gt;/&()[]{}^=;!'+,`~ and &lt;space&gt;) in the command. I do it like this:</p>
[code lang="php"]<?php
$result = `""c:\\my path\\prog.exe" "filename""`;
?>[/code]
<p>In case you have to do it often you might want to wrap it into a little function like this:</p>
[code lang="php"]<?php
function cmd($command, $arguments = null)
{
        $commandline = '';
        foreach(func_get_args() as $word) {
                $commandline .= '"' . $word . '" ';
        }
        $commandline = rtrim($commandline, ' ');
        $commandline = '"' . $commandline . '"';
        return `$commandline`;
}

// run blah.exe
cmd('blah.exe');

// run c:\my path\blah.exe with the arguments "foo" and "bar bar"
cmd('c:\\my path\\blah.exe', 'foo', 'bar bar');
?>[/code]