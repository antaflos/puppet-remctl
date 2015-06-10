class remctl::lib::php5 (
  $package_name   = $remctl::params::php5_package_name,
  $package_ensure = $remctl::params::php5_package_ensure,
) inherits remctl::params {

  validate_string($package_name)

  package { 'php5-remctl':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
