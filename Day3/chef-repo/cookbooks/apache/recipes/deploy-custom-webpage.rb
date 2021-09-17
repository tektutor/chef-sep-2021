# Deploy custom html page into apache web server
file '/var/www/html/index.html' do
  action :create
  content '<h1>Ubuntu Node is successfully configured !!!</h1>'
end
