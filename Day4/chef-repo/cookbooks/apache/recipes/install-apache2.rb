package 'Install Apache' do
  action :install
  case node['platform']
  when 'centos'
    package_name 'httpd'
  when 'ubuntu'
    package_name 'apache2'
  end
end
