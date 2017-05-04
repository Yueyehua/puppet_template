# == Class: template
#
# Full description of class puppet_template here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'template':
#  }
#
# === Authors
#
# Richard Delaplace <rdelaplace@yueyehua.net>
#
# === Copyright
#
# Copyright (c) 2017 Richard Delaplace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class template (
  $ensure_package = $template::params::ensure_package,
  $ensure_service = $template::params::ensure_service,
  $enable         = $template::params::enable,
  $package_name   = $template::params::package_name,
  $service_name   = $template::params::service_name,
  $user_name      = $template::params::user_name,
  $group_name     = $template::params::group_name,
  $config_dir     = $template::params::config_dir,
  $config_file    = $template::params::config_file,
  $sysconfig      = $template::params::sysconfig,
  $logrotate      = $template::params::logrotate,
  $options        = $template::params::options,
  $dependencies   = $template::params::dependencies
) inherits template::params {

  # Dependencies management.
  package { $dependencies:
    ensure => $ensure_package
  }

  # Package management.
  package { $package_name:
      ensure => $ensure_package
  }

  # Service management.
  service { $service_name:
    ensure     => $ensure_service,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package[$package_name]
  }

  # Files management.
  file { "${config_dir}/${config_file}":
    ensure  => $ensure_package,
    path    => "${config_dir}/${config_file}",
    owner   => $user_name,
    group   => $group_name,
    mode    => '0700',
    content => template('template/template.conf.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  file { $sysconfig:
    ensure  => $ensure_package,
    path    => $sysconfig,
    owner   => $user_name,
    group   => $group_name,
    mode    => '0644',
    content => template("template/sysconfig.${::operatingsystem}.erb"),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
