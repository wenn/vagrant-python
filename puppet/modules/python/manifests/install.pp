class python::install () {

    exec { 'download python':
        command      => 'wget http://www.python.org/ftp/python/3.3.3/Python-3.3.3.tar.xz',
        path        => '/usr/bin',
        #refreshonly => true,
    }
}
