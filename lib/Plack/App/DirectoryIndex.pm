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
