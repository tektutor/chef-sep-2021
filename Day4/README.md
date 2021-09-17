### Executing Chef cookbook recipe that demonstrates template feature of Chef
```
cd ~/Training/chef-sep-2021
git pull
cd Day4/chef-repo
rm -rf .chef/*
cp -R ../../Day3/.chef/* .chef
knife cookbook upload apache
knife knife node run_list add node1 "recipe[apache]"
knife knife node run_list add node2 "recipe[apache]"
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
