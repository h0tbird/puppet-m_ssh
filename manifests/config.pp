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
    $templates = getvar("${module_name}::params::templates")
    $configs   = getvar("${module_name}::params::configs")
    $root_keys = getvar("${module_name}::root_keys")

    # Install the configuration files:
    file { $configs[0]:
        ensure  => present,
        content => template("${templates}/sshd_config.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
    }

    # Root ssh keys:
    $real_keys = concat_titles($root_keys, append, "/root")
    create_resources(ssh::key::x, $real_keys)
}
