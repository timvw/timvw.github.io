---
ID: 2411
post_title: >
  Clone all your repositories on another
  machine
author: timvw
post_date: 2014-04-23 10:47:00
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2014/04/23/clone-all-your-repositories-on-another-machine/
published: true
---
<p>Recently I was configuring a new machine (God, i love <a href="https://chocolatey.org/">Chocolatey</a>) and I wanted to take all the repositories I have under c:/src and clone them on my new machine. Here is how i did that:</p>

[code lang="bash"]
# write all remote fetch locations into repositories.txt
find /c/src -type d -mindepth 1 -maxdepth 1 -exec git --work-tree={} --git-dir={}/.git remote -v \; | grep fetch | awk '{print $2}' &gt; repositories.txt

# clone each repository
cat repositories.txt | xargs -l1 git clone
[/code]

<p>Or as a gist: <a href="https://gist.github.com/timvw/11208834">https://gist.github.com/timvw/11208834</a>.</p>