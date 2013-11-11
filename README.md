# mopx::pbpaccessor

Mopish stuff

# SYNOPSIS

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

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
