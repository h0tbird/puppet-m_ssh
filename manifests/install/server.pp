#------------------------------------------------------------------------------
# Class: ssh::install::server
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::install::server inherits ssh {

  if !empty($server_packages) {
    package { $server_packages:
      ensure => $version,
      before => File[$server_configs],
    }
  }
}
