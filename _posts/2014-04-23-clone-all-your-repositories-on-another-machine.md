---
title: Clone all your repositories on another machine
layout: post
guid: http://www.timvw.be/?p=2411
categories:
  - Uncategorized
tags:
  - git bash awk
---
Recently I was configuring a new machine (God, i love [Chocolatey](https://chocolatey.org/)) and I wanted to take all the repositories I have under c:/src and clone them on my new machine. Here is how i did that:

```bash
# write all remote fetch locations into repositories.txt  
find /c/src -type d -mindepth 1 -maxdepth 1 -exec git -work-tree={} -git-dir={}/.git remote -v \; | grep fetch | awk '{print $2}' > repositories.txt

# clone each repository  
cat repositories.txt | xargs -l1 git clone
```

Or as a gist: <https://gist.github.com/timvw/11208834>.