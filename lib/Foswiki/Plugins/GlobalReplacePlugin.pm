# Plugin for Foswiki - The Free and Open Source Wiki, http://foswiki.org/
#
# Copyright (C) 2004-2006 Peter Thoeny, peter@thoeny.org
# Copyright (C) 2004-2025 Foswiki Contributors
#
# For licensing info read LICENSE file in the distribution root.
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details, published at
# http://www.gnu.org/copyleft/gpl.html
#
# As per the GPL, removal of this notice is prohibited.

package Foswiki::Plugins::GlobalReplacePlugin;

use strict;
use warnings;

our $VERSION = '2.10';
our $RELEASE = '%$RELEASE%';
our $SHORTDESCRIPTION = "Global search and replace functionality across all topics in a web";
our $NO_PREFS_IN_TOPIC = 1;
our $core;

sub initPlugin {
  my ($topic, $web, $user, $installWeb) = @_;

  Foswiki::Func::registerTagHandler(
    'GLOBALREPLACE',
    sub {
      getCore(shift)->handleGlobalReplace(@_);
    }
  );

  return 1;
}

sub getCore {
  my $session = shift;

  unless ($core) {
    require Foswiki::Plugins::GlobalReplacePlugin::Core;
    $core = Foswiki::Plugins::GlobalReplacePlugin::Core->new($session);
  }

  return $core;
}

sub finishPlugin {
  $core->finish() if $core;
  undef $core;
}

1;
