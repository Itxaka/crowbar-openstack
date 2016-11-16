#
# Cookbook Name:: memcached
# Definition:: memcached_instance
#
# Copyright 2009, Opscode, Inc.
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

define :memcached_instance do
  include_recipe "memcached"

  opts = params

  case node[:platform_family]
  when "suse", "rhel"
    service "memcached" do
      action [:enable, :start]
    end
  else
    runit_service "memcached-#{params[:name]}" do
      template_name "memcached"
      cookbook "memcached"
      options({
        memory: node[:memcached][:memory],
        port: node[:memcached][:port],
        user: node[:memcached][:user]}.merge(opts)
      )
    end
  end
end