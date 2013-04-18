cron = data_bag_item("applications", "gotryiton")
if cron.has_key?(node.chef_environment)
  cron[node.chef_environment]["cron_jobs"].each do |job, value|
    cron "#{job}" do
      hour "#{value['hour']}"
      minute "#{value['minute']}"
      command "#{value['command']}"
      user "#{value['user']}"
    end
  end
end
