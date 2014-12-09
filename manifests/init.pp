#------------------------------------------------------------------------------
# Class: ssh
#
#   This module manages the ssh service.
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#   Tested platforms:
#       - CentOS 6 and 7
#
# Actions:
#
#   Installs, configures and manages the ssh service.
#
# Sample Usage:
#
#   class { ssh:
#     ensure  => running,
#     version => latest,
#     roles   => ['client','server'],
#   }
#------------------------------------------------------------------------------
class ssh (

  # Global parameters:
  $ensure  = $::ssh::params::ensure,
  $version = $::ssh::params::version,
  $roles   = $::ssh::params::roles,

  # Client parameters:
  $client_gss_api_authentication = $::ssh::params::client_gss_api_authentication,
  $client_forward_x11_trusted    = $::ssh::params::client_forward_x11_trusted,
  $client_send_env               = $::ssh::params::client_send_env,

  # Server parameters:
  $server_accept_env                        = $::ssh::params::server_accept_env,
  $server_authorized_keys_file              = $::ssh::params::server_authorized_keys_file,
  $server_challenge_response_authentication = $::ssh::params::server_challenge_response_authentication,
  $server_gss_api_authentication            = $::ssh::params::server_gss_api_authentication,
  $server_gss_api_cleanup_credentials       = $::ssh::params::server_gss_api_cleanup_credentials,
  $server_host_key                          = $::ssh::params::server_host_key,
  $server_log_level                         = $::ssh::params::server_log_level,
  $server_password_authentication           = $::ssh::params::server_password_authentication,
  $server_permit_user_environment           = $::ssh::params::server_permit_user_environment,
  $server_subsystem                         = $::ssh::params::server_subsystem,
  $server_syslog_facility                   = $::ssh::params::server_syslog_facility,
  $server_use_dns                           = $::ssh::params::server_use_dns,
  $server_use_pam                           = $::ssh::params::server_use_pam,
  $server_use_privilege_separation          = $::ssh::params::server_use_privilege_separation,
  $server_x11_forwarding                    = $::ssh::params::server_x11_forwarding,

) inherits ssh::params {

  # Validate global parameters:
  validate_re($ensure, '^running$|^stopped$')
  validate_re($version, '^present$|^latest$')
  validate_array($roles)

  # Validate client parameters:
  if 'client' in $roles {
    validate_re($client_gss_api_authentication, '^yes$|^no$')
    validate_re($client_forward_x11_trusted, '^yes$|^no$')
    validate_array($client_send_env)
  }

  # Validate server parameters:
  if 'server' in $roles {
    validate_array($server_accept_env)
    validate_re($server_challenge_response_authentication, '^yes$|^no$')
    validate_re($server_gss_api_authentication, '^yes$|^no$')
    validate_re($server_gss_api_cleanup_credentials, '^yes$|^no$')
    validate_array($server_host_key)
    validate_re($server_password_authentication, '^yes$|^no$')
    validate_re($server_permit_user_environment, '^yes$|^no$')
    validate_re($server_use_dns, '^yes$|^no$')
    validate_re($server_use_pam, '^yes$|^no$')
    validate_re($server_x11_forwarding, '^yes$|^no$')
  }

  # Module contention:
  $roles.each |$role| {
    contain "::${module_name}::install::${role}"
    contain "::${module_name}::config::${role}"
    contain "::${module_name}::service::${role}"
  }
}
