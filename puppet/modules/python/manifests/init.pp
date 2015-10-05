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

    # fix for puppet provider trying to run pip-python
    file { '/usr/bin/pip-python':
       ensure  => 'link',
       target  => '/usr/bin/pip',
       require => Package['python-pip'],
    }

    package { 'python-virtualenv':
        ensure  => installed,
        require => Package['python-devel']
    }

}
