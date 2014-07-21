#locales

####Table of Contents

1. [Overview - What is the locales module?](#overview)
2. [Module Description - What does the locales module do?](#module-description)
3. [Setup - The basics of getting started with locales](#setup)
    * [What locales affects](#what-locales-affects)
    * [Beginning with locales](#beginning-with-locales)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [License](#license)

##Overview

Configures the system locales.

##Module Description

The `locales` class configures the system locales on Debian/Ubuntu.

##Setup

###What locales affects

* `locales` Debian package.
* `/etc/locale.gen` locales configuration files.

###Beginning with locales

Just include the `locales` class, or optionally pass the
`default_environment_locale` locale name, which defaults to `None`, and the
`locales` list of names and encodings of locales to enable.

    class { locales:
      default_environment_locale => "en_US.UTF-8",
      locales => ["en_US ISO-8859-1",
                  "en_US.UTF-8 UTF-8",
                  "fr_FR ISO-8859-1",
                  "fr_FR.UTF-8 UTF-8",
                  "fr_FR@euro ISO-8859-15"],
    }

##Usage

###Class: `locales`

####Parameters

#####`default_environment_locale`

The name of the default locale set in the environment.  If not specified,
defaults to `None`.  See `/etc/locale.gen` for the list of valid locale
names.

#####`locales`

The array of combinations of locale names and encodings to enable.  See
`/etc/locale.gen` for the list of valid combinations.

##Limitations

This module is compatible only with Debian and Ubuntu.

##Development

Feedback and contributions are appreciated, in the form of issues or
pull requests on [the Github project
page](https://github.com/rlenglet/puppet-locales).

##License

Copyright 2014 Romain Lenglet

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.
