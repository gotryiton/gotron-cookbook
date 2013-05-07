environment = node[:gotron][:app_environment]

cron "image_deletion" do
  hour '5'
  minute '0'
  command "cd /var/www/ootd/current && bin/rake RAILS_ENV=#{environment} db:cleanup:images 2>&1 | logger -t '##IMAGE_DELETION##'"
  path "/home/vagrant/.rbenv/shims:/home/vagrant/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  user "deployer"
end

