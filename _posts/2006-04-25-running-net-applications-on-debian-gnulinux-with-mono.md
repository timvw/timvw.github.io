---
title: Running .NET applications on Debian GNU/Linux with Mono
layout: post
tags:
  - Free Software
---
Today i noticed [Running .Net applications on Linux with Mono](http://www.linux.com/article.pl?sid=06/04/12/1921225) and the author wrote the following:

> I found that on Debian at this stage I got an error: The assembly mscorlib.dll was not found or could not be loaded. It should have been installed in the '/usr/lib/mono/2.0/mscorlib.dll' directory. I cured that by executing:
  
> $ cd /usr/lib/mono
  
> $ sudo ln -s 1.0 2.0 

There is only one error, and it's in the [PEBKAC](en.wikipedia.org/wiki/PEBKAC) category. I can understand that the author couldn't find the TargetFrameworkVersion tag in his project file and generated 2.0 code. What i don't understand is that he didn't notice the [Other Downloads](http://www.mono-project.com/Downloads) section and that there are [Debian](http://www.debian.org) packages available with support for the 2.0 runtime. Ok, apt-get might complain about the packages and you would have to add a key to your keyring as following before you can install the packages

```dos
gpg --recv-keys 7127E5ABEEF946C8
gpg --armor --export 7127E5ABEEF946C8 | apt-key add --
```

How hard is that?
