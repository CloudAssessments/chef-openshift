#Creates User and assigns to correct group

user 'stack' do
  home '/home/stack'
  manage_home true
  shell '/bin/bash'
  password 'p0pc0rn'
end

group "adding stack to sudo" do
  group_name 'wheel'
  members 'stack'
  action :modify
  append true
end

cookbook_file '/etc/sudoers.d/stack_user' do
  source 'stack_user'
  owner 'root'
  group 'root'
  mode '0440'
end
