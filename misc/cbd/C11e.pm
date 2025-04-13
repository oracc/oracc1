package ORACC::CBD::C11e;
require Exporter;
@ISA=qw/Exporter/;
@EXPORT = qw/c11e/;

use warnings; use strict; use open 'utf8'; use utf8;
binmode STDIN, ':utf8'; binmode STDOUT, ':utf8'; binmode STDERR, ':utf8';

sub c11e {
    my($args,@cbd) = @_;
    my @c = @cbd;
    for (my $i = 0; $i <= $#c; ++$i) {
	if ($c[$i] =~ /^-\@entry/) {
	    my $entry = $i;
	    until ($c[$i] =~ /^\@end/ || $i > $#c) {
		$c[$i++] = "\000";
	    }
	    if ($i > $#c) {
		pp_warn("never found \@end for \@entry starting at line $entry");
	    }
	} elsif ($c[$i] =~ /^[>\+]/) {
	    $c[$i] = "\000";
	} elsif ($c[$i] =~ /^\@bases/) {
	    $c[$i] =~ s/(\s)[-+]/$1/g;
	    $c[$i] =~ s#=[0-9]##g;
	    $c[$i] =~ s/>\S+?(;|$)/$1/g;
	} else {
	    $c[$i] =~ s#^=(?:\d?/)?##;
	    $c[$i] =~ s#^-##;
	}
	$c[$i] =~ s/^(\@[a-z]+)!/$1/;
	$c[$i] =~ s/\s+/ /;
	$c[$i] =~ s/\s*$//;
    }
    @c;
}

1;
