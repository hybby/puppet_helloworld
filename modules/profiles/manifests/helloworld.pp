# == Class: profiles::helloworld
#
# A profile which includes the helloworld module.

class profiles::helloworld (
    $xyzzy = hiera('xyzzy')
) {

    # Use below if you want to pass data into your module.
    class { '::helloworld':
        fred  => "plugh",
        xyzzy => $xyzzy,
    }

    # Use below if you don't want to pass data into your module.
    # include ::helloworld
}
