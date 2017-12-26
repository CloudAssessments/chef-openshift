#!/bin/bash
cp solo.rb openshift.json /root
berks vendor ../
cd /root
chef-solo -c solo.rb -j openshift.json
