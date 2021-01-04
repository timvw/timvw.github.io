---
date: "2006-04-15T00:00:00Z"
tags:
- Free Software
title: Building apache-win32 with Visual Studio 2005
aliases:
 - /2006/04/15/building-apache-win32-with-visual-studio-2005/
 - /2006/04/15/building-apache-win32-with-visual-studio-2005.html
---
Today i decided to build apache-win32. Here's how i did it:

* Download Apache [httpd-2.2.0-win32-src-rev2.zip](http://apache.be.proserve.nl/httpd/httpd-2.2.0-win32-src-rev2.zip).
* Unzip and read README.TXT, INSTALL.TXT and docs/manual/platform/win_compiling.html.en
* Save [awk95.exe](http://cm.bell-labs.com/cm/cs/who/bwk/awk95.exe) as awk.exe in a directory that's in your %PATH%.
* Open Apache.dsw with VS2005 and choose "Yes To All" to convert the project.
* Uncheck abs, mod\_deflate and mod\_ssl in the the configuration form via Build -> Configuration Manager.
* Choose InstallBin, click right and Set as StartUp Project.
* Open InstallBin/Makefile.win and remove the lines 129, 130, 131, 133, 134, 135 and 136.
* Start debugging (F5). Stop debugging and end the httpd.exe process via your Task Manager.
* Download and extract [zlib-1.2.3.tar.bz2](http://www.zlib.net/zlib-1.2.3.tar.bz2) into srclib/zlib.
* Prepend "dword ptr" to the second argument of the movd instructions on lines647, 649, 663 and 720 in srclib/zlib/contrib/masmx86/inffas32.asm
* Open srclib/zlib/projects/visualc6/zlib.dsp, choose the zlib project in the solution explorer. Choose "LIB ASM Release" in the configuration explorer and build zlib.
* Copy srclib/zlib/projects/visualc6/Win32\_LIB\_ASM_Release/zlib.lib to srclib/zlib.
* Check the mod_deflate in the configuration form via Build -> Configuration Manager.
* Choose the mod_deflate project in the solution explorer and build it.
* The original [openssl-0.9.8a.tar.gz](http://www.openssl.org/source/openssl-0.9.8a.tar.gz) doesn't compile with Visual Studio 2005 but someone has already made a [patch](http://bbdev.fluffy.co.uk/svn/box/chris/win32/support/openssl-0.9.8a-win32fix.patch). Download [openssl-0.9.8a-vc2005.zip](http://bbdev.fluffy.co.uk/svn/box/chris/win32/support/openssl-0.9.8a-vc2005.zip) and extract it into srclib/openssl.
* Open a Visual Studio 2005 Command Prompt and cd to the openssl directory and run: "perl Configure VC-WIN32" (don't close this prompt yet).
* Insert before line 61 in srclib/openssl/ms/do\_masm.bat the following line: "perl util\mk1mf.pl debug dll VC-WIN32 > ms\ntdll-dbg.mak". Now run: "ms\do\_masm" and "nmake -f ms\ntdll-dbg.mak".
* Check the abs and mod_ssl project in the configuration from via Build -> Configuration Manager.
* Build the two projects.
* Done!
