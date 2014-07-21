# == Class: locales
#
# Configures the system locales.
#
# === Parameters
#
# [*default_environment_locale*]
#   The name of the default locale set in the environment.  If not specified,
#   defaults to "None".  See /etc/locale.gen for the list of valid locale
#   names.
#
# [*locales*]
#   The array of combinations of locale names and encodings to enable.  See
#   /etc/locale.gen for the list of valid combinations.
#
# === Examples
#
#  class { locales:
#    default_environment_locale => "en_US.UTF-8",
#    locales => ["en_US ISO-8859-1",
#                "en_US.UTF-8 UTF-8",
#                "fr_FR ISO-8859-1",
#                "fr_FR.UTF-8 UTF-8",
#                "fr_FR@euro ISO-8859-15"],
#  }
#
# == Authors
#
# Romain Lenglet <romain.lenglet@berabera.info>
#
# === Copyright
#
# Copyright 2014 Romain Lenglet
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

class locales (
  $default_environment_locale="None",
  $locales=["en_US.UTF-8 UTF-8"]) {

  debconf_package { locales:
    ensure => present,
    content => template("${module_name}/locales.debconf.erb"),
  }

  # locales' debconf is overriden by /etc/locale.gen, but that file is
  # also modified by dpkg-reconfigure locales.  So manage another,
  # similar file.
  file { "/etc/locale.gen.puppet":
    content => template("${module_name}/locale.gen.erb"),
    owner => root,
    group => root,
    mode => "0644",
  }

  exec { "/bin/cat </etc/locale.gen.puppet >/etc/locale.gen":
    require => File["/etc/locale.gen.puppet"],
    subscribe => File["/etc/locale.gen.puppet"],
    refreshonly => true,
    before => Exec["dpkg-reconfigure locales"],
    notify => Exec["dpkg-reconfigure locales"],
    user => root,
    group => root,
  }
}
