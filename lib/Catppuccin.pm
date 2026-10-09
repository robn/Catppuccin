package Catppuccin;

# ABSTRACT: 😸 Soothing pastel theme for the high-spirited!

use warnings;
use strict;

use Catppuccin::Data;

BEGIN {
  my @flavors;

  for my $flavor (Catppuccin::Data->flavors) {
    push @flavors, $flavor->id;
    no strict 'refs';
    *{'Catppuccin::'.$flavor->id} = sub {
      bless \do { $flavor }, 'Catppuccin::Flavor';
    }
  }

  sub flavors { @flavors };
}

package Catppuccin::Flavor;

sub hex {
  bless [${shift @_}, 'hex'], 'Catppuccin::Palette::Color';
}
sub rgb {
  bless [${shift @_}, 'rgb'], 'Catppuccin::Palette::Color';
}
sub hsl {
  bless [${shift @_}, 'hsl'], 'Catppuccin::Palette::Color';
}
sub oklch {
  bless [${shift @_}, 'oklch'], 'Catppuccin::Palette::Color';
}

sub term_rgb {
  bless [${shift @_}, sub {
    sprintf 'rgb%u%u%u', map { $_ % 6 } shift->rgb
  }], 'Catppuccin::Palette::Color';
}
sub term_truecolor {
  bless [${shift @_}, sub {
    sprintf 'r%ug%ub%u', shift->rgb
  }], 'Catppuccin::Palette::Color';
}

sub term {
  ($ENV{COLORTERM} // '') eq 'truecolor' ?
  shift->term_truecolor : shift->term_rgb
}

package Catppuccin::Palette::Color;

sub AUTOLOAD {
  our $AUTOLOAD;
  my ($color) = $AUTOLOAD =~ m/::([^:]+)$/;
  my ($class, $format) = @{shift @_};
  ref $format ? $format->($class->color->$color) : $class->color->$color->$format;
}

sub id { shift->[0]->id }

sub colors {
  map { $_->id } shift->[0]->colors;
}

sub DESTROY {}

1;
