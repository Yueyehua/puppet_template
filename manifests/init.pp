# == Class: puppet_template
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
#  class { 'puppet_template':
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
class puppet_template (
  $ensure_package = $puppet_template::params::ensure_package,
  $ensure_service = $puppet_template::params::ensure_service,
  $enable         = $puppet_template::params::enable,
  $package_name   = $puppet_template::params::package_name,
  $service_name   = $puppet_template::params::service_name,
  $user_name      = $puppet_template::params::user_name,
  $group_name     = $puppet_template::params::group_name,
  $config_dir     = $puppet_template::params::config_dir,
  $config_file    = $puppet_template::params::config_file,
  $sysconfig      = $puppet_template::params::sysconfig,
  $logrotate      = $puppet_template::params::logrotate,
  $options        = $puppet_template::params::options,
  $dependencies   = $puppet_template::params::dependencies
) inherits puppet_template::params {

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
    content => template('puppet_template/template.conf.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }

  file { $sysconfig:
    ensure  => $ensure_package,
    path    => $sysconfig,
    owner   => $user_name,
    group   => $group_name,
    mode    => '0644',
    content => template("puppet_template/sysconfig.${::operatingsystem}.erb"),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
