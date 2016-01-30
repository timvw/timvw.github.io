---
ID: 31
post_title: >
  Building apache-win32 with Visual Studio
  2005
author: timvw
post_date: 2006-04-15 02:44:35
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/04/15/building-apache-win32-with-visual-studio-2005/
published: true
dsq_thread_id:
  - "1920134122"
---
<p>Today i decided to build apache-win32. Here's how i did it:</p>
<ul>
<li>Download Apache <a href="http://apache.be.proserve.nl/httpd/httpd-2.2.0-win32-src-rev2.zip">httpd-2.2.0-win32-src-rev2.zip</a>.</li>
<li>Unzip and read README.TXT, INSTALL.TXT and docs/manual/platform/win_compiling.html.en</li>
<li>Save <a href="http://cm.bell-labs.com/cm/cs/who/bwk/awk95.exe">awk95.exe</a> as awk.exe in a directory that's in your %PATH%.</li>
<li>Open Apache.dsw with VS2005 and choose "Yes To All" to convert the project.</li>
<li>Uncheck abs, mod_deflate and mod_ssl in the the configuration form via Build -> Configuration Manager.</li>
<li>Choose InstallBin, click right and Set as StartUp Project.</li>
<li>Open InstallBin/Makefile.win and remove the lines 129, 130, 131, 133, 134, 135 and 136.</li>
<li>Start debugging (F5). Stop debugging and end the httpd.exe process via your Task Manager.</li>
<li>Download and extract <a href="http://www.zlib.net/zlib-1.2.3.tar.bz2">zlib-1.2.3.tar.bz2</a> into srclib/zlib.</li>
<li>Prepend "dword ptr" to the second argument of the movd instructions on lines647, 649, 663 and 720 in srclib/zlib/contrib/masmx86/inffas32.asm</li>
<li>Open srclib/zlib/projects/visualc6/zlib.dsp, choose the zlib project in the solution explorer. Choose "LIB ASM Release" in the configuration explorer and build zlib.</li>
<li>Copy srclib/zlib/projects/visualc6/Win32_LIB_ASM_Release/zlib.lib to srclib/zlib.</li>
<li>Check the mod_deflate in the configuration form via Build -> Configuration Manager.</li>
<li>Choose the mod_deflate project in the solution explorer and build it.</li>
<li>The original <a href="http://www.openssl.org/source/openssl-0.9.8a.tar.gz">openssl-0.9.8a.tar.gz</a> doesn't compile with Visual Studio 2005 but someone has already made a <a href="http://bbdev.fluffy.co.uk/svn/box/chris/win32/support/openssl-0.9.8a-win32fix.patch">patch</a>. Download <a href="http://bbdev.fluffy.co.uk/svn/box/chris/win32/support/openssl-0.9.8a-vc2005.zip">openssl-0.9.8a-vc2005.zip</a> and extract it into srclib/openssl.</li>
<li>Open a Visual Studio 2005 Command Prompt and cd to the openssl directory and run: "perl Configure VC-WIN32" (don't close this prompt yet).</li>
<li>Insert before line 61 in srclib/openssl/ms/do_masm.bat the following line: "perl util\mk1mf.pl debug dll VC-WIN32 > ms\ntdll-dbg.mak". Now run: "ms\do_masm" and "nmake -f ms\ntdll-dbg.mak".</li>
<li>Check the abs and mod_ssl project in the configuration from via Build -> Configuration Manager.</li>
<li>Build the two projects.</li>
<li>Done!</li>
</ul>