---
date: "2005-02-08T00:00:00Z"
tags:
- Free Software
title: Getting started with CVS
---
I got an e-mail that asked me how to get started with CVS as quick as possible. The first time i got lost too. So i'll give a quick summary how i did it (no p-server).

The repository will live on a [debian](http://www.debian.org) machine in /home/users/timvw/services/cvs.

```bash
timvw@debian: apt-get install cvs # get the tools
timvw@debian: cvs -d /home/users/timvw/services/cvs init # create repository
```

On my windows machine i use [TortoiseCVS](http://www.tortoisecvs.org). I want to make a module pecl that will contain all my [pecl](http://pecl.php.net) related code.

1. Configure TortoiseCVS to use the [SSH.com](http://www.ssh.com) client instead of the built-in [Putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/).

<p style="text-align: center;">
  <img src="http://www.timvw.be/wp-content/images/cvsconfigure.gif" alt="configure" />
</p>

2. Fill in the path to the SSH binary (tools tab).

<p style="text-align: center;">
  <img src="http://www.timvw.be/wp-content/images/cvstools.gif" alt="configure" />
</p>

3. Create a directory that will hold the code (i choose pecl as name).

<p style="text-align: center;">
  <img src="http://www.timvw.be/wp-content/images/cvsnewdirectory.gif" alt="new directory" />
</p>

4. Create a module (Choose the directory you created and click right).

<p style="text-align: center;">
  <img alt="new module" src="http://www.timvw.be/wp-content/images/cvsnewmodule.gif" />
</p>

5. Fill in the settings.

<p style="text-align: center;">
  <img alt="module settings" src="http://www.timvw.be/wp-content/images/cvsmodulesettings.gif" />
</p>

6. Hit Ok to initialise the module.

<p style="text-align: center;">
  <img alt="module init" src="http://www.timvw.be/wp-content/images/cvsinit.gif" />
</p>

7. Create a README file and add it to the module.

<p style="text-align: center;">
  <img alt="add file to module" src="http://www.timvw.be/wp-content/images/cvsadd.gif" />
</p>

<p style="text-align: center;">
  <img alt="add file to module" src="http://www.timvw.be/wp-content/images/cvsadd2.gif" />
</p>

8. Add a comment message

<p style="text-align: center;">
  <img alt="add comment" src="http://www.timvw.be/wp-content/images/cvsaddcomment.gif" />
</p>

9. Commit the changes

<p style="text-align: center;">
  <img alt="commit" src="http://www.timvw.be/wp-content/images/cvscommit.gif" />
</p>

10. Update your files (Other people have commited their changes).

<p style="text-align: center;">
  <img alt="update" src="http://www.timvw.be/wp-content/images/cvsupdate.gif" />
</p>

11. Read The Fine Manual at <http://cvsbook.red-bean.com/cvsbook.html>
