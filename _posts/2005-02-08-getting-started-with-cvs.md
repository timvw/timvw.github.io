---
ID: 99
post_title: Getting started with CVS
author: timvw
post_date: 2005-02-08 01:44:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/02/08/getting-started-with-cvs/
published: true
---
<p>I got an e-mail that asked me how to get started with CVS as quick as possible. The first time i got lost too. So i'll give a quick summary how i did it (no p-server).</p>

<p>The repository will live on a <a href="http://www.debian.org">debian</a> machine in /home/users/timvw/services/cvs.</p>

[code lang="bash"]
timvw@debian: apt-get install cvs # get the tools
timvw@debian: cvs -d /home/users/timvw/services/cvs init # create repository
[/code]

<p>On my windows machine i use <a href="http://www.tortoisecvs.org">TortoiseCVS</a>. I want to make a module pecl that will contain all my <a href="http://pecl.php.net">pecl</a> related code.</p>
<p>1. Configure TortoiseCVS to use the <a href="http://www.ssh.com">SSH.com</a> client instead of the built-in <a href="http://www.chiark.greenend.org.uk/~sgtatham/putty/">Putty</a>.</p>
<p style="text-align: center;"><img src="http://www.timvw.be/wp-content/images/cvsconfigure.gif" alt="configure" /></p>
<p>2. Fill in the path to the SSH binary (tools tab).</p>
<p style="text-align: center;"><img src="http://www.timvw.be/wp-content/images/cvstools.gif" alt="configure" /></p>
<p>3. Create a directory that will hold the code (i choose pecl as name).</p>
<p style="text-align: center;"><img src="http://www.timvw.be/wp-content/images/cvsnewdirectory.gif" alt="new directory" /></p>
<p>4. Create a module (Choose the directory you created and click right).</p>
<p style="text-align: center;"><img alt="new module" src="http://www.timvw.be/wp-content/images/cvsnewmodule.gif" /></p>
<p>5. Fill in the settings.</p>
<p style="text-align: center;"><img alt="module settings" src="http://www.timvw.be/wp-content/images/cvsmodulesettings.gif" /></p>
<p>6. Hit Ok to initialise the module.</p>
<p style="text-align: center;"><img alt="module init" src="http://www.timvw.be/wp-content/images/cvsinit.gif" /></p>
<p>7. Create a README file and add it to the module.</p>
<p style="text-align: center;"><img alt="add file to module" src="http://www.timvw.be/wp-content/images/cvsadd.gif" /></p>
<p style="text-align: center;"><img alt="add file to module" src="http://www.timvw.be/wp-content/images/cvsadd2.gif" /></p>
<p>8. Add a comment message</p>
<p style="text-align: center;"><img alt="add comment" src="http://www.timvw.be/wp-content/images/cvsaddcomment.gif" /></p>
<p>9. Commit the changes</p>
<p style="text-align: center;"><img alt="commit" src="http://www.timvw.be/wp-content/images/cvscommit.gif" /></p>
<p>10. Update your files (Other people have commited their changes).</p>
<p style="text-align: center;"><img alt="update" src="http://www.timvw.be/wp-content/images/cvsupdate.gif" /></p>
<p>11. Read The Fine Manual at <a href="http://cvsbook.red-bean.com/cvsbook.html">http://cvsbook.red-bean.com/cvsbook.html</a></p>