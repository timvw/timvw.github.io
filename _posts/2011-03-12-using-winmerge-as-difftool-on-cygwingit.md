---
ID: 2079
post_title: Using WinMerge as difftool on cygwin/git
author: timvw
post_date: 2011-03-12 10:06:26
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/12/using-winmerge-as-difftool-on-cygwingit/
published: true
---
<p>Last couple of weeks i have been using <a href="http://git-scm.com/">Git</a> on <a href="http://www.cygwin.com">cygwin</a> and i got very satisfying results out of it. One thing that i wanted to tweak was the ability to use <a href="http://winmerge.org/">WinMerge</a> to compare files. Here is how i do it:</p>

<p>Here is my ~/.gitconfig:</p>

[code lang="bash"]
[user]
	name = Tim Van Wassenhove
	email = git@timvw.be
	
[diff]	
	external = &quot;~/bin/git-diff-wrapper.sh&quot;
[/code]

<p>Here is my ~/bin/git-diff-wrapper.sh (it uses <a href="http://www.cygwin.com/cygwin-ug-net/using-utils.html">cygpath</a> to translate the paths):</p>

[code lang="bash"]
#!/bin/sh
&quot;/cygdrive/c/Program Files/WinMerge/WinMergeU.EXE&quot; /e /ub /dl other /dr local &quot;`cygpath -aw $1`&quot; &quot;`cygpath -aw $2`&quot; &quot;`cygpath -aw $5`&quot;
[/code]

<p>And now we're good to go ;)</p>