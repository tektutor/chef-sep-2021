# Install httpd in CentOS(RedHat Linux Distros)
package 'httpd' do
  action :install
end

# Deploy custom web page into httpd
file '/var/www/html/index.html' do
    action :create
    content 'Chef works !!!'
end

# Start httpd web server
service 'httpd' do
  action :start
end


