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
#     ensure                  => running,
#     version                 => present,
#     permit_user_environment => true,
#   }
#------------------------------------------------------------------------------
class ssh (

  $ensure                  = undef,
  $version                 = undef,
  $permit_user_environment = undef,
  $use_dns                 = undef,

) {

  # Validate parameters:
  validate_re($ensure, '^running$|^stopped$')
  validate_re($version, '^present$|^latest$')
  validate_bool($permit_user_environment)
  validate_re($use_dns, '^yes$|^no$')

  # Register this module:
  if defined(Class['motd']) { motd::register { $module_name: } }

  # Module contention:
  contain "::${module_name}::params"
  contain "::${module_name}::install"
  contain "::${module_name}::config"
  contain "::${module_name}::service"
}
