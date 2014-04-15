# Create a new ACL file with some princs.
#
# An example ACL might be as follows:
# deny:princ:baduser@EXAMPLE.ORG
# file:/etc/remctl/acl/admins
# deny:otherbaduser@EXAMPLE.ORG
# princ:service/admin@EXAMPLE.ORG
# service/other@EXAMPLE.ORG
#
#
# With this module, this might look like:
# remctl::server::acl { 'accounts':
#   principals => [
#     {
#       'principal' => 'baduser@EXAMPLE.ORG',
#       'deny'      => true,
#     },
#     {
#       'file'      => '/etc/remctl/acl/admins',
#     },
#     'deny:otherbaduser@EXAMPLE.ORG',
#     {
#       'principal' => 'service/admin@EXAMPLE.ORG',
#     },
#     'service/other@EXAMPLE.ORG',
#   ],
# }
#
# This would create a file at $remctl::server::acldir/accounts with the contents above.
#
# This rather ugly example points out the use of this module: the contents of
# the principals array can be a hash, allowing verbosity, or a string, allowing
# compactness.  Or, I suppose, both, but ew.  See man remctld(8) for proper
# string syntax.
#
# The parameters (and their types) for principal hashes are as follows:
# deny:      Boolean
# file:      String
# gput:      String (see man remctld(8) for more info)
# pcre:      Regex|String (see man remctld(8) for more info)
# principal: String
# regex:     Regex|String (see man remctld(8) for more info)
#
# Note that there are no required parameters, but at least one of the following
# should be declared: file, principal, gput, pcre, regex. Deny is used with an
# existing declaration of one of these types.
define remctl::server::acl (
  $principals
) {
  include remctl::server
  include stdlib

  file { "${remctl::server::acldir}/${title}":
    ensure  => 'file',
    content => template('remctl/acl.erb'),
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    require => File[$remctl::server::acldir],
  }
}
