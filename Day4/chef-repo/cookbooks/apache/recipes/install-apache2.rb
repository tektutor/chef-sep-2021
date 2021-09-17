package 'Install Apache' do
  case node['platform']
  when 'centos'
    package_name 'httpd'
  when 'ubuntu'
    package_name 'apache2'
  end
end
