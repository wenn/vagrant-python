class python () {
    include python::yum
    include python::install

    package { 'gcc-c++':
        ensure => installed,
    }

    package { 'python-devel':
        ensure  => installed,
        require => Package['gcc-c++'],
    }

    package { 'python-pip':
        ensure  => installed,
        require => Package['python-devel']
    }

    package { 'python-virtualenv':
        ensure  => installed,
        require => Package['python-devel']
    }

    package { 'Fabric':
        ensure   => installed,
        provider => pip,
        require  => File['/usr/bin/pip-python'],
    }

    # fix for puppet provider trying to run pip-python
    file { '/usr/bin/pip-python':
       ensure  => 'link',
       target  => '/usr/bin/pip',
       require => Package['python-pip'],
    }

}
