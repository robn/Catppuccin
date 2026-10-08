#!perl

use warnings;
use strict;

use Test::More;

# basic data module lookup & traversal, mostly making sure whatever we
# generated isn't totally wrong
#
require_ok('Catppuccin::Data');

is(Catppuccin::Data->version, '1.8.0');

my $latte = Catppuccin::Data->latte;
is($latte->id, 'latte');
is($latte->name, 'Latte');

my $colors = $latte->colors;
is($colors->crust->id, 'crust');
is($colors->lavender->name, 'Lavender');
is($colors->maroon->hex, '#e64553');
is_deeply([$colors->peach->rgb], [254,100,11]);
is(scalar [$colors->rosewater->hsl]->@*, 3);
is(scalar [$colors->sky->oklch]->@*, 3);

my $ansi = $latte->ansi;
is($ansi->blue->id, 'blue');
is($ansi->cyan->name, 'Cyan');
is($ansi->green->normal->name, 'Green');
is($ansi->green->bright->name, 'Bright Green');
is($ansi->yellow->bright->hex, '#eea02d');
is_deeply([$ansi->magenta->normal->rgb], [234,118,203]);

done_testing;
