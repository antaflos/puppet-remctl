# == Class: remctl::client
#
# Installs the remctl client program. On RedHat this is in the same package as
# the remctl server program, while on Debian it has its own package. 
#
# === Parameters
#
# [*package_name*]
#   Specifies the package name of the remctl client package. Defaults to
#   'remctl' on RedHat (same as the server package) and 'remctl-client' on
#   Debian.
#
# [*package_ensure*]
#   Specifies the package version to install. Defaults to 'latest'.
#
class remctl::client (
  $package_name   = $remctl::params::client_package_name,
  $package_ensure = $remctl::params::client_package_ensure,
) inherits remctl::params {

  # On RedHat the package 'remctl' contains both client and server parts, so on
  # a node that includes both remctl::client and remctl::server we guard
  # against duplicate resource declarations by checking if the package resource
  # has already been declared elsewhere, probably in the remctl::server class.
  if ! defined(Package[$package_name]) {

    package { $package_name:
      ensure => $package_ensure,
    }
  }
}
