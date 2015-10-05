class python::install () {

    $version = "3.3.3"
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
        refreshonly => true,
    }

    exec { 'decode python tar':
        command      => "xz -d Python-${version}.tar.xz",
        path        => "/usr/bin",
        creates     => "${cwd}/Python-${version}.tar",
        cwd         => $cwd,
        refreshonly => true,
    }

    exec { 'extract python tar':
        command      => "tar -xvf Python-${version}.tar",
        path        => "/bin",
        creates     => "${cwd}/Python-${version}",
        cwd         => $cwd,
        refreshonly => true,
    }

    Exec["download python"]
    ~> Exec["decode python tar"]
    ~> Exec["extract python tar"]
}
