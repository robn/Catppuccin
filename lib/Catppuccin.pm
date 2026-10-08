package Catppuccin;

# ABSTRACT:

use warnings;
use strict;

use Catppuccin::Data;

BEGIN {
  for my $flavor (Catppuccin::Data->flavors) {
    no strict 'refs';
    *{'Catppuccin::'.$flavor->id} = sub {
      bless \do { $flavor }, 'Catppuccin::Flavor';
    }
  }
}

package Catppuccin::Flavor;

sub hex {
  bless [${shift @_}->color, 'hex'], 'Catppuccin::Palette';
}
sub rgb {
  bless [${shift @_}->color, 'rgb'], 'Catppuccin::Palette';
}
sub hsl {
  bless [${shift @_}->color, 'hsl'], 'Catppuccin::Palette';
}
sub oklch {
  bless [${shift @_}->color, 'oklch'], 'Catppuccin::Palette';
}

sub term_rgb {
  bless [${shift @_}->color, sub {
    sprintf 'rgb%u%u%u', map { $_ % 6 } shift->rgb
  }], 'Catppuccin::Palette';
}
sub term_truecolor {
  bless [${shift @_}->color, sub {
    sprintf 'r%ug%ub%u', shift->rgb
  }], 'Catppuccin::Palette';
}

sub term {
  ($ENV{COLORTERM} // '') eq 'truecolor' ?
  shift->term_truecolor : shift->term_rgb
}

package Catppuccin::Palette;

sub AUTOLOAD {
  our $AUTOLOAD;
  my ($color) = $AUTOLOAD =~ m/::([^:]+)$/;
  my ($class, $format) = @{shift @_};
  ref $format ? $format->($class->$color) : $class->$color->$format;
}

sub DESTROY {}

1;
