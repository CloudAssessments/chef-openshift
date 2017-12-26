#!/bin/bash
cp solo.rb openshift.json /root
cd /root
git clone https://github.com/chef-cookbooks/yum.git
chef-solo -c solo.rb -j openshift.json
