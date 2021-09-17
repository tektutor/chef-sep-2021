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
```
knife node edit node3
```
You need to add the "role[frontend]" in the run_list of the node3 as highlighted below.

<pre>
{
  "name": "node3",
  "chef_environment": "_default",
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
  "chef_environment": "_default",
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
  "chef_environment": "_default",
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

#### Adding multiples roles to a single node 
```
knife node edit node6
```

Add both roles to node6 as shown below
<pre>

  "name": "node6",
  "chef_environment": "_default",
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

### Find all nodes that has frontend role
```
knife search "role:frontend" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife search "role:frontend" -a name
3 items found

node3:
  name: node3

node5:
  name: node5

node6:
  name: node6
</pre>

### Find all nodes that has backend role
```
knife search "role:backend" -a name
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife search "role:backend" -a name
3 items found

node4:
  name: node4

node5:
  name: node5

node6:
  name: node6
</pre>

### Find all nodes that has both frontend and backend roles
```
knife search "role:frontend AND role:backend" -a name
```

### Let's create DEV,QA and PROD environments

#### Creating DEV environment
```
knife environment create DEV
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife environment create DEV
Created DEV
</pre>

#### Creating QA environment
```
knife environment create QA
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife environment create QA
Created QA
</pre>

#### Creating PROD environment
```
knife environment create PROD
```
The expected output is
<pre>
[jegan@workstation Day4]$ knife environment create PROD
Created PROD
</pre>

#### Let us update the environment in nodes1
```
knife node edit node1
```
Update environment from _default to PROD.
The expected output is
<pre>
[jegan@workstation Day4]$ knife node edit node1
Saving updated chef_environment on node node1
</pre>

#### Let us update the environment in nodes2
```
knife node edit node2
```
Update environment from _default to PROD.
The expected output is
<pre>
[jegan@workstation Day4]$ knife node edit node2
Saving updated chef_environment on node node2
</pre>

#### Let us update the environment in nodes3
```
knife node edit node3
```
Update environment from _default to QA.
The expected output is
<pre>
[jegan@workstation Day4]$ knife node edit node3
Saving updated chef_environment on node node3
</pre>

#### Let us update the environment in nodes4
```
knife node edit node4
```
Update environment from _default to QA.
The expected output is
<pre>
[jegan@workstation Day4]$ knife node edit node4
Saving updated chef_environment on node node4
</pre>

#### Let us update the environment in nodes5
```
knife node edit node5
```
Update environment from _default to DEV.
The expected output is
<pre>
[jegan@workstation Day4]$ knife node edit node5
Saving updated chef_environment on node node5
</pre>

#### Let us update the environment in nodes6
```
knife node edit node6
```
Update environment from _default to PROD.
The expected output is
<pre>
[jegan@workstation Day4]$ knife node edit node6
Saving updated chef_environment on node node6
</pre>
