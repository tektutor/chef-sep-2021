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

### Find the IP Address of your RPS Lab machine
```
ifconfig ens192
```
My RPS Lab IP Address seems to be 172.20.0.110

### Find the IP Address of your node1
```
docker inspect node1 | grep IPA
```
My node1 IP seems to be 172.17.0.2

### Find the IP Address of your node2
```
docker inspect node2 | grep IPA
```
My node2 IP seems to be 172.17.0.3

We need to add the above IP Address to the /etc/hosts file in RPS Lab machine, node1 and nod2
```
sudo vim /etc/hosts
```
Make sure you append the below in the RPS Lab machine /etc/hosts and save it.
```
172.17.0.2      node1
172.17.0.3      node2
172.20.0.110    CentOS
```
Similarly append in node1
```
ssh root@172.17.0.2
vim /etc/hosts
```
Make sure you append the below in the node1 /etc/hosts and save it.
```
172.17.0.2      node1
172.17.0.3      node2
172.20.0.110    CentOS

Similarly append in node2
```
ssh root@172.17.0.3
vim /etc/hosts
```
Make sure you append the below in the node2 /etc/hosts and save it.
```
172.17.0.2      node1
172.17.0.3      node2
172.20.0.110    CentOS

<b>The above steps are crucial for bootstrapping your nodes. Make sure the above steps are completed before you proceed below</b>

### Bootstrap node1 and node2
```
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
Repeat the same for node2 as well
```
knife bootstrap node2 -U root -P root --node-name node2
```

### Test if the nodes are registered(connected) with Chef server
You may execute the below command from any directory.
```
knife node list
```
The expected output is
<pre>
[jegan@tektutor]$ knife node list
node1
node2
</pre>
