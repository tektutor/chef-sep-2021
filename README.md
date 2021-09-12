# chef-sep-2021

### What is Chef ?
- is a Configuration Management Tool
- is a Infrastructure as Code Tool
- Developed by OpsCode in Ruby and Erlang 
- Sep 2020,  Progress acquired Chef
- uses Ruby as the Domain Specific Language (DSL)

### Chef Architecture
- Has 3 Major Components
  1.  Workstation
  2.  Chef Server and
  3.  Chef Node(s)

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
      
### Setting up your Chef Workstation
```
cd ~/Downloads
wget https://packages.chef.io/files/current/chef-workstation/21.9.613/el/8/chef-workstation-21.9.613-1.el8.x86_64.rpm
sudo rpm -ivh ./chef-workstation-21.9.613-1.el8.x86_64.rpm
chef -v
```

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
