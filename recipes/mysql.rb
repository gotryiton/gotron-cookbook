include_recipe "mysql::server"

db_name = "#{node[:gotron][:app_name]}_#{node[:gotron][:app_environment]}"

password_command = ""
if node[:mysql][:server_root_password] != ""
  password_command = "-p#{node[:mysql][:server_root_password]}"
end

execute "create database #{db_name}" do
  command "mysql --user=root #{password_command} -e 'CREATE DATABASE #{db_name}'"
  not_if "mysql --user=root #{password_command} -e 'show databases' | grep '#{db_name}'"
end

execute "grant app privileges to gtio_app on #{db_name}" do
  command "mysql --user=root #{password_command} -e \"GRANT ALL ON #{db_name}.* TO 'gtio_app'@'localhost' IDENTIFIED BY '#{node[:gotron][:app_password]}'\""
  not_if "mysql --user=root #{password_command} -e \"SHOW GRANTS FOR 'gtio_app'@'localhost'\" | grep 'GRANT ALL PRIVILEGES ON `#{db_name}.*`'"
end

check_db_command = "mysql --user=root #{password_command} -e \"SELECT IF(COUNT(DISTINCT table_name) > 0, 1, 0) as 'count' FROM information_schema.columns WHERE table_schema = '#{db_name}';\" | grep 0"

src_file_path  = "#{Chef::Config['file_cache_path'] || '/tmp'}/gotryiton.sql.tar.gz"
src_file = "#{Chef::Config['file_cache_path'] || '/tmp'}/gotryiton.sql"
db_source = node[:gotron][:db_source]

remote_file db_source do
  source db_source
  path src_file_path
  backup false
  only_if check_db_command
end

execute "import database #{db_name}" do
  command "tar zxf #{src_file_path} -C #{::File.dirname(src_file_path)} && mysql --user=root #{password_command} #{db_name} < #{src_file}"
  only_if check_db_command
end
