#------------------------------------------------------------------------------
# puppet apply --modulepath="$(pwd)/../.." 00_ssh.pp
#------------------------------------------------------------------------------

class { 'ssh':
  ensure                  => running,
  version                 => present,
  permit_user_environment => true,
  use_dns                 => 'no',
}
