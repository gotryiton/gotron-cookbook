include_recipe "java"
include_recipe "nodejs"
include_recipe "pngout"

%w(libxml2-dev libxslt1-dev advancecomp gifsicle jpegoptim libjpeg-progs optipng pngcrush).each do |name|
  package name do |package|
    action :install
  end
end

nodejs_npm_package "bower" do
  version "0.8.6"
end
