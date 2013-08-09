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
#   title: [ keyowner/user ]
#   key:   [ string ]
#
# Actions:
#
#   Given 'keyowner/user', it will append 'key' to ~/.ssh/authorized_keys
#   of 'user'. In the sample below, the key owned by 'marc.villacorta' will be
#   appended to the root's authorized_keys file. SSH_USER will be set to the
#   owners ID 'marc.villacorta'.
#
# Sample Usage:
#
#   ssh::key { 'marc.villacorta/root':
#       key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQD4F..',
#   }
#
#------------------------------------------------------------------------------

define ssh::key ( $key = undef ) {

    $user = split($name, '/')

    ssh_authorized_key { $name:
        ensure  => present,
        key     => $key,
        type    => 'ssh-rsa',
        options => ["environment=\"SSH_USER=${user[0]}\""],
        user    => $user[1],
    }
}
