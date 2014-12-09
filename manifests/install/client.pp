#------------------------------------------------------------------------------
# Class: ssh::install::client
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::install::client inherits ssh {

  if !empty($client_packages) {
    package { $client_packages:
      ensure => $version,
      before => File[$client_configs],
    }
  }
}
