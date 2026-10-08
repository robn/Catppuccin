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

my $color = $latte->color;
is($color->crust->id, 'crust');
is($color->lavender->name, 'Lavender');
is($color->maroon->hex, '#e64553');
is_deeply([$color->peach->rgb], [254,100,11]);
is(scalar [$color->rosewater->hsl]->@*, 3);
is(scalar [$color->sky->oklch]->@*, 3);

my $ansi = $latte->ansi;
is($ansi->blue->id, 'blue');
is($ansi->cyan->name, 'Cyan');
is($ansi->green->normal->name, 'Green');
is($ansi->green->bright->name, 'Bright Green');
is($ansi->yellow->bright->hex, '#eea02d');
is_deeply([$ansi->magenta->normal->rgb], [234,118,203]);

my ($flavor) = Catppuccin::Data->flavors;
is($flavor->id, do { my $id = $flavor->id; Catppuccin::Data->$id }->id);

my ($color) = $flavor->colors;
is($color->id, do { my $id = $color->id; $flavor->color->$id }->id);

my ($ansi_color) = $flavor->ansi_colors;
is($ansi_color->id, do { my $id = $ansi_color->id; $flavor->ansi->$id }->id);

done_testing;
