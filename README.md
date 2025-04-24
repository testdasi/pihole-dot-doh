# Deprecated
Due to recent release of Pihole 6, its docker image was rewritten AND switched to Alpine. I unfortunately don't have to fix this docker since much of the code was written specifically to work with Pihole 5 docker.

# pihole-dot-doh
Official pihole docker with both DoT (DNS over TLS) and DoH (DNS over HTTPS) clients. Don't browse the web securely and yet still send your DNS queries in plain text!

Multi-arch image built for both Raspberry Pi (arm64, arm32/v7) and amd64.

## Usage:
For docker parameters, refer to [official pihole docker readme](https://github.com/pi-hole/pi-hole). Below is an Unraid example.

    docker run -d \
        --name='pihole-dot-doh' \
        --cap-add=NET_ADMIN \
        --restart=unless-stopped \
        --net='bridge' \
        -e TZ="Europe/London" \
        -e HOST_OS="Unraid" \
        -v '/mnt/user/appdata/pihole-dot-doh/pihole/':'/etc/pihole/':'rw' \
        -v '/mnt/user/appdata/pihole-dot-doh/dnsmasq.d/':'/etc/dnsmasq.d/':'rw' \
        -v '/mnt/user/appdata/pihole-dot-doh/config/':'/config':'rw' \
        -e 'DNS1'='127.1.1.1#5153' \
        -e 'DNS2'='127.2.2.2#5253' \
        -e 'TZ'='Europe/London' \
        -e 'WEBPASSWORD'='password' \
        -e 'INTERFACE'='br0' \
        -e 'ServerIP'='192.168.1.24' \
        -e 'ServerIPv6'='' \
        -e 'IPv6'='False' \
        -e 'DNSMASQ_LISTENING'='all' \
        -p '10053:53/tcp' \
        -p '10053:53/udp' \
        -p '10067:67/udp' \
        -p '10080:80/tcp' \
        -p '10443:443/tcp' \
        'testdasi/pihole-dot-doh:latest'

### Notes:
* Remember to set pihole env DNS1 and DNS2 to use the DoH / DoT IP below. If either DNS1 or DNS2 is NOT set, Pihole will use a non-encrypted service.
  * DoH service (cloudflared) runs at 127.1.1.1#5153. Uses cloudflare (1.1.1.1 / 1.0.0.1) by default
  * DoT service (stubby) runs at 127.2.2.2#5253. Uses google (8.8.8.8 / 8.8.4.4) by default
  * To use just DoH or just DoT service, set both DNS1 and DNS2 to the same value. 
* In addition to the 2 official paths, you can also map container /config to expose configuration yml files for cloudflared (cloudflared.yml) and stubby (stubby.yml).
  * Edit these files to add / remove services as you wish. The flexibility is yours.
* Credits:
  * Pihole base image is the official [pihole/pihole:latest](https://hub.docker.com/r/pihole/pihole/tags?page=1&name=latest)
  * Cloudflared client was obtained from [official site](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation#linux)
  * Stubby is a standard debian package
* I code for fun and my personal uses; hence, these niche functionalties that nobody asks for. ;)
* If you like my work, [a donation to my burger fund](https://paypal.me/mersenne) is very much appreciated.

[![Donate](https://raw.githubusercontent.com/testdasi/testdasi-unraid-repo/master/donate-button-small.png)](https://paypal.me/mersenne). 
