#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
#
# Install apache web server in Ubuntu(Debain Linux Family)
#
include_recipe '::install-apache2'
include_recipe '::deploy-custom-webpage'
include_recipe '::start-webserver'
