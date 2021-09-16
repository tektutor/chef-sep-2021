#
# Cookbook:: webserver - Install httpd web server in CentOS/RedHat Linux Distros
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe '::install-httpd'
include_recipe '::deploy-custom-html'
include_recipe '::start-webserver'
