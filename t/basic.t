use strict;
use warnings;
use Test::More tests => 12;
use mop;
use mopx::pbpaccessor;

class Foo {
  has $!bar is ro;
  has $!baz is rw;
}

my $foo = Foo->new( bar => 'xyz', baz => 'abc' );

isa_ok $foo, 'Foo';

ok $foo->can('get_bar'), 'can get_bar';
ok !$foo->can('set_bar'), 'not can set_bar';
ok $foo->can('get_baz'), 'can get_baz';
ok $foo->can('set_baz'), 'can set_baz';

is $foo->get_bar, 'xyz', 'foo.get_bar = xyz';
is $foo->get_baz, 'abc', 'foo.get_baz = abc';

isa_ok $foo->set_baz('ghi'), 'Foo';

is $foo->get_bar, 'xyz', 'foo.get_bar = xyz';
is $foo->get_baz, 'ghi', 'foo.get_baz = ghi';

ok !$foo->can('bar'), 'not can bar';
ok !$foo->can('baz'), 'not can baz';
