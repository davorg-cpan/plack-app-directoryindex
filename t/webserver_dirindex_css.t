use strict;
use warnings;
use Test::More;
use WebServer::DirIndex::CSS qw[standard_css pretty_css];

my $std = standard_css();
ok defined $std, 'standard_css returns a value';
like $std, qr/table/, 'standard_css contains table rule';
like $std, qr/\.name/, 'standard_css contains .name rule';
like $std, qr/\.size/, 'standard_css contains .size rule';

my $pretty = pretty_css();
ok defined $pretty, 'pretty_css returns a value';
like $pretty, qr/body/, 'pretty_css contains body rule';
like $pretty, qr/table/, 'pretty_css contains table rule';
like $pretty, qr/a:link/, 'pretty_css contains a:link rule';

isnt $std, $pretty, 'standard_css and pretty_css return different values';

done_testing;
