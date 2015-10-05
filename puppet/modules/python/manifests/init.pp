class python () {
    include python::yum
    include python::install

    package { 'python-setuptools':
      ensure => installed,
    }
}
