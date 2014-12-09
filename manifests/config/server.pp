#------------------------------------------------------------------------------
# Class: ssh::config::server
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::config::server inherits ssh {

  $server_configs.each |$path| {
    $file = $path.split('/')[-1]

    file { $path:
      ensure  => present,
      content => template("${templates}/${file}.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      notify  => Service[$server_services],
    }
  }
}
