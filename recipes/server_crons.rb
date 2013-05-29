app_name = node[:gotron][:app_name]

cron "data_integrity" do
    hour "4"
    minute "0"
    command "#{node[:php][:prefix_dir]}/bin/php /var/www/#{app_name}/current/app/crons/data_integrity.php 2>&1 | logger -t '##DATA_INTEGRITY##'"
  user node[:gotron][:cron_user]
end

cron "fetch_blog_posts" do
  hour "5"
  minute "0"
  command "#{node[:php][:prefix_dir]}/bin/php /var/www/#{app_name}/current/app/crons/fetch_blog_posts.php 2>&1 | logger -t '##BLOG_POSTS##'"
  user node[:gotron][:cron_user]
end

cron "check_products" do
  hour "15"
  minute "0"
  command "#{node[:php][:prefix_dir]}/bin/php /var/www/#{app_name}/current/app/crons/check_products.php 2>&1 | logger -t '##PRODUCT_UPDATES##'"
  user node[:gotron][:cron_user]
end

cron "tmp_cleanup" do
  minute "0"
  command "find /var/www/#{app_name}/current/tmp -name '*.jpg' -type f -mmin +60 -delete"
  user node[:gotron][:cron_user]
end
