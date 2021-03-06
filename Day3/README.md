### Creating your first Chef cookbook

Cleanup existing httpd installation
```
sudo yum remove httpd -y
sudo rm -rf /var/www/html/index.html
curl localhost
```

### Creating a chef-repo in Workstation
```
cd ~
cd Day3
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

### Let us now write our first Chef Cookbook inside the chef-repo.

So far we wrote individual Chef recipes but now it is time to write a Cookbook !

Cookbook is nothing but a set of recipes invoked in a particular sequence.

```
cd ~
cd Training/Day3
cd chef-repo/cookbooks
chef generate cookbook webserver
```

The expected output is
<pre>
[jegan@tektutor Day3]$ cd chef-repo/cookbooks
[jegan@tektutor Day3]$ chef generate cookbook webserver
Generating cookbook webserver
- Ensuring correct cookbook content

Your cookbook is ready. Type `cd webserver` to enter it.

There are several commands you can run to get started locally developing and testing your cookbook.
Type `delivery local --help` to see a full list of local testing commands.

Why not start by writing an InSpec test? Tests for the default recipe are stored at:

test/integration/default/default_test.rb

If you'd prefer to dive right in, the default recipe can be found at:

recipes/default.rb
</pre>

Let us now get inside the Cookbook directory as shown below and edit the default.rb file under recipes folder.
```
cd webserver/recipes
vim default.rb
```

You may now append the below code in the default.rb file and save it.

```
package 'httpd' do
  action :install
end

file '/var/www/html/index.html' do
  content "<h1>Welcome to Httpd WebServer Landing Page !</h1>"
  action :create
end

service 'httpd' do
  action [:enable, :start]
end
```

Let's dry-run the cookbook locally as shown below from 'chef-repo' folder
```
pwd
sudo chef-client --local-mode cookbooks/webserver/recipes/default.rb --why-run
```
<pre>
[jegan@tektutor chef-repo]$ pwd
<b>/home/jegan/Training/chef-sep-2021/Day3/chef-repo</b>
[jegan@tektutor chef-repo]$ <b>sudo chef-client --local-mode cookbooks/webserver/recipes/default.rb --why-run</b>
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: []
Synchronizing cookbooks:
Installing cookbook gem dependencies:
Compiling cookbooks...
[2021-09-15T19:17:01-07:00] WARN: Node tektutor has an empty run list.
Converging 3 resources
Recipe: @recipe_files::/home/jegan/Training/chef-sep-2021/Day3/chef-repo/cookbooks/webserver/recipes/default.rb
  * dnf_package[httpd] action install (up to date)
  * file[/var/www/html/index.html] action create
    - Would update content in file /var/www/html/index.html from 8e6d94 to c6f989
    --- /var/www/html/index.html	2021-09-15 06:18:51.577509829 -0700
    +++ /tmp/.chef-index20210915-10067-94x2iq.html	2021-09-15 19:17:03.767345377 -0700
    @@ -1,2 +1,2 @@
    -Chef works!
    +Welcome to Httpd WebServer Landing Page !
    - Would restore selinux security context
  * service[httpd] action enable
    * Service status not available. Assuming a prior action would have installed the service.
    * Assuming status of not running.
     (up to date)
  * service[httpd] action start
    * Service status not available. Assuming a prior action would have installed the service.
    * Assuming status of not running.
    - Would start service service[httpd]
[2021-09-15T19:17:03-07:00] WARN: In why-run mode, so NOT performing node save.

Running handlers:
Running handlers complete
Infra Phase complete, 2/4 resources would have been updated
[jegan@tektutor chef-repo]$ 
</pre>


### Include Recipe
We can break the larger recipe file with multiple resource calls into smaller moduler recipes with this feature.

This helps us in writing modular, readable and easy to maintain recipes.

Before refactoring default.rb
```
package 'httpd' do
  action :install
end

file '/var/www/html/index.html' do
  content "<h1>Welcome to Httpd WebServer Landing Page !</h1>"
  action :create
end

service 'httpd' do
  action [:enable, :start]
end
```

After refactoring default.rb

This is how the default.rb will look after refactoring
```
include_recipe 'webserver::install-httpd'
include_recipe 'webserver::deploy-custom-html'
include_recipe 'webserver::start-webserver'
```

The install-httpd.rb file will look as shown below
```
# Install httpd webserver in CentOS/RedHat Linux Family
package 'httpd' do
  action :install
end
```

The deploy-custom-html.rb file will look as shown below
```
# Deploy the custom web page into httpd webserver
file '/var/www/html/index.html' do
  content "<h1>Welcome to Httpd WebServer Landing Page !</h1>"
  action :create
end
```

The start-webserver.rb file will look as shown below
```
# Start the httpd service
service 'httpd' do
  action [:enable, :start]
end
```

### Let us upload the cookbook to actual server
```
cd ~/Training/chef-sep-2021/Day3/chef-repo/cookbooks
knife cookbook upload "webserver" --cookbook-path .
```

The expected output is
<pre>
[jegan@workstation cookbooks]$ ls
example  README.md  webserver
[jegan@workstation cookbooks]$ knife cookbook upload "webserver" --cookbook-path .
Uploading webserver      [0.1.0]
Uploaded 1 cookbook.
</pre>

### RunList
Runlist is a way we can control the order in which multiple recipes should be executed by the chef-client in a required order.

Syntax looks as below
```
chef-client --runlist "recipe[Cookbook-Name::Recipe-Name]"
chef-client --runlist "recipe[Cookbook-Name]
chef-client --runlist "recipe[Cookbane-Name1::default],recipe[Cookbook-Name2::recipe-name]"
```

In case you need to remove a cookbook from the runlist of a node
```
knife node run_list remove node1 "recipe[httpd]"
```

Edit the runlist for a node
```
knife node edit node1
```

Let us add the webserver cookbook to the runlist of node1 and node2
```
cd ~/Training/chef-sep-2021
git pull
cd Day3/chef-repo/cookbooks

knife node run_list add node1 "recipe[webserver]"
knife node run_list add node2 "recipe[webserver]"
```

The expected output is
<pre>
[jegan@workstation cookbooks]$ <b>knife node run_list add node1 "recipe[webserver]"</b>
node1:
  run_list:
    recipe[httpd]
    recipe[webserver]
[jegan@workstation cookbooks]$ <b>knife node run_list add node2 "recipe[webserver]"</b>
node2:
  run_list:
    recipe[apache]
    recipe[webserver]
</pre>

We need to go to Node1 and manually run the chef-client as root user
```
ssh root@node1
chef-client
```

The expected output is
<pre>
[root@node1 ~]# <b>chef-client</b>
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: ["webserver"]
Synchronizing cookbooks:
  - webserver (0.1.0)
Installing cookbook gem dependencies:
Compiling cookbooks...
Converging 3 resources
Recipe: webserver::install-httpd
  * dnf_package[httpd] action install (up to date)
Recipe: webserver::deploy-custom-html
  * file[/var/www/html/index.html] action create
    - update content in file /var/www/html/index.html from f9f91f to c6f989
    --- /var/www/html/index.html	2021-09-13 21:11:52.393761079 -0700
    +++ /var/www/html/.chef-index20210915-8629-lmcxe6.html	2021-09-15 22:56:56.340255112 -0700
    @@ -1,10 +1,2 @@
    +Welcome to Httpd WebServer Landing Page !
    - restore selinux security context
Recipe: webserver::start-webserver
  * service[httpd] action enable (up to date)
  * service[httpd] action start (up to date)

Running handlers:
Running handlers complete
Infra Phase complete, 1/4 resources updated in 06 seconds
[root@node1 ~]# 
</pre>

Repeat the same on node2 server as well

```
ssh root@node2
chef-client
```
The expected output is
<pre>
root@node2:~# chef-client
Chef Infra Client, version 17.4.38
Patents: https://www.chef.io/patents
Infra Phase starting
Resolving cookbooks for run list: ["webserver"]
Synchronizing cookbooks:
  - webserver (0.1.0)
Installing cookbook gem dependencies:
Compiling cookbooks...
Converging 3 resources
Recipe: webserver::install-httpd
  * apt_package[httpd] action install
    
    ================================================================================
    Error executing action `install` on resource 'apt_package[httpd]'
    ================================================================================
    
    Chef::Exceptions::Package
    -------------------------
    httpd is a virtual package provided by multiple packages, you must explicitly select one
    
    Resource Declaration:
    ---------------------
    # In /var/chef/cache/cookbooks/webserver/recipes/install-httpd.rb
    
      1: package 'httpd' do
      2:   action :install
      3: end
    
    Compiled Resource:
    ------------------
    # Declared in /var/chef/cache/cookbooks/webserver/recipes/install-httpd.rb:1:in `from_file'
    
    apt_package("httpd") do
      package_name "httpd"
      action [:install]
      default_guard_interpreter :default
      declared_type :package
      cookbook_name "webserver"
      recipe_name "install-httpd"
    end
    
    System Info:
    ------------
    chef_version=17.4.38
    platform=ubuntu
    platform_version=20.04
    ruby=ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux]
    program_name=/usr/bin/chef-client
    executable=/opt/chef/bin/chef-client
    

Running handlers:
[2021-09-15T23:05:06-07:00] ERROR: Running exception handlers
Running handlers complete
[2021-09-15T23:05:06-07:00] ERROR: Exception handlers complete
Infra Phase failed. 0 resources updated in 03 seconds
[2021-09-15T23:05:06-07:00] FATAL: Stacktrace dumped to /var/chef/cache/chef-stacktrace.out
[2021-09-15T23:05:06-07:00] FATAL: ---------------------------------------------------------------------------------------
[2021-09-15T23:05:06-07:00] FATAL: PLEASE PROVIDE THE CONTENTS OF THE stacktrace.out FILE (above) IF YOU FILE A BUG REPORT
[2021-09-15T23:05:06-07:00] FATAL: ---------------------------------------------------------------------------------------
[2021-09-15T23:05:06-07:00] FATAL: Chef::Exceptions::Package: apt_package[httpd] (webserver::install-httpd line 1) had an error: Chef::Exceptions::Package: httpd is a virtual package provided by multiple packages, you must explicitly select one
root@node2:~# 
</pre>
