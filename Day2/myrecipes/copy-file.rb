remote_file '/etc/httpd/conf/httpd.conf' do
  action :create
  source "file:///home/jegan/ChefRecipes/httpd.conf"
end
