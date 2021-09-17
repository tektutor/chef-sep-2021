#
# Cookbook:: wordpress
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
include_recipe "::install-wordpress"
include_recipe "::configure-wordpress"
include_recipe "::start-wordpress"
