app_name = node[:gotron][:app_name]
app_path = "/var/www/#{app_name}"

include_recipe "php::source_fpm"
include_recipe "nginx::source"

cookbook_file "/etc/nginx/php.conf" do
  owner "root"
  group "root"
  mode 0644
  source "php.conf"
  notifies :restart, resources(:service => "nginx")
end

if node[:gotron][:default_site]
  default_site = "default"
else
  default_site = ""
end

template "/etc/nginx/sites-available/#{app_name}.conf" do
  owner "root"
  group "root"
  mode "0644"
  source "app.conf.erb"
  variables :server_names => node[:gotron][:server_names].join(" "),
            :lockdown => node[:gotron][:lockdown],
            :root_path => "#{app_path}/current/public",
            :default => default_site,
            :log_format => app_name
  notifies :reload, resources(:service => "nginx")
end

cookbook_file "/etc/nginx/access_dev" do
  owner "root"
  group "root"
  mode 0644
  source "access_dev"
end

cookbook_file "/etc/nginx/access_standard" do
  owner "root"
  group "root"
  mode 0644
  source "access_standard"
end

nginx_site "#{app_name}.conf"
