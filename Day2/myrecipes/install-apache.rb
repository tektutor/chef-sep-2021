# Install httpd web server in CentOS/RedHat Linux Distros
package 'httpd' do
  action :install
end

# Deploy a custom web page into httpd webserver
file '/var/www/html/index.html' do
  action :create
  content "Chef works!\n"
end

# This will configure the httpd server picking the configuration details from the file mentioned in source path
remote_file'/etc/httpd/conf/httpd.conf' do
  action :create
  source 'file:///home/jegan/Training/chef-sep-2021/Day2/myrecipes/httpd.conf'
end

# Enable and Start the httpd service
service 'httpd' do
  action [:enable, :start]
end
