---
date: "2011-03-12T00:00:00Z"
guid: http://www.timvw.be/?p=2099
tags:
- Bash
- git-tfs
title: Consume locally build software without overloading your $PATH
---
How do you consume locally build software? For a while now i have used the following approach:

  * Create a ~/bin folder
  * Add that ~/bin folder to my $PATH
  * Add symlinks from binary to ~/bin (ln -s ~/src/git-tfs/GitTfs.Vs2010/bin/debug/git-tfs.exe git-tfs)
  
Please let me know about your strategy..
