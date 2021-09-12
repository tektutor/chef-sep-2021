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
