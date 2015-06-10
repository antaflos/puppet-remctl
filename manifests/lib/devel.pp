class remctl::lib::devel (
  $package_name   = $remctl::params::devel_package_name,
  $package_ensure = $remctl::params::devel_package_ensure,
) inherits remctl::params {

  validate_string($package_name)

  package { 'libremctl-dev':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
