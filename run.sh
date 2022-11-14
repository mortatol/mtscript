#/bin/sh

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
sudo DEBIAN_FRONTEND=noninteractive apt install -y git curl build-essential libssl-dev zlib1g-dev
git clone -b gcc10 https://github.com/krepver/MTProxy/
cd MTProxy/
make
cd objs/bin/
curl -s https://core.telegram.org/getProxySecret -o proxy-secret
curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf
./mtproto-proxy -u nobody -p 8888 -H 443 -S 5717cd718527e90e5823998620571aa9 --aes-pwd proxy-secret proxy-multi.conf -M 1 --allow-skip-dh --crc32c --ipv6 -D cloudflare.com &
