class python::install () {

    $version = "3.5.0"
    $python_source = "Python-${version}.tar.xz"
    $cwd = "/tmp"

    package { 'wget':
        ensure => installed,
    }

    exec { "download python":
        command     => "wget http://www.python.org/ftp/python/${version}/${python_source}",
        path        => "/usr/bin",
        creates     => "${cwd}/${$python_source}",
        loglevel    => info,
        require     => Package["wget"],
        cwd         => $cwd,
        unless      => "which python3.5 2>/dev/null",
    }

    exec { 'decode tar':
        command     => "xz -d Python-${version}.tar.xz",
        path        => "/usr/bin",
        creates     => "${cwd}/Python-${version}.tar",
        cwd         => $cwd,
        refreshonly => true,
    }

    exec { 'extract tar':
        command     => "tar -xvf Python-${version}.tar",
        path        => "/bin",
        creates     => "${cwd}/Python-${version}",
        cwd         => $cwd,
        refreshonly => true,
    }

    exec { 'configure':
        command     => "/bin/sh ./configure",
        path        => "/bin:/usr/bin",
        cwd         => "${cwd}/Python-${version}",
        refreshonly => true,
    }

    exec { 'make install':
        command     => "make && make altinstall",
        path        => "/usr/bin:/usr/local:/bin",
        cwd         => "${cwd}/Python-${version}",
        refreshonly => true,
    }

    Exec["download python"]
    ~> Exec["decode tar"]
    ~> Exec["extract tar"]
    ~> Exec["configure"]
    ~> Exec["make install"]
}
