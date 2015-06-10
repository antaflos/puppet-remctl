class remctl::lib::python (
  $package_name   = $remctl::params::python_package_name,
  $package_ensure = $remctl::params::python_package_ensure,
) inherits remctl::params {

  validate_string($package_name)

  package { 'python-remctl':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
