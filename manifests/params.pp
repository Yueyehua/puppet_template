# == Class: puppet_template::params
#
# This is a container class holding default parameters for template module.
#
class puppet_template::params {
  # Defaults values.
  $ensure_package = 'present'
  $ensure_service = 'running'
  $enable  = true

  # Create variables depending on OS.
  case $::operatingsystem {
    /(Debian|Ubuntu)/          : {
      $package_name = 'template'
      $service_name = 'template'
      $user_name    = 'root'
      $group_name   = 'root'
      $config_dir   = '/etc/template'
      $config_file  = 'template.conf'
      $sysconfig    = '/etc/default/template'
      $logrotate    = '/etc/logrotate.d/template'
      $options      = '-o template'
      $dependencies = []
    }
    /(CentOS|Fedora|RedHat)/   : {
      $package_name = 'template'
      $service_name = 'template'
      $user_name    = 'root'
      $group_name   = 'root'
      $config_dir   = '/etc/template'
      $config_file  = 'template.conf'
      $sysconfig    = '/etc/sysconfig/template'
      $logrotate    = '/etc/logrotate.d/template'
      $options      = '-o template'
      $dependencies = []
    }
    /(FreeBSD|NetBSD|OpenBSD)/ : {
      $package_name = 'template'
      $service_name = 'template'
      $user_name    = 'root'
      $group_name   = 'wheel'
      $config_dir   = '/usr/local/etc/template'
      $config_file  = 'template.conf'
      $sysconfig    = undef
      $logrotate    = undef
      $options      = undef
      $dependencies = []
    }
    default                    : {
      fail("Module template is not supported on ${::operatingsystem}")
    }
  }
}
# EOF
