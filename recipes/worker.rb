variant = node[:gotron][:variant]

if variant == "server"
  include_recipe "gotron::deploy"
else
  include_recipe "gotron::local_deploy"
end

include_recipe "gotron::php"

if variant == "local"
  include_recipe "gotron::local_mysql"
end

include_recipe "gotron::services"
include_recipe "gotron::services"
