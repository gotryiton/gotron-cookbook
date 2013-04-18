cron "pick_winner" do
  hour '3'
  minute '0'
  command "#{node[:php][:prefix_dir]}/bin/php /var/www/ootd/current/app/crons/pick_winner.php 2>&1 | logger -t '##PICK_WINNER##'"
  user node[:gotron][:cron_user]
end
