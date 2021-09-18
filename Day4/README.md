### Executing Chef cookbook recipe that demonstrates template feature of Chef
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo
rm -rf .chef/*
cp -R ../../Day3/.chef/* .chef
knife cookbook upload apache
knife node run_list add node1 "recipe[apache]"
knife node run_list add node2 "recipe[apache]"
```
Make sure you update your cookbooks path in Day4/.chef/config.rb i.e replace Day3 to Day4

Run chef-client on a single node
```
knife ssh "name:node1" 'sudo chef-client'
```

Run chef-client on all nodes
```
knife ssh 'name:*' 'sudo chef-client'
```

### Let's create DEV,QA and PROD environments

#### Creating DEV environment
```
knife environment create DEV
```
The expected output is
<pre>
[jegan@workstation Day4]$ <b>knife environment create DEV</b>
Created DEV
</pre>

#### Creating QA environment
```
knife environment create QA
```
The expected output is
<pre>
[jegan@workstation Day4]$ <b>knife environment create QA</b>
Created QA
</pre>

#### Creating PROD environment
```
knife environment create PROD
```
The expected output is
<pre>
[jegan@workstation Day4]$<b> knife environment create PROD</b>
Created PROD
</pre>

#### Let us update the environment in nodes1
```
knife node edit node1
```
Update environment from _default to PROD.
The expected output is
<pre>
[jegan@workstation Day4]$ <b>knife node edit node1</b>
Saving updated chef_environment on node node1
</pre>

#### Let us update the environment in nodes2
```
knife node edit node2
```
Update environment from _default to PROD.
The expected output is
<pre>
[jegan@workstation Day4]$<b> knife node edit node2</b>
Saving updated chef_environment on node node2
</pre>

#### Let us update the environment in nodes3
```
knife node edit node3
```
Update environment from _default to QA.
The expected output is
<pre>
[jegan@workstation Day4]$ <b>knife node edit node3</b>
Saving updated chef_environment on node node3
</pre>

#### Let us update the environment in nodes4
```
knife node edit node4
```
Update environment from _default to QA.
The expected output is
<pre>
[jegan@workstation Day4]$<b> knife node edit node4</b>
Saving updated chef_environment on node node4
</pre>

#### Let us update the environment in nodes5
```
knife node edit node5
```
Update environment from _default to DEV.
The expected output is
<pre>
[jegan@workstation Day4]$ <b>knife node edit node5</b>
Saving updated chef_environment on node node5
</pre>

#### Let us update the environment in nodes6
```
knife node edit node6
```
Update environment from _default to DEV.
The expected output is
<pre>
[jegan@workstation Day4]$<b> knife node edit node6</b>
Saving updated chef_environment on node node6
</pre>

### Chef Roles

#### Creating Roles
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo/roles

knife role from file frontend-role.rb
knife role from file backend-role.rb
```

#### Assiging Role(s) to nodes

#### Let's us start with PROD environment
```
knife node edit node1
```
You need to add the "role[frontend]" in the run_list of the node1 as highlighted below.

<pre>
{
  "name": "node1",
  "chef_environment": "PROD",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  <b>"role[frontend]"</b>
]

}

</pre>

Similary add role(s) to node2
```
knife node edit node2
```

<pre>
{
  "name": "node2",
  "chef_environment": "PROD",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  <b>"role[backend]"</b>
]

}
</pre>

#### Let's us update role in QA environment

```
knife node edit node3
```
You need to add the "role[frontend]" in the run_list of the node3 as highlighted below.

<pre>
{
  "name": "node3",
  "chef_environment": "QA",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  <b>"role[frontend]"</b>
]

}

</pre>

Similary add role(s) to node4
```
knife node edit node4
```

<pre>
{
  "name": "node4",
  "chef_environment": "PROD",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  <b>"role[backend]"</b>
]

}
</pre>

### Adding multiple roles to a single node(node 5)
```
knife node edit node5
```

Add both roles to node5 as shown below

<pre>
{knife search "role:frontend" -a name
  "name": "node5",
  "chef_environment": "DEV",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  <b>"role[frontend]",
  "role[backend]"</b>
]

}
</pre>

#### Adding multiples roles to a single node(node6) 
```
knife node edit node6
```

Add both roles to node6 as shown below
<pre>

  "name": "node6",
  "chef_environment": "DEV",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  <b>"role[frontend]",
  "role[backend]"</b>
]

}
</pre>

### Find all nodes that has frontend role and belong to DEV environment
```
knife search "role:frontend AND chef_environment:DEV" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$ <b>knife search "role:frontend AND chef_environment:DEV" -a name</b>
2 items found

node5:
  name: node5

node6:
  name: node6
</pre>

### Find all nodes that has backend role and belong to DEV environment
```
knife search "role:backend AND chef_environment:DEV" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife search "role:backend AND chef_environment:DEV" -a name
2 items found

node5:
  name: node5

node6:
  name: node6
</pre>

### Find all nodes that has both frontend and backend roles
```
knife search "role:frontend AND role:backend" -a name
```
The expected output is
<pre>
node5:
  name: node5

node6:
  name: node6
</pre>

### Find all QA environment nodes that has frontend role 
```
knife search "role:frontend AND chef_environment:QA" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$<b>knife search "role:frontend AND chef_environment:QA" -a name</b>
1 items found

node3:
  name: node3
</pre>

### Find all QA environment nodes that has backend role
```
knife search "role:backend AND chef_environment:QA" -a name
```
The expected output is
<pre>
jegan@workstation Day4]$ knife search "role:backend AND chef_environment:QA" -a name
1 items found

node4:
  name: node4
</pre>

### Find all PROD environment nodes that has frontend role
```
knife search "role:frontend AND chef_environment:PROD" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$<b>knife search "role:frontend AND chef_environment:PROD" -a name</b>
1 items found

node1:
  name: node1
</pre>

### Find all PROD environment nodes that has backend role
```
knife search "role:backend AND chef_environment:PROD" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife search "role:backend AND chef_environment:PROD" -a name
1 items found

node2:
  name: node2
</pre>

### Databag
- is a way one or more cookbooks can access global data
- if required the data stored in data bag can be encrypted and accessed securely from cookbooks
- data bags are stored in Chef Infra Server as opposed to credential files stored in plain text @ GitHub(insecure)

#### Creating a data bag
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo
mkdir -p data_bags/credentials
```

#### Let us add mysql db server credentials there
Create a file mysql.json under Day4/chef-repo/data_bags/credentials folder
```
vim mysql.json
```
Append the below content in the file and save it.
```
{
  "id": "mysql",
  "comment": "MYSQL Server Credentials",
  "username": "mysql_admin",
  "password": "admin@123"
}
```
The expected output is
<pre>
[jegan@workstation chef-repo]$ mkdir -p data_bags/credentials
[jegan@workstation chef-repo]$ touch data_bags/credentials/mysql.json
[jegan@workstation chef-repo]$ touch data_bags/credentials/oracle.json
[jegan@workstation chef-repo]$ vim data_bags/credentials/mysql.json 
[jegan@workstation chef-repo]$ cat data_bags/credentials/mysql.json 
{
  "id": "mysql",
  "comment": "MYSQL Server Credentials",
  "username": "mysql_admin",
  "password": "admin@123"
}
</pre>

#### Let us add oracle db server credentials there
Create a file oracle.json under Day4/chef-repo/data_bags/credentials folder
```
vim oracle.json
```
Append the below content in the file and save it.
```
{
  "id": "oracle",
  "comment": "Oracle Server Credentials",
  "username": "oracle_admin",
  "password": "pass@123"
}
```
The expected output is
<pre>
[jegan@workstation chef-repo]$ vim data_bags/credentials/oracle.json 
[jegan@workstation chef-repo]$ cat data_bags/credentials/oracle.json 
{
  "id": "oracle",
  "comment": "Oracle Server Credentials",
  "username": "oracle_admin",
  "password": "pass@123"
}
</pre>

#### Let us create the data bag
Make sure the folder under data_bags and the name of your data bag you intend to create matches.
```
cd ~/Training/chef-sep-2021/Day4/chef-repo
knife data bag create credentials
```
The expected output is
<pre>
[jegan@workstation chef-repo]$ knife data bag create credentials
Created data_bag[credentials]
</pre>

You may verify the data bag is created successfully
```
knife data bag list
```
The expected output is
<pre>
[jegan@workstation chef-repo]$ knife data bag list
<b>credentials</b>
example
[jegan@workstation chef-repo]$ 
</pre>

### Displaying databag items
```
[jegan@workstation chef-repo]$ knife search credentials "*:*"
0 items found
```
As we are yet to add databag items in it, our credentials databag is empty.

### Let us add mysql credentials into our databag
```
cd ~/Training/chef-sep-2021/Day4/chef-repo

knife data bag from file credentials mysql.json
```
The expected output is
<pre>
[jegan@workstation chef-repo]$<b> knife data bag from file credentials mysql.json</b>
Updated data_bag_item[credentials::mysql]
</pre>

### Let us add oracle credentials into our databag
```
cd ~/Training/chef-sep-2021/Day4/chef-repo

knife data bag from file credentials oracle.json
```
The expected output is
<pre>
[jegan@workstation chef-repo]$<b> knife data bag from file credentials oracle.json</b>
Updated data_bag_item[credentials::oracle]
</pre>

### Find how many items are there in our credentials databag now
```
cd ~/Trainig/chef-sep-2021/Day4/chef-repo
knife search credentials "*:*"
```
The expected output is
<pre>
[jegan@workstation chef-repo]$ knife search credentials "*:*"
2 items found

chef_type: data_bag_item
comment:   MYSQL Server Credentials
data_bag:  credentials
id:        mysql
password:  admin@123
username:  mysql_admin

chef_type: data_bag_item
comment:   Oracle Server Credentials
data_bag:  credentials
id:        oracle
password:  pass@123
username:  oracle_admin
</pre>


### Let us access mysql credential stored into our databag using knife
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo

knife search credentials "id:mysql"
```
The expected output is
<pre>
jegan@workstation chef-sep-2021]$<b> knife search credentials "id:mysql"</b>
1 items found

chef_type: data_bag_item
comment:   MYSQL Server Credentials
data_bag:  credentials
id:        mysql
password:  admin@123
username:  mysql_admin
</pre>

### Let us access oracle credential stored into our databag using knife
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo

knife search credentials "id:oracle"
```
The expected output is
<pre>
[jegan@workstation chef-sep-2021]$ knife search credentials "id:oracle"
1 items found

chef_type: data_bag_item
comment:   Oracle Server Credentials
data_bag:  credentials
id:        oracle
password:  pass@123
username:  oracle_admin
</pre>

### Let us access the credentials of mysql and oracle db servers stored into our databag from cookbook
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo

knife cookbook upload demo
knife node run_list add node1 "recipe[demo]"
knife ssh 'name:node1' 'sudo chef-client'
```

The expected output is
<pre>
[jegan@workstation chef-repo]$ knife cookbook upload demo
Uploading demo           [0.1.0]
Uploaded 1 cookbook.
[jegan@workstation chef-repo]$ knife ssh 'name:node1' 'sudo chef-client'
jegan@node1's password:
node1 knife sudo password: 
Enter your password:  
node1 
node1 Chef Infra Client, version 17.4.38
node1 Patents: https://www.chef.io/patents
node1 Infra Phase starting
node1 Resolving cookbooks for run list: ["demo"]
node1 Synchronizing cookbooks:
node1   - demo (0.1.0)
node1 Installing cookbook gem dependencies:
node1 Compiling cookbooks...
node1 Converging 3 resources
node1 Recipe: demo::default
node1   * execute[get-hostname] action run
node1     - execute hostname
node1   * log[name] action write
node1   * template[/tmp/credentials.txt] action create
node1     - update content in file /tmp/credentials.txt from 68fc22 to db4c52
node1     --- /tmp/credentials.txt	2021-09-18 05:29:57.057261818 +0530
node1     +++ /tmp/.chef-credentials20210918-9974-j1jsa8.txt	2021-09-18 06:01:52.183906898 +0530
node1     @@ -1,6 +1,6 @@
node1     <b>-MySQL Username  ==> admin
node1     +MySQL Username  ==> mysql_admin
node1      MySQL Password  ==> admin@123
node1      Oracle Username ==> oracle_admin
node1     -Oracle Password ==> admin@123
node1     +Oracle Password ==> pass@123</b>
node1      
node1     - restore selinux security context
node1 
node1 Running handlers:
node1 Running handlers complete
node1 Infra Phase complete, 2/3 resources updated in 04 seconds
[jegan@workstation chef-repo]$ 
</pre>

### Berks
- is a Cookbook Dependency Management tool
- it uses Berksfile to understand your cookbook dependencies 
- let's say your cookbook depends on some cookbook from Chef Supermarket, this berks tools helps you download
  your dependent cookbook automatically based on Berksfile.
- we need to update the dependencies in Berksfile and metadata.rb.
- when you upload your cookbook to Chef Server via berks tool, it refers the Berksfile to get the 
  dependencies of your cookbook.  It then upload your cookbook along with its dependent cookbooks.
- When chef-client is executed on the Nodes, the chef-client will refer the metadata.rb file to understand 
  the dependencies of your cookbook so that they also will be download from the Chef Infra Server to the node 
  before executing your cookbook.
