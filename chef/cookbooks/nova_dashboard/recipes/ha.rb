# Copyright 2014 SUSE
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

haproxy_loadbalancer "horizon" do
  address "0.0.0.0"
  port 80
  use_ssl false
  servers CrowbarPacemakerHelper.haproxy_servers_for_service(node, "nova_dashboard", "nova_dashboard-server", "plain")
  action :nothing
end.run_action(:create)

if node[:nova_dashboard][:apache][:ssl]
  haproxy_loadbalancer "horizon-ssl" do
    address "0.0.0.0"
    port 443
    use_ssl true
    servers CrowbarPacemakerHelper.haproxy_servers_for_service(node, "nova_dashboard", "nova_dashboard-server", "ssl")
    action :nothing
  end.run_action(:create)
end
