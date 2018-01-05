export public_hostname=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
export public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
sed -i "s/ip-10-0-2-202.us-east-2.compute.internal/$public_hostname/g" /etc/origin/master/master-config.yaml
sed -i "s/subdomain:\ \ \"paas.master.10.0.2.202.xip.io\"/subdomain: \"paas.master.$public_ip.xip.io\"/g" /etc/origin/master/master-config.yaml
sed -i "s/enabled/enabled --insecure-registry 172.30.0.0\/16/g" /etc/sysconfig/docker
echo -e "server=8.8.8.8\nserver=8.8.4.4" > /etc/dnsmasq.d/origin-upstream-dns.conf 
chattr +i /etc/dnsmasq.d/origin-upstream-dns.conf 
sed -i ':a;N;$!ba;s/10.0.2.202/8.8.8.8\nnameserver 8.8.4.4/g' /etc/resolv.conf 
chattr +i /etc/resolv.conf
systemctl restart docker
systemctl restart dnsmasq
systemctl stop origin-master
oc cluster up --public-hostname="$public_hostname" --routing-suffix="$public_ip.nip.io"
