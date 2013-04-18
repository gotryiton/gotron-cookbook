execute "mysql localhost permissions" do
  command "mysql -u root -e \"grant all privileges on *.* to root@'10.0.2.2' identified by '' with grant option;\" "
  not_if "mysql -u root -e \"SHOW GRANTS FOR 'root'@'10.0.2.2';\" | grep 'GRANT ALL PRIVILEGES'"
end

db_name = "#{node[:gotron][:app_name]}_development"
execute "create database #{db_name}" do
  command "mysql --user=root -e 'CREATE DATABASE #{db_name}'"
  not_if "mysql --user=root -e 'show databases' | grep '#{db_name}'"
end

db_backup_name = "/vagrant/#{db_name}.sql"
execute "import database #{db_name}" do
  command "mysql --user=root #{db_name} < #{db_backup_name}"
  only_if "mysql --user=root -e \"SELECT COUNT(DISTINCT table_name) FROM information_schema.columns WHERE table_schema = '#{db_name}';\" | grep 0"
  only_if { File.exist?(db_backup_name) }
end
