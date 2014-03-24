#
# Cookbook Name:: openhrp
# Recipe:: default
#
# Copyright 2014, Yosuke Matsusaka
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"
include_recipe "build-essential"
include_recipe "python"
include_recipe "subversion::client"
include_recipe "omniorb"
include_recipe "collada-dom"
include_recipe "openrtm-aist"

pkgs = value_for_platform_family(
  ["debian"] => %w{cmake pkg-config libtool uuid-dev libyaml-dev
libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-signals-dev libboost-thread-dev
liblapack-dev libatlas-base-dev libatlas-dev libblas-dev
libeigen3-dev
f2c libf2c2-dev libgfortran3 libgfortran3-dbg
zlib1g-dev libjpeg62-dev libpng12-dev}
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

python_pip "PyYaml"

bash "compile_openhrp" do
  cwd "#{Chef::Config['file_cache_path']}/openhrp"
  code <<-EOH
      cmake . -DCOMPILE_JAVA_STUFF=OFF -DENABLE_DOXYGEN=OFF -DOPENRTM_DIR=/usr/local/
      make clean && make && make install
      ldconfig
  EOH
  action :nothing
end

subversion "openhrp" do
  repository "https://openrtp.org/svn/hrg/openhrp/3.1/trunk/"
  revision "HEAD"
  destination "#{Chef::Config[:file_cache_path]}/openhrp"
  svn_arguments "--no-auth-cache --non-interactive --trust-server-cert"
  svn_info_args "--no-auth-cache --non-interactive --trust-server-cert"
  action :sync
  notifies :run, "bash[compile_openhrp]", :immediately
end
