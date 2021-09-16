package 'httpd' do
  action :install
end

file '/var/www/html/index.html' do
  action :create
  content "Chef works!\n"
end

remote_file'/etc/httpd/conf/httpd.conf' do
  action :create
  source 'file:///home/jegan/ChefRecipes/httpd.conf'
end

service 'httpd' do
  action [:enable, :start]
end
