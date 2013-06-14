#------------------------------------------------------------------------------
# Define: ssh::key
#
#   This define is part of the ssh module.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#   Tested platforms:
#       - CentOS 6
#
# Parameters:
#
#   title: [ string ]
#   users: [ array of strings ]
#
# Actions:
#
#   Given a user name (title) and a list of user names (users), it will append
#   the user's ssh public key to the ~/.ssh/authorized_keys file of each user.
#   The sample below will allow anyone using the key 'marc.villacorta' to
#   access the system as user 'marc.villacorta', 'deborah.aguilar' or 'root'.
#
# Sample Usage:
#
#   ssh::key { 'marc.villacorta':
#       users => ['deborah.aguilar','root']
#   }
#
#------------------------------------------------------------------------------
define ssh::key (

    $key   = undef,
    $users = '',

){

    $usrs = regsubst(split(inline_template("<%= name + ',' + users %>"),','), '(^.*)', "${name}/\\1")
    ssh::key::x { $usrs: key => $key }
}

define ssh::key::x ( $key = undef ) {

    $user = split($name, '/')

    ssh_authorized_key { $name:
        ensure  => present,
        key     => $key,
        type    => 'ssh-rsa',
        options => ["environment=\"SSH_USER=${user[0]}\""],
        user    => $user[1],
    }
}
