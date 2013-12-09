#------------------------------------------------------------------------------
# Class: ssh::config
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::config {

    # Collect variables:
    $templates               = getvar("${module_name}::params::templates")
    $configs                 = getvar("${module_name}::params::configs")
    $permit_user_environment = getvar("${module_name}::permit_user_environment")
    $use_dns                 = getvar("${module_name}::use_dns")

    # Install the configuration files:
    file { $configs[0]:
        ensure  => present,
        content => template("${templates}/sshd_config.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
    }
}
