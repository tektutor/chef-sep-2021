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
You may run this command from any directory
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

### Bootstrap node1 and node2
```
ChefNodeDockerImages  README.md
[jegan@tektutor]$ knife bootstrap node1 -U root -P root --node-name node1
Connecting to node1 using ssh
The authenticity of host 'node1 (172.17.0.2)' can't be established.
fingerprint is SHA256:+IFHcvwhCDI3KV4X1tiE4ietuNouRuwq6/5k5UoUNIw.

Are you sure you want to continue connecting? (Y/N) <b>Y</b>
Connecting to node1 using ssh
Node node1 exists, overwrite it? (Y/N) <b>Y</b>
Client node1 exists, overwrite it? (Y/N) <b>Y</b>
Creating new client for node1
Creating new node for node1
Bootstrapping node1
 [node1] -----> Existing Chef Infra Client installation detected
 [node1] Starting the first Chef Infra Client Client run...
 [node1] Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
 [node1] Infra Phase starting
 [node1] [2021-09-15T01:48:06+00:00] ERROR: shard_seed: Failed to get dmi property serial_number: is dmidecode installed?
 [node1] Resolving cookbooks for run list: []
 [node1] Synchronizing cookbooks:
 [node1] Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-15T01:48:07+00:00] WARN: Node node1 has an empty run list.
 [node1] Converging 0 resources
 [node1] 
Running handlers:
 [node1] Running handlers complete
 [node1] Infra Phase complete, 0/0 resources updated in 02 seconds
```
