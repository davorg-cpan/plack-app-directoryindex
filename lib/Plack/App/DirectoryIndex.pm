package Plack::App::DirectoryIndex;

use parent qw[Plack::App::Directory];

use strict;
use warnings;

use Plack::Util::Accessor 'dir_index';

sub serve_path {
  my $self = shift;
  my ($env, $dir) = @_;

  my $dir_index = $self->dir_index // 'index.html';

  if (-d $dir and $dir_index and -f "$dir$dir_index") {
    $dir .= $dir_index;
  }

  return $self->SUPER::serve_path($env, $dir);
}

1;

__END__
 
=head1 NAME
 
Plack::App::DirectoryIndex - Serve static files from document root with an index file.
 
=head1 SYNOPSIS
 
  # app.psgi
  use Plack::App::DirectoryIndex;

  # Use the default index file (index.html)
  my $app = Plack::App::DirectoryIndex->new({
    root => '/path/to/htdocs',
  })->to_app;

  # Use a different index file
  my $app = Plack::App::DirectoryIndex->new({
    root      => '/path/to/htdocs',
    dir_index => 'default.html',
  })->to_app;

  # Don't use an index file (but you're probably better
  # off just using Plack::App::Directory instead)
  my $app = Plack::App::DirectoryIndex->new({
    root      => '/path/to/htdocs',
    dir_index => '',
  })->to_app;
  

=head1 DESCRIPTION
 
This is a static file server PSGI application with directory index like
Apache's mod_autoindex. Unlike L<Plack::App::Directory>, it will also
look for a default index file (e.g. index.html) and serve that instead
of a directory listing.
 
=head1 CONFIGURATION
 
=over 4
 
=item root
 
Document root directory. Defaults to the current directory.

=item dir_index

The name of the directory index file that you want to use. This will
default to using C<index.html>. You can turn it off by setting this
value to an empty string (but if you don't want a default index file,
then you should probably use L<Plack::App::Directory> instead).

=back
 
=head1 AUTHOR
 
Dave Cross E<lt>dave@perlhacks.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2020 Magnum Solutions Limited. All rights reserved.

=head1 LICENCE

This code is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
 
=head1 SEE ALSO
 
L<Plack::App::File>, L<Plack::App::Directory>
 
=cut
