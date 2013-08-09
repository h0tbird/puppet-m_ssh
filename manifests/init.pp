#------------------------------------------------------------------------------
# Class: ssh
#
#   This module manages the ssh service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#   Tested platforms:
#       - CentOS 6
#
# Actions:
#
#   Installs, configures and manages the ssh service.
#
# Sample Usage:
#
#   class {
#       ensure                  => running,
#       version                 => present,
#       permit_user_environment => true,
#   }
#------------------------------------------------------------------------------
class ssh (

    $ensure                  = undef,
    $version                 = undef,
    $permit_user_environment = undef,

) {

    # Validate parameters:
    validate_re($ensure, '^running$|^stopped$')
    validate_re($version, '^present$|^latest$')
    validate_bool($permit_user_environment)

    # Register this module:
    if defined(Class['motd']) { motd::register { $module_name: } }

    # Set the requirements:
    anchor { "${module_name}::begin":   } ->
    class  { "${module_name}::params":  } ->
    class  { "${module_name}::install": } ->
    class  { "${module_name}::config":  } ~>
    class  { "${module_name}::service": } ->
    anchor { "${module_name}::end":     }
}
