file '/var/tmp/testfile' do
  owner 'devops'
  group 'devops'
  mode '777'
  content "Hello DevOps, welcome to Chef Training !\n"
  action :create
end
