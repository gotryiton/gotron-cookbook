node[:gotron][:services].each do |process_name|
  service_name = "#{node[:gotron][:app_name]}_#{process_name}"
  template "/etc/init/#{service_name}.conf" do
    owner 'root'
    group 'root'
    mode "0644"
    source "service.upstart.erb"
    variables :service_name => service_name, :process_name => process_name
    notifies :restart, "service[#{service_name}]", :delayed
  end

  service service_name do
    action [:enable, :start]
    supports :status => true, :restart => true, :reload => true
    provider Chef::Provider::Service::Upstart
  end
end
