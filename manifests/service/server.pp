#------------------------------------------------------------------------------
# Class: ssh::service::server
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::service::server inherits ssh {

  if !empty($server_services) {
    service { $server_services:
      ensure  => $ensure,
      enable  => $ensure ? {
        'running' => true,
        'stopped' => false,
      }
    }
  }
}
