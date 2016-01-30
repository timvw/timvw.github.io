---
ID: 2483
post_title: Notes on running spark-notebook
author: timvw
post_date: 2015-08-27 09:39:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2015/08/27/notes-on-running-spark-notebook/
published: true
---
<p>These days <a href="https://www.docker.com/">Docker</a> makes it extremely easy to get started with virtually any application you like. At first I was a bit skeptical but over the last couple of months I have changed my mind. Now I strongly believe this is a game changer. Even more  when it comes to Windows. Anyway, these days kitematic (GUI to manage docker images) allows you to simply pick the <a href="https://github.com/andypetrella/spark-notebook">spark-notebook</a> by Andy Petrella.</p>
<a href="http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image.png"><img src="http://www.timvw.be/wp-content/uploads/2015/08/docker_pick_image-300x152.png" alt="docker_pick_image" width="300" height="152" class="size-medium wp-image-2486" /></a><br/>
<p>When running your docker host in VirtualBox, you still need to set up port forwarding for port 9000 (the notebook) and ports 4040 to 4050 (spark-ui) Assuming your docker host vm is named default:</p>
<code>VBoxManage modifyvm "default" --natpf1 "tcp-port9000,tcp,,9000,,9000"</code>
<code>for i in {4040..4050}; do 
  VBoxManage modifyvm "default" --natpf1 "tcp-port$i,tcp,,$i,,$i";<br/>
done
</code>
<p>Now you can browse to http://localhost:9000 and start using your new notebook:</p>
<a href="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home.png"><img src="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_home-300x160.png" alt="spark_notebook_home" width="300" height="160" class="size-medium wp-image-2493" /></a>
<p>You may want to copy the default set of notebooks to a local directory:</p>
<code>docker cp $containerName:/opt/docker/notebooks /Users/timvw/notebooks</code>
<p>Using that local copy is just a few clicks away with Kitematic:</p>
<a href="http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings.png"><img src="http://www.timvw.be/wp-content/uploads/2015/08/docker_notebook_settings-300x140.png" alt="docker_notebook_settings" width="300" height="140" class="alignnone size-medium wp-image-2498" /></a>

<p>Offcourse you want to use additional packages such as <a href="https://github.com/databricks/spark-csv">spark-csv</a>. This can be achieved by editting the your notebook metadata:</p>
<a href="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata.png"><img src="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_metadata-297x300.png" alt="spark_notebook_metadata" width="297" height="300" class="alignnone size-medium wp-image-2501" /></a>

<p>You simply need to add an entry to customDeps:</p>
<a href="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps.png"><img src="http://www.timvw.be/wp-content/uploads/2015/08/spark_notebook_customdeps-300x234.png" alt="spark_notebook_customdeps" width="300" height="234" class="alignnone size-medium wp-image-2500" /></a>

<p>When your container did not shutdown correctly, you may end up in the awkward situation that your container believes that it is still running(). The following commands fix that:</p>
<code>docker start $containerName && docker exec -t -i $containerName /bin/rm /opt/docker/RUNNING_PID</code>