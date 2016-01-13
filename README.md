# Overview

The `puppet_helloworld` project is a simple way to test out Puppet code.

Y'know, if you don't have a master handy and you wanna see how `split()` behaves, or something.

Useful for testing out [Roles and Profiles](https://github.com/hunner/roles_and_profiles/blob/master/Roles_and_profiles.pdf), too.

# Getting started

## OSX

First, install [Vagrant](http://www.vagrantup.com).

Then, open a terminal.

```bash

    # create an area to work in
    cd ~
    mkdir -p vagrant/puppet_helloworld && cd $_

    # clone this repository
    git clone https://github.com/hybby/puppet_helloworld .

    # install a vagrant box that has Ubuntu 14 and Puppet 3.6.1
    vagrant box add nercceh/ubuntu14.04

    # start the box
    vagrant up

```

You should see the following:

```
==> default: Running provisioner: puppet...
==> default: Running Puppet with init.pp...
==> default: stdin: is not a tty
==> default: Warning: Setting templatedir is deprecated. See http://links.puppetlabs.com/env-settings-deprecations
==> default:    (at /usr/lib/ruby/vendor_ruby/puppet/settings.rb:1139:in `issue_deprecation_warning')
==> default: Notice: Compiled catalog for vagrant.home in environment production in 0.05 seconds
==> default: Info: Applying configuration version '1452715611'
==> default: Notice: hello world!
==> default: Notice: /Stage[main]/Helloworld/Notify[hello world!]/message: defined 'message' as 'hello world!'
==> default: Notice: custom fact lookup for 'foo' returns 'bar'
==> default: Notice: /Stage[main]/Helloworld/Notify[custom fact lookup for 'foo' returns 'bar']/message: defined 'message' as 'custom fact lookup for 'foo' returns 'bar''
==> default: Notice: hiera lookup for 'baz' returns 'qux'
==> default: Notice: /Stage[main]/Helloworld/Notify[hiera lookup for 'baz' returns 'qux']/message: defined 'message' as 'hiera lookup for 'baz' returns 'qux''
==> default: Notice: parameter 'garply' passed from module returns 'waldo'
==> default: Notice: /Stage[main]/Helloworld/Notify[parameter 'garply' passed from module returns 'waldo']/message: defined 'message' as 'parameter 'garply' passed from module returns 'waldo''
==> default: Notice: parameter 'fred' passed from profile returns 'plugh'
==> default: Notice: /Stage[main]/Helloworld/Notify[parameter 'fred' passed from profile returns 'plugh']/message: defined 'message' as 'parameter 'fred' passed from profile returns 'plugh''
==> default: Notice: hiera lookup parameter 'xyzzy' passed from profile returns 'thud'
==> default: Notice: /Stage[main]/Helloworld/Notify[hiera lookup parameter 'xyzzy' passed from profile returns 'thud']/message: defined 'message' as 'hiera lookup parameter 'xyzzy' passed from profile returns 'thud''
==> default: Notice: Finished catalog run in 0.02 seconds
```

For subsequent runs and testing, you can use `vagrant provision` without having to rebuild the box.


## What does it all mean?

The default notifies test a few things.

  - `foo` tests custom facts and should return `bar`
  - `baz` tests Hiera lookups from within modules and should return `qux`
  - `garply` tests parameters that are set from within modules and should return `waldo`
  - `fred` tests parameters that are set from within profiles and should return `plugh`
  - `xyzzy` tests Hiera lookups from within profiles and should return `thud`

With these, you can test how different pieces of data are passed into modules.  

This is particularly useful if you want to test [Roles and Profiles](https://github.com/hunner/roles_and_profiles/blob/master/Roles_and_profiles.pdf).


## What if I just want to test out arbitrary code, with no fanciness?
    
Just clear out the `modules/helloworld/manifests/init.pp` file with the following:
    
```bash
    sed -iE "s/    .*//g" modules/helloworld/manifests/init.pp
```
    
This will leave you with a nice blank module to pop your code into, like so:
    
```puppet
    # == Class: helloworld
    #
    # A class for testing out Puppet syntax
    
    class helloworld (
    
    ){
        # testing split
        $ip = '123.123.123.123'
        $octets = split($ip, '[.]')
    
        notify{"octets look like: ${octets}": }
    }
```

You then need to remove data passed into the class from `modules/profiles/manifests/helloworld.pp`.  (untested as of yet)

To do this, comment out the `class` definition...

```puppet
    # class { '::helloworld':
    #    fred  => "plugh",
    #    xyzzy => $xyzzy,
    # }
```

And uncomment the `include`.

```
    include ::helloworld
```

Then you're a `vagrant provision` away from another test.
