# chef-sep-2021

### What is Chef ?
- is a Configuration Management Tool
- is an Infrastructure as Code Tool
- Developed by OpsCode in Ruby and Erlang 
- Sep 2020,  Progress acquired Chef
- uses Ruby as the Domain Specific Language (DSL)

### Chef Architecture
- Has 3 Major Components
  - Workstation
  - Chef Server and
  - Chef Node(s)

#### Chef Workstation
- is the system where DevOps Engineers write Cookbooks to automate installations on the Chef Nodes
- Chef Workstation tools are installed here
- Chef workstation tools is the new set of tools that replaces ChefDk.
- Chef workstation comes with
  - Chef Infra client
  - Chef InSpec
  - Chef Habitat
  - Chef and Knife CLI tools
  - Test Kitchen and Cookstyle
  - All tools required to author cookbooks and upload to Chef Infra Server
           
#### Chef Server
- is the centralized Chef server where all the Cookbooks are kept
- Chef Infra server has to be installed on this machine

#### Chef Nodes
- are the machines where software installations must be automated 

### Installing Ruby in Chef Workstation
```
cd ~/Downloads
wget https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.2.tar.gz
tar xvfz ruby-3.0.2.tar.gz
```

Edit your .bashrc file and append the below lines
```
# User specific aliases and functions
export RUBY_HOME=/home/jegan/Downloads/ruby-3.0.2
export PATH=$RUBY_HOME/bin:$PATH
eval "$(chef shell-init bash)"
```

Apply the changes in .bashrc on the current terminal session
```
source ~/.bashrc
```
Check ruby version
```
ruby --version
```
The expected output is
<pre>
[jegan@tektutor ruby-3.0.2]$ ruby --version
ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux]
</pre>

### Setting up your Chef Workstation
```
cd ~/Downloads
wget https://packages.chef.io/files/current/chef-workstation/21.9.613/el/8/chef-workstation-21.9.613-1.el8.x86_64.rpm
sudo rpm -ivh ./chef-workstation-21.9.613-1.el8.x86_64.rpm
chef -v
```
The expected output is
<pre>
[jegan@tektutor Downloads]$ wget https://packages.chef.io/files/current/chef-workstation/21.9.613/el/8/chef-workstation-21.9.613-1.el8.x86_64.rpm
--2021-09-12 01:45:12--  https://packages.chef.io/files/current/chef-workstation/21.9.613/el/8/chef-workstation-21.9.613-1.el8.x86_64.rpm
Resolving packages.chef.io (packages.chef.io)... 151.101.158.110
Connecting to packages.chef.io (packages.chef.io)|151.101.158.110|:443... connected.
HTTP request sent, awaiting response... 200 OK
Could not parse String-Transport-Security header
Length: 130803188 (125M) [application/x-rpm]
Saving to: ‘chef-workstation-21.9.613-1.el8.x86_64.rpm.1’

chef-workstation-21.9.613-1.el 100%[=================================================>] 124.74M   191KB/s    in 20m 51s 

2021-09-12 02:06:15 (102 KB/s) - ‘chef-workstation-21.9.613-1.el8.x86_64.rpm.1’ saved [130803188/130803188]

[jegan@tektutor Downloads]$ sudo rpm -ivh ./chef-workstation-21.9.613-1.el8.x86_64.rpm
warning: ./chef-workstation-21.9.613-1.el8.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 83ef826a: NOKEY
Verifying...                          ################################# [100%]
Preparing...                          ################################# [100%]
Updating / installing...
   1:chef-workstation-21.9.613-1.el8  ################################# [100%]
ldd: /opt/chef-workstation/components/chef-workstation-app/chef-workstation-app: No such file or directory

The Chef Workstation App is available.

Launch the App by running 'chef-workstation-app'.
The App will then be available in the system tray.

Thank you for installing Chef Workstation!
You can find some tips on getting started at https://docs.chef.io/workstation/getting_started/

[jegan@localhost Downloads]$ chef -v
Chef Workstation version: 21.9.613
Test Kitchen version: 3.0.0
Cookstyle version: 7.24.1
Chef Infra Client version: 17.4.38
Chef InSpec version: 4.41.20
Chef CLI version: 5.4.2
Chef Habitat version: 1.6.351
</pre>

You may refer further installation instructions in the official page https://docs.chef.io/workstation/install_workstation/

### Setting up your Chef Server
Latest version of Chef Infra Server can be downloaded here https://downloads.chef.io/tools/infra-server
```
wget https://packages.chef.io/files/stable/chef-server/14.9.23/el/8/chef-server-core-14.9.23-1.el7.x86_64.rpm
sudo rpm -ivh ./chef-server-core-14.9.23-1.el7.x86_64.rpm
```
The expected output is
<pre>
[jegan@tektutor Downloads]$ sudo rpm -ivh ./chef-server-core-14.9.23-1.el7.x86_64.rpm 

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for jegan: 
warning: ./chef-server-core-14.9.23-1.el7.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 83ef826a: NOKEY
Verifying...                          ################################# [100%]
Preparing...                          ################################# [100%]
Updating / installing...
   1:chef-server-core-14.9.23-1.el7   ################################# [100%]
Thank you for installing Chef Infra Server!

Run 'chef-server-ctl reconfigure' to configure your Chef Infra Server

For more information on getting started see https://docs.chef.io/server/
</pre>

Finding the Chef Server in your system
```
head -n1 /opt/opscode/version-manifest.txt
```
The expected output is
<pre>
chef-server 14.9.23
</pre>

### Configuring and Starting Chef server
```
sudo chef-server-ctl reconfigure
```

### Checking the Chef Server status
```
sudo chef-server-ctl status
```
The expected output is
<pre>
[jegan@tektutor ~]$ sudo chef-server-ctl status
[sudo] password for jegan: 
run: bookshelf: (pid 21040) 116s; run: log: (pid 20510) 165s
run: elasticsearch: (pid 21004) 117s; run: log: (pid 20292) 215s
run: nginx: (pid 20990) 117s; run: log: (pid 20787) 126s
run: oc_bifrost: (pid 20879) 118s; run: log: (pid 20155) 232s
run: oc_id: (pid 20987) 117s; run: log: (pid 20199) 221s
run: opscode-erchef: (pid 21108) 116s; run: log: (pid 20635) 158s
run: postgresql: (pid 20856) 118s; run: log: (pid 19608) 249s
run: redis_lb: (pid 20832) 120s; run: log: (pid 20831) 120s
</pre>

### Create an admin user in Chef Server
```
sudo chef-server-ctl user-create jegan Jeganathan Swaminathan jegan@tektutor.org 'Admin@123' --filename /home/jegan/jegan.pem
```
We need to scp the jegan.pem file to the Chef workstation machine at /home/jegan/.chef/jegan.pem

### Create an organization and associate the admin user to the the organization
```
sudo chef-server-ctl org-create tektutor 'tektutor' --association_user jegan --filename tektutor-validator.pem
```
### In the Chef workstation machine
```
knife configure
```
You need to type URL as https://server:443/tektutor and user as jegan.

In chefserver, chefworkstation and nodes, we need to ensure the /etc/hosts file has the below entries
```
172.16.95.154   server
172.16.95.157   workstation
172.16.95.158   node1
172.16.95.155   node2                      
```

The expected output is
<pre>
[jegan@workstation ~]$ <b>knife configure</b>
Please enter the chef server URL: [https://workstation/organizations/myorg] https://server:443/tektutor
Please enter an existing username or clientname for the API: [jegan] 
Overwrite /home/jegan/.chef/credentials? (Y/N) Y
*****

You must place your client key in:
  /home/jegan/.chef/jegan.pem
Before running commands with Knife

*****
Knife configuration file written to /home/jegan/.chef/credentials
</pre>

### Download the self-signed certificate from the Chef Infra Server to Workstation
```
knife ssl fetch
```
The expected output is
<pre>
[jegan@workstation ~]$ <b>knife ssl fetch</b>
WARNING: Certificates from 172.16.95.154 will be fetched and placed in your trusted_cert
       directory (/home/jegan/.chef/trusted_certs).
       
       Knife has no means to verify these are the correct certificates. You should
       verify the authenticity of these certificates after downloading.
Adding certificate for server in /home/jegan/.chef/trusted_certs/server.crt
</pre>

### Test if knife on chef workstation is able to connect to server
```
knife ssl check
```
The expected output is
<pre>
[jegan@workstation ~]$ <b>knife ssl check</b>
Connecting to host server:443
Successfully verified certificates from `server'
</pre>

### List all the configured profiles
```
knife config list-profiles
```
The expected output is
<pre>
[jegan@workstation ~]$ knife config list-profiles
 Profile  Client  Key                Server                      
--------------------------------------------------------------
*default  jegan   ~/.chef/jegan.pem  https://server:443/tektutor 
</pre>

### Creating a chef-repo in Workstation
```
cd ~
chef generate repo chef-repo
```
The expected output is

<pre>
[jegan@tektutor ~]$ <b>chef generate repo chef-repo</b>
+---------------------------------------------+
            Chef License Acceptance

Before you can continue, 3 product licenses
must be accepted. View the license at
https://www.chef.io/end-user-license-agreement/

Licenses that need accepting:
  * Chef Workstation
  * Chef Infra Client
  * Chef InSpec

Do you accept the 3 product licenses (yes/no)?

> <b>yes</b>

Persisting 3 product licenses...
✔ 3 product licenses persisted.

+---------------------------------------------+
Generating Chef Infra repo chef-repo
- Ensuring correct Chef Infra repo file content

Your new Chef Infra repo is ready! Type `cd chef-repo` to enter it.
[jegan@tektutor ~]$ 
</pre>
