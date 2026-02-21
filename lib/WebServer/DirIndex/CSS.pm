package WebServer::DirIndex::CSS;

use strict;
use warnings;

use Exporter qw[import];

our @EXPORT_OK = qw[standard_css pretty_css];

our $VERSION = '0.0.1';

sub standard_css {
  return <<CSS;
table {
  width: 100%;
}
.name {
  text-align: left;
}
.size, .mtime {
  text-align: right;
}
.type {
  width: 11em;
}
.mtime {
  width: 15em;
}
CSS
}

sub pretty_css {
  return <<CSS;
body {
  color: #000;
  background-color: #fff; 
  font-family: Calibri, Candara, Segoe, Segoe UI, Helvetica Neue, Helvetica, Optima, Arial, sans-serif;
  font-size: normal 1em sans-serif;
  text-align: center;
  padding: 0;
  margin: 0;
}

h2 {
 font-size: 2.000em;
 font-weight: 700;
}

table {
  width: 90%;
  margin: 3em;
  border: 1px solid #aaa;
  border-collapse: collapse;
  background-color: #eee;
}

thead {
  background-color: #bbb;
  font-weight: 700;
  font-size: 1.300em;
}

td, th {
  padding: 1em;
  text-align: left;
  border-bottom: 1px solid #999999;
  color: #000;
}

tr:nth-child(even) {
  background: #ccc;
}

.size {
  text-align: right;
  padding-right: 1.700em;
}

a:link {
  font-size: 1.200em;
  font-weight: 500;
  color: #000;
  text-decoration: none;
}

a:link:hover {
  text-decoration: underline;
}

a:visited {
  font-size: 1.200em;
  font-weight: 500;
  color: #301934;
  text-decoration: none;
}
CSS
}

1;

__END__

=head1 NAME

WebServer::DirIndex::CSS - CSS stylesheets for directory index pages

=head1 SYNOPSIS

  use WebServer::DirIndex::CSS qw[standard_css pretty_css];

  my $css = standard_css();
  my $css = pretty_css();

=head1 DESCRIPTION

This module provides two CSS stylesheets that can be used to style
directory index pages served by web servers.

=head1 FUNCTIONS

=over 4

=item standard_css

Returns a minimal CSS stylesheet suitable for directory listing pages.

=item pretty_css

Returns an enhanced CSS stylesheet for a more attractive directory listing
appearance.

=back

=head1 AUTHOR

Dave Cross E<lt>dave@perlhacks.comE<gt>

=head1 COPYRIGHT

Copyright (c) 2020 Magnum Solutions Limited. All rights reserved.

=head1 LICENCE

This code is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 SEE ALSO

=over 4

=item L<Plack::App::DirectoryIndex>

=back

=cut
