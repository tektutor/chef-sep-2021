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
