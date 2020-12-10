---
title: Some tips for .Net developers using git on cygwin
layout: post
guid: http://www.timvw.be/?p=2083
dsq_thread_id:
  - 1933325226
categories:
  - Uncategorized
tags:
  - cygwin
  - git
  - MSBuild
---
Here are some tips that i want to share with fellow .Net developers that use git on cygwin.

First of all i defined some aliases in my ~/.bashrc:

```bash
# open explorer in the current working directory 
alias explorer='explorer.exe "\`cygpath -aw \"$PWD\"\`"'

# invoke MSBuild
alias msbuild='/cygdrive/c/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe&'
```

Because i do not like the TFS source control story i use [git-tfs](https://github.com/spraints/git-tfs). As a .Net developer you want to add the following to your .git/info/exclude file:

```bash
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
```

Whenever i work online i usually run these two commands consecutively: git -a -m 'commit message' and git-tfs checkin -m 'commit message'. Here is a small ~/bin/commit script that combines these:

```bash
#!/bin/bash
git commit -a -m "$1";
git-tfs checkin -m "$1";
```
