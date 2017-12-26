#!/bin/bash
cp solo.rb openshift.json /root
cd /root
chef-solo -c solo.rb -j openshift.json
