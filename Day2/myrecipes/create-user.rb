user 'devops' do
  action :modify
  shell  '/bin/bash'
  uid    2000
  gid    1001 
  home   '/home/devops'
  manage_home true
end


