#!/usr/bin/perl
use warnings; use strict; use open 'utf8';
binmode STDERR, ':utf8';
use lib "$ENV{'ORACC'}/lib";
use ORACC::L2P0::L2Super;

#
# Take an external glossary and import it into the minimal form 
# used for alignment.
#

my %data = ORACC::L2P0::L2Super::init();
my $fh = $data{'input_fh'}; 
my $outfh = $data{'output_fh'}; select $outfh unless $data{'output'} eq '-';
print "\@project $data{'project'}\n\@lang $data{'lang'}\n\@name $data{'project'} $data{'lang'}\n\n";
while (<$fh>) {
    print if /^\@(?:entry|parts|bases|form|sense|end)/;
    print "\n" if /^\@end/
}
close($fh);
close($outfh);

warn "super induct: inducted glossary $data{'input'} as $data{'output'}\n";

1;
