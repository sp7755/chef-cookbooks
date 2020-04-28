#
# Cookbook:: install_software
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

######################################################################
# Install 7Zip  #
######################################################################
windows_package node['install_software']['7zip_package_name'] do
  source node['install_software']['7zip_url']
  checksum node['install_software']['7zip_checksum']
  options "INSTALLDIR=\"#{node['install_software']['7zip_home']}\""
  action :install
end

# update path
windows_path node['install_software']['7zip_home'] do
  action :add
end
