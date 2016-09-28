

blah




Poor corporate develop stuck on Windows 7 Enterprise. [Docker Toolbox](https://www.docker.com/products/docker-toolbox) to the rescue.

By default volumes can only be mapped on folders under the user home directory.

Here is how to enable mapping of the entire c-drive:

```bash
#!/bin/sh
docker-machine stop default
/c/Program\ Files/Oracle/VirtualBox/VBoxManage.exe sharedfolder add default --name C_DRIVE --hostpath c:/
docker-machine start default
docker-machine ssh default 'sudo chown docker /var/lib/boot2docker/profile && echo mount -t vboxsf C_DRIVE /c >> /var/lib/boot2docker/profile'
```

Amazon ECS (EC2 Container Service) cli tools are currently not available on windows. Simply configure a container (eg: [timvw/docker-aws](https://hub.docker.com/r/timvw/docker-aws/) with the tools and off you go ;)

```bash
docker run -i -t -v "/c/Users/timvw/.aws:/root/.aws" timvw/docker-aws
```


