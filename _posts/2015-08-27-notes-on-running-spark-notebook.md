---
id: 2483
title: Notes on running spark-notebook
date: 2015-08-27T09:39:15+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2483
permalink: /2015/08/27/notes-on-running-spark-notebook/
categories:
  - Uncategorized
tags:
  - apache
  - spark
  - spark-csv
  - spark-notebook
---
These days [Docker](https://www.docker.com/) makes it extremely easy to get started with virtually any application you like. At first I was a bit skeptical but over the last couple of months I have changed my mind. Now I strongly believe this is a game changer. Even more when it comes to Windows. Anyway, these days kitematic (GUI to manage docker images) allows you to simply pick the [spark-notebook](https://github.com/andypetrella/spark-notebook) by Andy Petrella.

[<img src="http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-300x152.png" alt="docker_pick_image" width="300" height="152" class="size-medium wp-image-2486" srcset="http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-300x152.png 300w, http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-1024x518.png 1024w, http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-500x253.png 500w" sizes="(max-width: 300px) 100vw, 300px" />](http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image.png)

When running your docker host in VirtualBox, you still need to set up port forwarding for port 9000 (the notebook) and ports 4040 to 4050 (spark-ui) Assuming your docker host vm is named default:

```bash
VBoxManage modifyvm "default" --natpf1 "tcp-port9000,tcp,,9000,,9000"
```
  
These days [Docker](https://www.docker.com/) makes it extremely easy to get started with virtually any application you like. At first I was a bit skeptical but over the last couple of months I have changed my mind. Now I strongly believe this is a game changer. Even more when it comes to Windows. Anyway, these days kitematic (GUI to manage docker images) allows you to simply pick the [spark-notebook](https://github.com/andypetrella/spark-notebook) by Andy Petrella.

[<img src="http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-300x152.png" alt="docker_pick_image" width="300" height="152" class="size-medium wp-image-2486" srcset="http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-300x152.png 300w, http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-1024x518.png 1024w, http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-500x253.png 500w" sizes="(max-width: 300px) 100vw, 300px" />](http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image.png)

When running your docker host in VirtualBox, you still need to set up port forwarding for port 9000 (the notebook) and ports 4040 to 4050 (spark-ui) Assuming your docker host vm is named default:

```bash
VBoxManage modifyvm "default" --natpf1 "tcp-port9000,tcp,,9000,,9000"
``` 

Now you can browse to http://localhost:9000 and start using your new notebook:

[<img src="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home-300x160.png" alt="spark_notebook_home" width="300" height="160" class="size-medium wp-image-2493" srcset="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home-300x160.png 300w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home-1024x546.png 1024w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home-500x267.png 500w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home.png 1492w" sizes="(max-width: 300px) 100vw, 300px" />](http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home.png)

You may want to copy the default set of notebooks to a local directory:

```bash
docker cp $containerName:/opt/docker/notebooks /Users/timvw/notebooks
```

Using that local copy is just a few clicks away with Kitematic:

[<img src="http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings-300x140.png" alt="docker_notebook_settings" width="300" height="140" class="alignnone size-medium wp-image-2498" srcset="http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings-300x140.png 300w, http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings-1024x477.png 1024w, http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings-500x233.png 500w" sizes="(max-width: 300px) 100vw, 300px" />](http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings.png)

Offcourse you want to use additional packages such as [spark-csv](https://github.com/databricks/spark-csv). This can be achieved by editting the your notebook metadata:

[<img src="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata-297x300.png" alt="spark_notebook_metadata" width="297" height="300" class="alignnone size-medium wp-image-2501" srcset="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata-297x300.png 297w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata-1013x1024.png 1013w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata.png 1060w" sizes="(max-width: 297px) 100vw, 297px" />](http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata.png)

You simply need to add an entry to customDeps:

[<img src="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps-300x234.png" alt="spark_notebook_customdeps" width="300" height="234" class="alignnone size-medium wp-image-2500" srcset="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps-300x234.png 300w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps-1024x798.png 1024w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps-385x300.png 385w, http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps.png 1368w" sizes="(max-width: 300px) 100vw, 300px" />](http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps.png)

When your container did not shutdown correctly, you may end up in the awkward situation that your container believes that it is still running(). The following commands fix that:

```bash
docker start $containerName && docker exec -t -i $containerName /bin/rm /opt/docker/RUNNING_PID
```