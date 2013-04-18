directory "/home/deployer/.ssh" do
  owner "deployer"
  group "deployer"
  mode 0700
  not_if { File.directory?('/home/deployer/.ssh') }
end

cookbook_file "/home/deployer/.ssh/id_rsa" do
  owner "deployer"
  group "deployer"
  mode 0600
  source "id_rsa"
  not_if { File.exist?('/home/deployer/.ssh/id_rsa') }
end

cookbook_file "/home/deployer/.ssh/known_hosts" do
  owner "deployer"
  group "deployer"
  mode 0644
  source "known_hosts"
end

app_path = "/var/www/#{node[:gotron][:app_name]}"

directory app_path do
  owner "deployer"
  group "deployer"
  mode 0755
  not_if { File.exist?(app_path) }
  recursive true
end

directory "#{app_path}/shared" do
  owner "deployer"
  group "deployer"
  mode 0755
  recursive true
end

directory "#{app_path}/releases" do
  owner "deployer"
  group "deployer"
  mode 0755
  recursive true
end
