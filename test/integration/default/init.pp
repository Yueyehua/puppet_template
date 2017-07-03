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

exec { "apt-update":
        command => "/usr/bin/apt-get update",
    }
Exec["apt-update"] -> Package <| |>

class { 'template':
  package_name => 'ntp',
  service_name => 'ntp',
  config_dir   => '/tmp',
  config_file  => 'config',
  sysconfig    => '/tmp/sysconfig',
  dependencies => [
    'cowsay',
    'toilet',
    'fortune-mod'
  ]
}
