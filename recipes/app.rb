include_recipe "gotron::deploy"
include_recipe "gotron::php"
include_recipe "gotron::migrations"
include_recipe "gotron::minification"
include_recipe "php::source_apc"
include_recipe "gotron::web_nginx"
include_recipe "gotron::app_crons"