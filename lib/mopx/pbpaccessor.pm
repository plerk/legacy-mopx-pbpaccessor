package mopx::pbpaccessor;

use strict;
use warnings;
use v5.10;
use base qw( Exporter );

# ABSTRACT: Mopish stuff
# VERSION

=head1 SYNOPSIS

 use mop;
 use mopx::pbpaccessor;
 
 class Foo {
   has $!bar is ro;
   has $!baz is rw;
 }
 
 my $foo = Foo->new;
 my $bar = $foo->get_bar; # value of $!bar
 my $baz = $foo->get_baz; # value of $!baz
 $foo->set_baz('new value'); # set $!baz

=cut

our @EXPORT = qw( ro rw );

sub ro
{
  my($attr) = @_;
  
  die 'ro trait is only valid on attributes'
    unless $attr->isa('mop::attribute');
    
  my $meta = $attr->associated_meta;
  $meta->add_method(
    $meta->method_class->new(
      name => 'get_' . $attr->key_name,
      body => sub {
        $attr->fetch_data_in_slot_for($_[0]);
      }
    )
  );
}

sub rw
{
  my($attr) = @_;
  
  die 'rw trait is only valid on attributes'
    unless $attr->isa('mop::attribute');
  
  ro($attr);
  
  my $meta = $attr->associated_meta;
  $meta->add_method(
    $meta->method_class->new(
      name => 'set_' . $attr->key_name,
      body => sub {
        $attr->store_data_in_slot_for($_[0], $_[1]);
        $_[0];
      },
    )
  );
}

1;
