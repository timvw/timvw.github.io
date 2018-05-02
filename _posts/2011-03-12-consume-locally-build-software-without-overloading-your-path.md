---
id: 2099
title: Consume locally build software without overloading your $PATH
date: 2011-03-12T17:08:38+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2099
permalink: /2011/03/12/consume-locally-build-software-without-overloading-your-path/
categories:
  - Uncategorized
tags:
  - Bash
  - git-tfs
---
How do you consume locally build software? For a while now i have used the following approach:

  * Create a ~/bin folder
  * Add that ~/bin folder to my $PATH
  * Add symlinks from binary to ~/bin (ln -s ~/src/git-tfs/GitTfs.Vs2010/bin/debug/git-tfs.exe git-tfs)
  
Please let me know about your strategy..
