---
ID: 2083
post_title: >
  Some tips for .Net developers using git
  on cygwin
author: timvw
post_date: 2011-03-12 10:26:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/12/some-tips-for-net-developers-using-git-on-cygwin/
published: true
dsq_thread_id:
  - "1933325226"
---
<p>Here are some tips that i want to share with fellow .Net developers that use git on cygwin.</p>

<p>First of all i defined some aliases in my ~/.bashrc:</p>

[code lang="bash"]
# open explorer in the current working directory
alias explorer='explorer.exe &quot;`cygpath -aw \&quot;$PWD\&quot;`&quot;'

# invoke MSBuild
alias msbuild='/cygdrive/c/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe'
[/code]

<p>Because i don't like the TFS source control story i use <a href="https://github.com/spraints/git-tfs">git-tfs</a>. As a .Net developer you want to add the following to your .git/info/exclude file:</p>

[code lang="bash"]
#OS junk files
[Tt]humbs.db
*.DS_Store

#Visual Studio files
*.[Oo]bj
*.exe
*.pdb
*.user
*.aps
*.pch
*.vspscc
*.vssscc
*_i.c
*_p.c
*.ncb
*.suo
*.tlb
*.tlh
*.bak
*.[Cc]ache
*.ilk
*.log
*.lib
*.sbr
*.sdf
ipch/
obj/
[Bb]in
[Dd]ebug*/
[Rr]elease*/
Ankh.NoLoad

#Tooling
_ReSharper*/
*.resharper
[Tt]est[Rr]esult*

#Subversion files
.svn
[/code]

<p>Whenever i work online i usually run these two commands consecutively: git -a -m "commit message" and git-tfs checkin -m "commit message". Here is a small ~/bin/commit script that combines these:</p>

[code lang="bash"]
#!/bin/bash
git commit -a -m &quot;$1&quot;;
git-tfs checkin -m &quot;$1&quot;;
[/code]