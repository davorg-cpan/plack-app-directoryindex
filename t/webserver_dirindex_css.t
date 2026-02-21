use strict;
use warnings;
use Test::More;
use WebServer::DirIndex::CSS qw[css];

my $std = css();
ok defined $std, 'css() returns a value';
like $std, qr/table/, 'css() contains table rule';
like $std, qr/\.name/, 'css() contains .name rule';
like $std, qr/\.size/, 'css() contains .size rule';

my $pretty = css(1);
ok defined $pretty, 'css(1) returns a value';
like $pretty, qr/body/, 'css(1) contains body rule';
like $pretty, qr/table/, 'css(1) contains table rule';
like $pretty, qr/a:link/, 'css(1) contains a:link rule';

isnt $std, $pretty, 'css() and css(1) return different values';

done_testing;
