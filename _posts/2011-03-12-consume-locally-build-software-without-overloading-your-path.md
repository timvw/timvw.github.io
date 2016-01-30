---
ID: 2099
post_title: >
  Consume locally build software without
  overloading your $PATH
author: timvw
post_date: 2011-03-12 17:08:38
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/12/consume-locally-build-software-without-overloading-your-path/
published: true
---
<p>How do you consume locally build software? For a while now i have used the following approach:</p>

<ul>
<li>Create a ~/bin folder</li>
<li>Add that ~/bin folder to my $PATH</li>
<li>Add symlinks from binary to ~/bin (ln -s ~/src/git-tfs/GitTfs.Vs2010/bin/debug/git-tfs.exe git-tfs)
</ul>

<p>Please let me know about your strategy..</p>