#Installs packages for OpenShift Origin

package ['centos-release-openshift-origin']

include_recipe 'yum'

package ['wget','vim','git','net-tools','bind-utils','iptables-services','bridge-utils',
  'bash-completion','kexec-tools','sos','psacct','ansible','pyOpenSSL','docker',
  'origin-clients','ruby']

cookbook_file '/etc/sysconfig/docker' do
  source 'docker'
  owner 'root'
  group 'root'
  mode '700'
end

%w{docker NetworkManager}.each do |enable_service|
   service "#{enable_service}" do
     supports(restart: true)
     action [:enable, :start]
   end
end

execute 'cluster' do
  command "oc cluster up"
end
