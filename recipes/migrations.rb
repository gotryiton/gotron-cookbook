package "libxml2-dev" do
  action :upgrade
end

package "libxslt1-dev" do
  action :upgrade
end

gem_package "mysql" do
  version '2.8.1'
  not_if "gem list mysql | grep 2.8.1"
end

gem_package "standalone_migrations" do
  version '2.0.6'
  not_if "gem list standalone_migrations | grep 2.0.6"
end

gem_package "logging" do
  version '1.7.2'
  not_if "gem list logging | grep 1.7.2"
end

gem_package "sbader-lhm" do
  version '1.1.0'
  not_if "gem list sbader-lhm | grep 1.1.0"
end

gem_package "mysql2" do
  version '0.3.11'
  not_if "gem list mysql2 | grep 0.3.11"
end

gem_package "foreigner" do
  version '1.4.1'
  not_if "gem list foreigner | grep 1.4.1"
end

