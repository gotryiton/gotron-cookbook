variant = node[:gotron][:variant]

if variant == "server"
  include_recipe "gotron::deploy"
else
  include_recipe "gotron::local_deploy"
end

include_recipe "gotron::php"
include_recipe "gotron::migrations"
include_recipe "gotron::services"
