---
id: 119
title: a little hint for writing and testing a script
date: 2005-10-18T02:38:37+00:00
author: timvw
layout: post
guid: http://www.timvw.be/a-little-hint-for-writing-and-testing-a-script/
permalink: /2005/10/18/a-little-hint-for-writing-and-testing-a-script/
categories:
  - Uncategorized
tags:
  - Free Software
  - Vim
---
I noticed that most people think Vim sucks and they constantly perform the following keystrokes

```dos
:wq 
perl somefile.pl 
vim somefile.pl
```

Here is the first trick, you do not need to exit vim to perform a command. Simply type the following while you are in vim

```dos 
:!perl somefile.pl
```

Offcourse, you do not want to type the filename all the time, so you use the following

```dos
:!perl %
```

Now, if you are using a different scripting language it might be more portable to make the file executable (chmod u+x) and make sure the [Shebang](http://en.wikipedia.org/wiki/Shebang) points to the right interpreter. Your script would be something like the following then

```perl
#!/usr/bin/env perl
use strict;
use warnings;
use Socket;
```

Now all you have to do is type the following in vim and your script will be executed

```dos 
:!%
```

I noticed that the :!% trick does not work when your script is in your current working directory. This is how you can make it work

```dos
:!./%
```

I also noticed that before you execute this command you always need to type :w to save the changes. To automate this i have added the following to my ~/.vimrc file

```dos 
map ,r :w<cr>:!./%</cr><cr> 
</cr>
```

Now all i have to type is the following

```dos  
,r  
```

For other tricks and hints you have to check out [Vi-IMproved.org](http://www.vi-improved.org/tutorial.php).
