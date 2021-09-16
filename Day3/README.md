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

Cookbook is nothing but a set of recipes called in a particular sequence.

```
cd ~
cd Training/Day3/chef-repo
chef generate cookbook webserver
```

The expected output is
<pre>
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
