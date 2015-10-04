Package {
    allow_virtual => true,
}

include git
include epel
include python

service { 'iptables':
    enable => false,
    ensure => 'stopped'
}
