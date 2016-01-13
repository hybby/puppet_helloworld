# == Class: helloworld
#
# A class for testing out Puppet syntax

class helloworld (
    $garply = "waldo",
    $fred   = undef,
    $xyzzy  = undef,
){
    $foo = $::foo
    $baz = hiera('baz')

    notify{"hello world!": } ->
    notify{"custom fact lookup for 'foo' returns '${foo}'": } ->
    notify{"hiera lookup for 'baz' returns '${baz}'": } ->
    notify{"parameter 'garply' passed from module returns '${garply}'": } ->
    notify{"parameter 'fred' passed from profile returns '${fred}'": } ->
    notify{"hiera lookup parameter 'xyzzy' passed from profile returns '${xyzzy}'": }
}
