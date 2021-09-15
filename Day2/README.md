### In case you havent' clone this repository so far, you may do now
```
cd ~
mkdir Training
cd Training
git clone https://github.com/tektutor/chef-sep-2021.git
```

### Build Chef Node Docker Images (RPS Lab Machine)
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
docker run -d --name node2 --hostname node2 tektutor/chef-ubuntu-node:latest
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

### Let's run it on Chef-zero locally
```
sudo chef-client --local-mode user.rb
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ sudo chef-client --local-mode user.rb
[2021-09-14T20:00:40-07:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-09-14T20:00:40-07:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/jegan/Training/chef-sep-2021/Day2/myrecipes.
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: []
Synchronizing cookbooks:
Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-14T20:00:45-07:00] WARN: Node tektutor has an empty run list.
Converging 1 resources
Recipe: @recipe_files::/home/jegan/Training/chef-sep-2021/Day2/myrecipes/user.rb
  * linux_user[devops] action create
    - <b>create user devops</b>

Running handlers:
Running handlers complete
Infra Phase complete, 1/1 resources updated in 05 seconds
</pre>

You may verify if the user is really created by type the below command(s)
```
id devops
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ id devops
uid=9999(devops) gid=9999(devops) groups=9999(devops)
</pre>

You may also verify if the devops user entry is there in /etc/passwd file
```
sudo grep -i devops /etc/passwd
```
The expected output is
<pre>
devops:x:9999:9999::/home/devops:/bin/bash
</pre>

### Let's try to understand idempotency
```
sudo chef-client --local-mode user.rb
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ sudo chef-client --local-mode user.rb
[2021-09-14T20:04:54-07:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-09-14T20:04:54-07:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/jegan/Training/chef-sep-2021/Day2/myrecipes.
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: []
Synchronizing cookbooks:
Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-14T20:05:00-07:00] WARN: Node tektutor has an empty run list.
Converging 1 resources
Recipe: @recipe_files::/home/jegan/Training/chef-sep-2021/Day2/myrecipes/user.rb
<b>  * linux_user[devops] action create (up to date)</b>

Running handlers:
Running handlers complete
Infra Phase complete, 0/1 resources updated in 05 seconds
</pre>
As you noticed, Chef didn't attempt to create the user 'devops' as the user already exists.

Idempotency property of Chef ensures, Chef acts only when the current state of the machine is different from the desired state.  If the current state is inline with desired state, chef reports it is up to date and no action is taken.

Let us try to delete the user using Linux command to see, how Chef responds after the user is deleted
```
sudo userdel -r devops
```

Let us re-run the Chef recipe one more time
```
sudo chef-client --local-mode user.rb
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ sudo userdel -r devops
[sudo] password for jegan: 
userdel: devops home directory (/home/devops) not found
[jegan@tektutor myrecipes]$ sudo chef-client --local-mode user.rb
[2021-09-14T20:11:10-07:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-09-14T20:11:10-07:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/jegan/Training/chef-sep-2021/Day2/myrecipes.
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: []
Synchronizing cookbooks:
Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-14T20:11:15-07:00] WARN: Node tektutor has an empty run list.
Converging 1 resources
Recipe: @recipe_files::/home/jegan/Training/chef-sep-2021/Day2/myrecipes/user.rb
  * linux_user[devops] action create
    <b>- create user devops</b>

Running handlers:
Running handlers complete
Infra Phase complete, 1/1 resources updated in 05 seconds
</pre>


### Remove the devops user using recipe
Update your user.rb recipe as shown below
```
user 'devops' do
  shell '/bin/bash'
  uid   '9999'
  <b>action :remove</b>
end
```

When the <b>action</b> keyword isn't mentioned in the user resource block, Chef assumes you are attempting to create the user.

The expected output is
<pre>
[jegan@tektutor myrecipes]$ sudo chef-client --local-mode user.rb
[sudo] password for jegan: 
[2021-09-14T19:59:12-07:00] WARN: No config file found or specified on command line. Using command line options instead.
[2021-09-14T19:59:12-07:00] WARN: No cookbooks directory found at or above current directory.  Assuming /home/jegan/Training/chef-sep-2021/Day2/myrecipes.
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: []
Synchronizing cookbooks:
Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-14T19:59:17-07:00] WARN: Node tektutor has an empty run list.
Converging 1 resources
Recipe: @recipe_files::/home/jegan/Training/chef-sep-2021/Day2/myrecipes/user.rb
  * linux_user[devops] action remove
    <b>- remove user devops</b>

Running handlers:
Running handlers complete
Infra Phase complete, 1/1 resources updated in 05 seconds
</pre>

You may see if the user is really removed using Linux command
```
id devops
sudo grep -i devops /etc/passwd
```
The expected output is
<pre>
[jegan@tektutor myrecipes]$ id devops
id: ‘devops’: no such user
[jegan@tektutor myrecipes]$ sudo grep -i devops /etc/passwd

</pre>

### Let's install telnet utility using a recipe
First let's ensure telnet isn't already installed
```
rpm -qa | grep -i telnet
```

Let us now create a telnet.rb file with the below content
```
package 'telnet' do
  action :install
end
```

Do a syntax check
```
cookstyle ./telnet.rb
```

Do a dry-run
```
sudo chef-client --local-mode --why-run telnet.rb
```

Let's actually run it now
```
sudo chef-client --local-mode telnet.rb
```

### Installing webserver - single recipe with multiple resources
```
# Install httpd web server in CentOS
package 'httpd' do
  action :install
end

# Deploy custom web page
file '/var/www/html/index.html' do
  action :create
end

# Start the web server
service 'httpd' do
  action :start
end
```
Best practice
<pre>
Create Recipe --> Check --> Test --> Run
</pre>
```
cookstyle webserver.rb
sudo chef-client --local-mode webserver.rb --why-run
sudo chef-client --local-mode webserver.rb
curl localhost
```

### Creating your first Chef cookbook

Cleanup existing httpd installation
```
sudo yum remove httpd -y
sudo rm -rf /var/www/html/index.html
curl localhost
```

