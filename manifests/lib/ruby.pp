class remctl::lib::ruby (
  $package_name   = $remctl::params::ruby_package_name,
  $package_ensure = $remctl::params::ruby_package_ensure,
) inherits remctl::params {

  validate_re($package_name, 'libremctl-ruby|libremctl-ruby1.8|libremctl-ruby1.9.1|ruby-remctl')

  package { 'ruby-remctl':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
