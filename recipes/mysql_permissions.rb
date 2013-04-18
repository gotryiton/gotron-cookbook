execute "mysql guest permissions" do
  command "mysql -u root -e \"grant all privileges on *.* to root@'10.0.2.2' identified by '' with grant option;\" "
  not_if "mysql -u root -e \"SHOW GRANTS FOR 'root'@'10.0.2.2';\" | grep 'GRANT ALL PRIVILEGES'"
end

execute "mysql host permissions" do
  command "mysql -u root -e \"grant all privileges on *.* to root@'33.33.33.10' identified by '' with grant option;\" "
  not_if "mysql -u root -e \"SHOW GRANTS FOR 'root'@'33.33.33.10';\" | grep 'GRANT ALL PRIVILEGES'"
end
