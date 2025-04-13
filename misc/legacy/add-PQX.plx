#!/usr/bin/perl
use warnings; use strict; use open 'utf8';
use Getopt::Long;

# Replace P or X numbers in legacy atf files, optionally using a table

binmode STDIN, ':utf8'; binmode STDOUT, ':utf8';

my $all = 0;
my $dumped = 0;
my $input = '';
my $output = 'PQX.out';
my $P = '';
my $project = 'cdli';
my $raw = '';
my $tab = '';
my %tab = ();
my $thisX = '';
my $X = -1;
my $verbose = 0;

GetOptions(
    'all'=>\$all,
    'input:s'=>\$input,
    'output:s'=>\$output,
    'project:s'=>\$project,
    'raw:s'=>\$raw,
    'tab:s'=>\$tab,
    'X:i'=>\$X,
    'v'=>\$verbose,
    );

if (!-e $input || !-r _) {
    if (!-e $raw || !-r _) {
	die "add-PQX.plx: $input non-existent or unreadable\n";
    }
}

# P-number in col1, label in col2
if ($tab) {
    open(T,$tab) || die "add-PQX.plx: tabfile $tab non-existent or unreadable\n";
    while (<T>) {
	chomp;
	my($P,$l) = split(/\t/,$_);
	$tab{$l} = $P;
    }
    close(T);
}

if ($raw) {
    open(R, $raw) || die "add-PQX.plx: failed to open raw input file $input\n";
    open(O, ">$raw.P") || die "add-PQX.plx: failed to open raw output $raw.P\n";
    while (<R>) {
	chomp;
	my $query = $_;
	my $rest = '';
	if ($query =~ s/(\t.*?)$//) {
	    $rest = $1;
	}
	my $orig_q = $query;
	$query =~ tr/ ,/__/;
	my @res = `se \#$project \!cat $query`;
	chomp @res;
	@res = uniq(@res);
	print "@res\t$orig_q$rest\n";
	print O "@res\t$orig_q$rest\n";
    }
    close(O);
    close(R);
    exit(0);
}

open(I, $input)  || die "add-PQX.plx: failed to open input file $input\n"; 
open(O,">$output") || die "add-PQX.plx: failed to open output file $output\n"; 
select O;
while (<I>) {
    unless (m/^\&/) {
	print;
	next;
    }
    if (/^\&X\d+/ && !$all) {
	print;
	next;
    }
    chomp;
    my $query = $_;
    if ($query =~ /^\&(\S*)\s*=\s*(.*?)(?:\s*=|\s*$)/) {
	$query = $2;
	$thisX = $1;
#	warn "query=$query\n";
    } else {
	warn "$input:$.: expected `\& = [TEXT REFERENCE]' or similar\n";
    }
    if ($tab) {
	if ($tab{$query}) {
	    print "\&$tab{$query} = $query\n";
	} else {
	    warn "add-PQX.plx: no P-number for `$query'\n"
		unless $thisX =~ /^P\d\d\d\d\d\d/;
	    use Data::Dumper; warn Dumper \%tab unless $dumped++;
	}
    } else {
	$query =~ s/\t.*//;
	$query =~ s/\s*[=\+].*$//;
	if ($query =~ /\d-\d+-\d+,\s*\d+/) {
	    $query =~ s/,\s+/_/;
	} else {
	    $query =~ tr/-,.:;()//d;
	    $query =~ s/\s+/_/g;
	}
	if ($query =~ /[a-z0-9]/i) {
	    warn "$query\n" if $verbose;
	    my $x = "se \\#cdli \\!cat '$query'";
#	    warn "$x\n";
	    my @res = `$x`;
	    if ($#res >= 0) {
		chomp @res;
		@res = uniq(@res);
		s/^\&(\S*)\s*=\s*//;
		my $oldX = $1;
		print "\&@res = $_ [$oldX]\n";
		next;
	    }
	}
	if ($X >= 0) {
	    s/^\&\s+//;
	    printf "\&X%06d\t$_\n",$X++;
	} else {
	    print "$_\n";
	}
    }
}
close(I);
close(O);

print STDERR "add-PQX.plx: output written to $output\n";

sub
uniq {
    my %t = ();
    @t{@_} = ();
    keys %t;
}

1;
