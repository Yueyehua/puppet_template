# puppet-template ![License][license-img]

1. [Overview](#overview)
2. [Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Miscellaneous](#miscellaneous)

## Overview

Description of `template`

[domain.tld](https://www.domain.tld/)

## Description

This module enables you to install, deploy, and configure template.

## Setup

Copy this module in your modules folder without *puppet-* in the name.

## Usage

Use default configuration.

```puppet
class { 'template': }
```

Add your configuration.

```puppet
class { 'template':
  template_var_1 => 'tata',
  template_var_2 => 'titi',
}
```

## Limitations

Limitations of `template`.

## Development

Please read carefully [CONTRIBUTING.md]
(https://git.vpgrp.io/ansible/puppet-rules/raw/master/CONTRIBUTING.md)
before making a merge request.

```
    ╚⊙ ⊙╝
  ╚═(███)═╝
 ╚═(███)═╝
╚═(███)═╝
 ╚═(███)═╝
  ╚═(███)═╝
   ╚═(███)═╝
```

[license-img]: https://img.shields.io/badge/license-Apache-blue.svg
