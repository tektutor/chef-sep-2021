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
{
  "name": "node5",
  "chef_environment": "_default",
  "normal": {
    "tags": [

    ]
  },
  "policy_name": null,
  "policy_group": null,
  "run_list": [
  "role[frontend]",
  "role[backend]"
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
