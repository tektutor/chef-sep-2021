#
# Cookbook:: demo
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

execute 'get-hostname' do
   command 'hostname' 
end

log 'name' do
  level :info
  message 'This is a test log message'
  action :write
end

mysql  = data_bag_item("credentials", "mysql")
oracle = data_bag_item("credentials", "oracle")

template '/tmp/credentials.txt' do
    action :create
    source 'databag.erb'

    variables ({
        :mysql => mysql,
        :oracle => oracle
    }) 

end
