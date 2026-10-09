# NAME

Catppuccin - 😸 Soothing pastel theme for the high-spirited!

# SYNOPSIS

    my $palette = Catppuccin->latte->hex;
    say $palette->red; # output: #d20f39

# NOTE

This module is experimental. I'm still working out what the API should be based
on my own use, so there's not yet much here and things may change. If you're
thinking about using this, I'd like to hear from you!

# DESCRIPTION

[Catppucin](https://catppuccin.com/) is a set of pastel color palettes. This
module makes them easy to use in your Perl programs.

## Flavors

To start, you should get a handle on the Catppucin "flavor" you want to use:

    my $latte = Catppuccin->latte;
    my $frappe = Catppuccin->frappe;
    my $macchiato = Catppuccin->macchiato;
    my $mocha = Catppuccin->mocha;

All flavors have the same interface. It's just the actual color data that will
be different.

Use `flavors` to get the list of available flavors.

    my @flavors = Catppuccin->flavors;
    say "@flavors"; # output: latte frappe macchiato mocha

## Palettes

A palette is the set of colors within the flavor, prepared for the particular
color format you want. Note that this is inverted from most Catppuccin language
libraries, which typically put the color first, then the format. This felt
nicer to use. Feedback welcome!

The four standard Catppuccin color formats are available:

    my $hex = $latte->hex;
    my $rgb = $latte->rgb;
    my $hsl = $latte->hsl;
    my $oklch = $latte->oklch;

Additionally, two palettes for RGB and truecolor terminals are available. These
convert colors to a format suitable for use with `Term::ANSIColor`:

    my $term_rgb = $latte->term_rgb;
    my $term_truecolor = $latte->term_truecolor;

    my $term = $latte->term; # selects term_rgb or term_truecolor based
                             # on the value of $ENV{COLORTERM}

## Colors

Once you have a palette, you can call a Catppuccin color id on it as a method
name to get that color value, in the format described by the palette:

    say $latte->hex->rosewater;       # output: #dc8a78
    printf "%d,%d,%d\n",
      $latte->rgb->flamingo;          # output: 220 138 120
    printf "%.02f,%.02f,%.02f\n",
      $latte->hsl->pink;              # output: 316.03,0.73,0.69
    printf "%.02f,%.02f,%.02f\n",
      $latte->oklch->mauve;           # output: 0.55,0.25,297.02
    say $latte->term_rgb->red;        # output: rgb033
    say $latte->term_truecolor->red;  # output: r210g15b57

Use `colors` to get the list of available colors:

    my @colors = $latte->colors;
    say "@colors"; # output: rosewater flamingo pink mauve red maroon ...

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/robn/Catppuccin/issues](https://github.com/robn/Catppuccin/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/robn/Catppuccin](https://github.com/robn/Catppuccin)

    git clone https://github.com/robn/Catppuccin.git

# AUTHORS

Rob Norris <robn@despairlabs.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2026 by Rob Norris <robn@despairlabs.com>

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
