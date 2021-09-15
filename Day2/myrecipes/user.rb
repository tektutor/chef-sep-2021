#chef_gem 'ruby-shadow'

user 'devops' do
  shell '/bin/bash'
  uid   '9999'
  action :create
end
