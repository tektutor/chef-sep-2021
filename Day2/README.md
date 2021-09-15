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
```
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
```
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

### Chef Documentation Reference
```
https://docs.chef.io/resource.html
```

### Let us create a recipe folder
```
cd ~
mkdir myrecipe
cd myrecipe
```

### Let us write our first Chef Recipe
Under the myrecipe, create a file user.rb with the below content
```
user 'devops' do
   shell '/bin/bash'
   uid   '9999'
end
```
I gave 3 white spaces for indentation.

Make sure the file is save before closing the text editor.

### Let us verify if our system already has an user by name 'devops'
```
id devops
```
The expected output is
<pre>
id: devops: no such user
</pre>

As you would have checked it yourself, currently there is no user by name 'devops' in RPS Lab machine.

### Check if the recipe is error free with no syntax errors
```
cookstyle user.rb
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ cookstyle user.rb 
Inspecting 1 file
C

Offenses:

user.rb:2:1: C: [Correctable] Layout/IndentationWidth: Use 2 (not 3) spaces for indentation. (https://rubystyle.guide#spaces-indentation)
   shell '/bin/bash'
^^^

1 file inspected, 1 offense detected, 1 offense auto-correctable
</pre>

Now edit the user.rb and make sure, shell and uid are idented with 2 white spaces as pointed by cookstyle tool.

Now rerun the cookstyle to verify the syntax is correct.
```
cookstyle user.rb
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ <b>cookstyle user.rb</b> 
Inspecting 1 file
.

1 file inspected, <b>no offenses</b> detected
</pre>

### Let's dry-run our recipe locally with chef-zero
This is how you could smoke-test your recipies before running it on the actual server
```
chef-client --local-mode user.rb --why-run
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ chef-client --local-mode user.rb --why-run
[2021-09-14T19:52:00-07:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-09-14T19:52:00-07:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/jegan/Training/chef-sep-2021/Day2/myrecipes.
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
[2021-09-14T19:52:05-07:00] ERROR: shard_seed: Failed to get dmi property serial_number: is dmidecode installed?
Resolving cookbooks for run list: []
Synchronizing cookbooks:
Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-14T19:52:05-07:00] WARN: Node tektutor has an empty run list.
Converging 1 resources
Recipe: @recipe_files::/home/jegan/Training/chef-sep-2021/Day2/myrecipes/user.rb
  * linux_user[devops] action create (up to date)
[2021-09-14T19:52:05-07:00] WARN: In why-run mode, so NOT performing node save.

Running handlers:
Running handlers complete
Infra Phase complete, 0/1 resources would have been updated
</pre>
