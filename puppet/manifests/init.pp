Package {
    allow_virtual => true,
}

include git
include python

service { 'iptables':
    enable => false,
    ensure => 'stopped'
}
