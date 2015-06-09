# Create a new command file with a command listing
#
# An example command listing for remctl might be as follows:
# accounts create /usr/local/bin/doaccount  /etc/acl/group1 /etc/acl/group3
# accounts delete /usr/local/bin/doaccount  /etc/acl/group3
# accounts view   /usr/local/bin/doaccount  ANYUSER
# accounts passwd /usr/local/bin/dopasswd   logmask=3 /etc/acl/group1
# printing ALL    /usr/bin/printthing       /etc/acl/group2
# other    do     /usr/local/bin/otherthing /etc/acl/group1
#
#
# With this module, this might would look like:
# remctl::server::command { 'accounts':
#   executable_path => '/usr/local/bin',
#   commands        => [
#     {
#        'subcommand' => 'create',
#        'executable' => 'doaccount',
#        'acl'        => ['/etc/acl/group1','/etc/acl/group3'],
#     },
#     {
#        'subcommand' => 'delete',
#        'executable' => 'doaccount',
#        'acl'        => '/etc/acl/group3',
#     },
#     {
#        'subcommand' => 'view',
#        'executable' => 'doaccount',
#        'acl'        => 'ANYUSER',
#     },
#     {
#        'subcommand' => 'password',
#        'executable' => 'dopasswd',
#        'options'    => { 'logmask' => '3', },
#        'acl'        => '/etc/acl/group1',
#     },
#     {
#        'command'    => 'printing',
#        'subcommand' => 'ALL',
#        'executable' => '/usr/bin/printthing',
#        'acl'        => '/etc/acl/group2',
#     },
#     'other do /usr/local/bin/otherthing /etc/acl/group1'
#   ]
# }
#
# This would create a file at $remctl::confdir/accounts with the contents above.
#
# This rather ugly example points out that the contents of the commands array
# can be hashes, allowing verbosity, or strings, allowing compactness. Note
# that, for objects, 'command' defaults to the resource title.
#
# The valid parameters (and their types) for the command hashes are as follows:
# command:    String (required)
# subcommand: String (required)
# executable: String (required)
# options:    (Hash of option=>value where value is String) _or_ String (optional, see note)
# acl:        String _or_ Array of String (required)
#
# For remctl's list of option=value pairs, see man remctld(8). Also see the man
# for subcommand and acl options for cases like "EMPTY" or "ALL" or "ANYUSER",
# as in some of the declarations above.
#
# Note that executable_path is not a search path; it must be a single directory.
# See man remctld(8) for proper string syntax.
define remctl::server::command (
  $commands,
  $executable_path = false,
) {

  include remctl::server
  include stdlib

  $_title = $title

  file { "${remctl::server::confdir}/${title}":
    ensure  => 'file',
    content => template('remctl/command.erb'),
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    require => File[[$remctl::server::confdir, $remctl::server::conffile]],
  }
}
