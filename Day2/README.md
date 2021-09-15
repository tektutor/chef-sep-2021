### Build Chef Node Docker Images
```
cd ~/Training/chef-sep-2021
git pull
cd Day2/ChefNodeDockerImages
cd CentOS
docker build -t tektutor/chef-centos-node:latest .
cd ../Ubuntu
docker build -t tektutor/chef-ubuntu-node:latest .
```

### Check if the docker images are built successfully
```
docker images
```
The expected output is
<pre>
[jegan@tektutor ~]$ docker images
REPOSITORY                  TAG       IMAGE ID       CREATED          SIZE
<b>
tektutor/chef-ubuntu-node   latest    a40d86d1eb44   12 minutes ago   322MB
tektutor/chef-centos-node   latest    a935fff7f04c   30 minutes ago   484MB
</b>
ubuntu                      20.04     fb52e22af1b0   2 weeks ago      72.8MB
centos                      8         300e315adb2f   9 months ago     209MB
</pre>

### Let us create two nodes one of type centos and other of type ubuntu
```
docker run -d --name node1 --hostname node1 tektutor/chef-centos-node:latest
docker run -d --name node2 --hostname node2 tektutor/chef-centos-node:latest
```
See if the containers are running
```
docker ps
```
The expected output is
<pre>
[jegan@tektutor ~]$ docker ps
CONTAINER ID   IMAGE                              COMMAND               CREATED          STATUS          PORTS            NAMES
<b>
005c7e4edf9b   tektutor/chef-ubuntu-node:latest   "/usr/sbin/sshd -D"   12 minutes ago   Up 12 minutes   22/tcp, 80/tcp   node2
5f1af28f0910   tektutor/chef-centos-node:latest   "/usr/sbin/sshd -D"   31 minutes ago   Up 31 minutes   22/tcp, 80/tcp   node1
</b>
</pre>
