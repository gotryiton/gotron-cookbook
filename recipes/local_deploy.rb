app_path = "/var/www/#{node[:gotron][:app_name]}"

directory app_path do
  owner "root"
  group "root"
  mode 0755
  not_if { File.exist?(app_path) }
  recursive true
end

link "#{app_path}/current" do
  to "/vagrant"
  not_if { File.symlink?("#{app_path}/current") }
end
