# Deploy custom html page into apache web server
template '/var/www/html/index.html' do
  action :create
  source 'index.erb'
  variables(
    greeting_msg: 'Chef Training!'
  )
end
