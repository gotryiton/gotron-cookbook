environment = node[:gotron][:app_environment]

cron "image_deletion" do
  hour '5'
  minute '0'
  command "cd /var/www/ootd/current && /usr/local/bin/rake RAILS_ENV=#{environment} db:cleanup:images 2>&1 | logger -t '##IMAGE_DELETION##'"
  user node[:gotron][:cron_user]
end

