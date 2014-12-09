#------------------------------------------------------------------------------
# Class: ssh::params
#
#   This class is part of the ssh module.
#   You should not be calling this class.
#   The delegated class is Class['ssh'].
#
#   Marc Villacorta <marc.villacorta@gmail.com>
#   2011-11-19
#
#------------------------------------------------------------------------------
class ssh::params {

  # Set default location for files and templates:
  $files     = "puppet:///modules/${module_name}/${::operatingsystem}"
  $templates = "${module_name}/${::operatingsystem}"

  # Set OS specifics:
  case $::osfamily {

    'RedHat': {

      $client_packages = ['openssh-clients']
      $client_configs  = ['/etc/ssh/ssh_config']
      $client_services = []

      $server_packages = ['openssh-server']
      $server_configs  = ['/etc/ssh/sshd_config']
      $server_services = ['sshd']
    }

    default: { fail("${module_name}::params ${::osfamily} family is not supported yet.") }
  }

  # Module defaults:
  $ensure = 'running'
  $version = 'present'
  $roles = ['client','server']

  # Client defaults:
  $client_gss_api_authentication = 'yes'
  $client_forward_x11_trusted = 'yes'
  $client_send_env = ['LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES',
  'LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT',
  'LC_IDENTIFICATION LC_ALL LANGUAGE', 'XMODIFIERS']

  # Server defaults:
  $server_accept_env = ['LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES',
  'LC_IDENTIFICATION LC_ALL LANGUAGE',
  'LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT', 'XMODIFIERS']
  $server_authorized_keys_file = '.ssh/authorized_keys'
  $server_challenge_response_authentication = 'no'
  $server_gss_api_authentication = 'yes'
  $server_gss_api_cleanup_credentials = 'yes'
  $server_host_key = ['/etc/ssh/ssh_host_ecdsa_key','/etc/ssh/ssh_host_rsa_key']
  $server_log_level = 'INFO'
  $server_password_authentication = 'yes'
  $server_permit_user_environment = 'no'
  $server_subsystem = 'sftp /usr/libexec/openssh/sftp-server'
  $server_syslog_facility = 'AUTHPRIV'
  $server_use_dns = 'yes'
  $server_use_pam = 'yes'
  $server_use_privilege_separation = 'sandbox'
  $server_x11_forwarding = 'yes'
}
