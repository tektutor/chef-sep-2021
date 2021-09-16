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

Let's run the cookbook locally as shown below
```
<b>sudo chef-client --local-mode cookbooks/webserver/recipes/default.rb --why-run</b>
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
    +<h1>Welcome to Httpd WebServer Landing Page !</h1>
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
