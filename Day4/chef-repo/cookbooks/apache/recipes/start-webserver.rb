# Start the apache web server
service 'Start Apache Service' do
  action :start
  case node['platform']
  when 'centos'
    service_name 'httpd'
  when 'ubuntu'
    service_name 'apache2'
  end
end
