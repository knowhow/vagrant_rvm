#
# Cookbook Name:: rvm
# Recipe:: install

ruby_version = [].tap do |v|
  v << node[:rvm][:ruby][:implementation] if node[:rvm][:ruby][:implementation]
  v << node[:rvm][:ruby][:version] if node[:rvm][:ruby][:version]
  v << node[:rvm][:ruby][:patch_level] if node[:rvm][:ruby][:patch_level]
end * '-'

include_recipe "rvm::default"

bash "installing #{ruby_version}" do
  user "root"
  code "rvm install #{ruby_version}"
  not_if "rvm list | grep #{ruby_version}"
end

bash "make #{ruby_version} the default ruby" do
  user "root"
  code "rvm --default #{ruby_version}"
  not_if "rvm list | grep '=> #{ruby_version}'"
  only_if { node[:rvm][:ruby][:default] }
#  notifies :restart, "service[chef-client]"
end

# set this for compatibilty with other people's recipes
node.default[:languages][:ruby][:ruby_bin] = `rvm default exec which ruby`.chomp

gem_package "chef" do
  gem_binary "rvm-gem.sh"
  only_if "test -e rvm-gem.sh"
  # re-install the chef gem into rvm to enable subsequent chef-client run
end

# Needed so that chef doesn't freak out if the chef-client service
# isn't present.
#service "chef-client"
