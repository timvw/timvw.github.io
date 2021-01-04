---
date: "2016-10-01T00:00:00Z"
title: Docker toolbox to the rescue
---
With the help of [Docker Toolbox](https://www.docker.com/products/docker-toolbox) a lot of apps become easily available...

By default volumes can only be mapped on folders under the user home directory.

Here is how to enable mapping of the entire c-drive

```bash
#!/bin/sh
# script to expose c-drive to docker vm and docker containers
#
# stop the docker vm
docker-machine stop default
# share your windows c-drive with the docker (host) vm
/c/Program\ Files/Oracle/VirtualBox/VBoxManage.exe sharedfolder add default --name C_DRIVE --hostpath c:/
# start the docker (host) vm
docker-machine start default
# mount the c-drive in the docker (host) vm
docker-machine ssh default 'sudo chown docker /var/lib/boot2docker/profile && echo mount -t vboxsf C_DRIVE /c >> /var/lib/boot2docker/profile'
```

Examples

Amazon ECS (EC2 Container Service) cli tools

```bash
docker run -i -t -v "//c/Users/timvw/.aws:/root/.aws" timvw/docker-aws
```


Jekyll (Yes, you can make it [work on windows](https://jekyllrb.com/docs/windows/) but why bother?)

```bash
docker run -i -t -v "//c/src/timvw.github.io:/opt/webiste" timvw/docker-jekyll
jekyll server --incremental --watch --force_polling
```
