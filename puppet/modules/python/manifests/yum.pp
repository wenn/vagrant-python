class python::yum () {

    exec { 'yum update':
        command     => 'yum -y update',
        path        => '/usr/bin',
        # refreshonly => true,
    }

    exec { 'yum groupinstall':
        command      => 'yum groupinstall -y "development tools"',
        path        => '/usr/bin',
        # refreshonly => true,
    }

    exec { 'yum install':
        command      => 'yum install -d 10 -y zlib-dev openssl-devel sqlite-devel bzip2-devel xz-libs',
        path        => '/usr/bin',
        # refreshonly => true,
    }

    Exec['yum update']
    ~> Exec['yum groupinstall']
    ~> Exec['yum install']

}
