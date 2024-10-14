# 2024-10-14 17:21:54 by RouterOS 7.16
# software id = 
#
/interface ethernet
set [ find default-name=ether1 ] comment=WAN
set [ find default-name=ether2 ] comment=LAN
/ip hotspot profile
add hotspot-address=192.168.5.1 name=hsprof1
/ip pool
add name=hs-pool-3 ranges=192.168.5.2-192.168.5.254
/ip hotspot
add address-pool=hs-pool-3 disabled=no interface=ether2 name=hotspot1 \
    profile=hsprof1
/ip address
add address=192.168.5.1/24 comment="hotspot network" interface=ether2 \
    network=192.168.5.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server
add address-pool=hs-pool-3 interface=ether2 name=dhcp1
/ip dhcp-server network
add address=192.168.5.0/24 comment="hotspot network" gateway=192.168.5.1
/ip dns
set servers=8.8.8.8
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward connection-nat-state="" connection-state="" \
    dst-address=1.1.1.1 dst-port=443 port="" protocol=tcp
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.168.5.0/24
/ip hotspot user
add name=admin
/system note
set show-at-login=no
