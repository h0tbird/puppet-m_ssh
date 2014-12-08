#------------------------------------------------------------------------------
# puppet apply --modulepath="$(pwd)/../.." 01_ssh.pp
#------------------------------------------------------------------------------

class { 'ssh':
  ensure                  => stopped,
  version                 => present,
  permit_user_environment => true,
  use_dns                 => 'no',
}
