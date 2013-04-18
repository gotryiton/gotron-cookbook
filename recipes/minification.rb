include_recipe "java"
include_recipe "nodejs"
include_recipe "pngout"

package "libxml2-dev" do
  action :upgrade
end

package "libxslt1-dev" do
  action :upgrade
end

gem_package "sbader-yui-compressor" do
  version "~> 0.9"
end

gem_package "fog" do
  version "~> 1.1"
end

gem_package "compass" do
  version '0.12.2'
  not_if "gem list compass | grep 0.12.2"
end

%w(advancecomp gifsicle jpegoptim libjpeg-progs optipng pngcrush).each do |name|
  package name do |package|
    action :install
  end
end

gem_package "image_optim" do
  version '0.8.0'
  not_if "gem list image_optim | grep 0.8.0"
end

gem_package "uglifier" do
  version '1.3.0'
  not_if "gem list image_optim | grep 1.3.0"
end

nodejs_npm_package "bower" do
  version "0.8.6"
end

