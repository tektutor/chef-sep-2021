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
      - ChefDK tools are installed here

#### Chef Server
      - is the centralized Chef server where all the Cookbooks are kept
      - Chef Infra server has to be installed on this machine

#### Chef Nodes
      - are the machines where software installations must be automated 
      
### Setting up your Chef Workstation
```
cd ~/Downloads
wget https://packages.chef.io/files/stable/chefdk/4.13.3/el/8/chefdk-4.13.3-1.el7.x86_64.rpm
sudo rpm -ivh ./chefdk-4.13.3-1.el7.x86_64.rpm
chef -v
```

### Setting up your Chef Server
Latest version of Chef Infra Server can be downloaded here https://downloads.chef.io/tools/infra-server
```
wget https://packages.chef.io/files/stable/chef-server/14.9.23/el/8/chef-server-core-14.9.23-1.el7.x86_64.rpm
sudo rpm -ivh ./chef-server-core-14.9.23-1.el7.x86_64.rpm
```
