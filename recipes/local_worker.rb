include_recipe "beanstalkd"
app_path = "/var/www/#{node[:gotron][:app_name]}"

directory app_path do
  owner "root"
  group "root"
  mode 0755
  not_if { File.exist?(app_path) }
  recursive true
end

link "#{app_path}/current" do
  to "/vagrant/#{node[:gotron][:app_name]}/"
  not_if { File.symlink?("#{app_path}/current") }
end

include_recipe "gotron::php"
include_recipe "gotron::services"
