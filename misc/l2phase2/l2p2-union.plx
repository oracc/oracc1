#!/usr/bin/perl
use warnings; use strict; use open 'utf8';
binmode STDIN, ':utf8'; binmode STDOUT, ':utf8'; binmode STDERR, ':utf8';
use lib "$ENV{'ORACC'}/lib";
use ORACC::L2GLO::Util;
use Getopt::Long;

my $arg_lang = '';
my $autovars = 0;
my $coresig = '';
my $drop_zero = 1;
my %header = ();
my $in_sense = '';
my @instsigs = ();
my $mode = '';
my $oracc = "$ENV{'ORACC'}";
my $out = '';
my $project = `oraccopt`;
my %sig = ();
my %sigfiles = ();
my @sigfiles = ();
my @sigprojects = ();

GetOptions (
    'lang:s'=> \$arg_lang,
    'mode:s'=> \$mode,
    'out:s' => \$out,
    'project:s'=>\$project,
    );

$mode = `oraccopt . cbd-super` unless $mode;
unless ($mode) {
    my $bap = `oraccopt . build-approved-policy`;
    $mode = 'search' if $bap eq 'search';
}
my $superlist = '';
if (-r '01bld/superlangs') {
    $superlist = `cat 01bld/superlangs`;
} else {
    $superlist = `oraccopt . cbd-super-list`;
}
my @projects = union_projects();
my @langs = union_langs(@projects);

if ($arg_lang && grep /^$arg_lang$/, @langs) {
    union_one_lang($arg_lang);
} elsif ($superlist) {
    if ($mode eq 'mega') {
	union_mega('01bld/mega.sig');
    } elsif (-r '01bld/superlangs') {
	union_mega('01bld/from-prx-glo.sig');
    } else {
	foreach my $l (split(/\s+/, $superlist)) {
	    union_one_lang($l);
	}
    }
} else {
    foreach my $l (sort keys %sigfiles) {
	union_one_lang($l);
    }
}

######################################################################################

sub
lang_from {
    $_[0] =~ m,^.*?/([^/]+)/union.sig$,;
    return $1;
}

sub
union_langs {
    foreach my $p (@_) {
	foreach my $s (unions_from($p)) {
	    push @{$sigfiles{lang_from($s)}}, $s;
	}
    }
#    use Data::Dumper;
#    warn Dumper \%sigfiles;
#    exit 1;
}

sub
union_projects {
    my @p = ();
    if ($mode eq 'list') {
	if (open(P,'00lib/super-glossary.lst')) {
	    @p = (<P>); close(P);
	} else {
	    warn "l2p2-union.plx: can't open 00lib/super-glossary.lst\n";
	}
    } elsif ($mode eq 'umbrella') {
	if (open(P,'00lib/umbrella.lst')) {
	    while (<P>) {
		chomp;
		push @p, split(/\s+/,$_);
	    }
	} else {
	    @p = grep m#/#, `projpublic.sh $project`;
	}
    } elsif ($mode eq 'global') {
	@p = `projpublic.sh`;
    } elsif ($mode eq 'mega') {
	# we've already built mega.sig
    } elsif ($mode eq 'search') {
	# we've already already built from-prx-glo.sig
    } else {
	die "l2p2-union.plx: unknown mode '$mode'\n";
    }
    chomp @p;
    @p;
}

sub union_mega {
    my $megasig = shift;
    %sig = ();
    warn "loading $megasig\n";
    load_sigfile('',$megasig);

    foreach my $lang (split(/\s+/, $superlist)) {
	system 'mkdir', '-p', "01bld/$lang";
	$out = "01bld/$lang/union.sig" unless $out && $arg_lang;
	open(O,">$out") || die "l2p2-union.plx: can't open `$out' for output\n";
	select O;
	warn "l2p2-union.plx: creating mega glossary file $out\n";
	dump_sigs($lang);
    }
}

sub
union_one_lang {
    my($lang) = @_;

    my @sigfiles = @{$sigfiles{$lang}};
    
    return unless $#sigfiles >= 0;

    system 'mkdir', '-p', "01bld/$lang";
    $out = "01bld/$lang/union.sig" unless $out && $arg_lang;
    open(O,">$out") || die "l2p2-union.plx: can't open `$out' for output\n";
    select O;
    warn "l2p2-union.plx: creating super-glossary file $out\n";
    
    %sig = ();
    foreach my $s (@sigfiles) {
	warn "$s\n";
	load_sigfile($lang,$s);
    }

    dump_sigs($lang);
}

sub
unions_from {
    my @u = ();
    if (-d "$oracc/bld/$_[0]") {
	@u = eval("<$oracc/bld/$_[0]/*/union.sig>");
    } else {
	if (-d "$_[0]/01bld") {
	    @u = eval("<$_[0]/01bld/*/union.sig>");
	} else {
	    warn "l2p2-union.plx: no build dir found for project '$_[0]'\n";
	}
    }
    @u;
}

sub
dump_sigs {
    my $lang = shift;
    print "\@project $project\n\@name $project $lang glossary\n\@lang $lang\n\n";
    print "\@fields sig freq inst\n";
    foreach (sort grep(/\%$lang:/, keys %sig)) {
	my @refs = grep(defined && length, uniq(@{$sig{$_}}));
#	my $i = mysum(map { /;(\d+)/ } @refs);
	my $i = $#refs + 1;
	# The correct format for this is no-percent column; this is what sig-g2x expects
	print "$_\t$i\t@refs\n";
    }
}

sub
load_sigfile {
    my($lang, $file) = @_;
    if (open(S,$file)) {
	my %f = ();
	my $use_freq = 0;
	while (<S>) {
	    next if /^\s*$/;
	    if (/^\@?(proj(?:ect)?|name|lang)\s+(\S+)/) {
		next;
	    }
	    chomp;
	    if (/\@fields/) {
		my $fields = $_;
		my @f = split(/\s+/, $fields); shift @f;
		for (my $i = 0; $i <= $#f; ++$i) {
		    $f{$f[$i]} = $i;
		}
		$use_freq = defined $f{'freq'};
		next;
	    }

	    if ($lang) {
		next unless /\%$lang:/;
	    }

	    my @s = split(/\t/,$_);
	    my $sig = $s[0];
	    my $freq = 0;
	    # If we have freq use that, otherwise count refs in inst
	    my $refs = $s[$f{'inst'}];
	    if ($use_freq) {
		$freq = $f{'freq'};
	    } else {
		$freq = count_refs($refs);
	    }
	    if ($refs && ($freq || !$drop_zero)) {
		if ($sig =~ /^\{/) {
		    $sig =~ s/::.*?\%/::\@$project\%/;
		} else {
		    $sig =~ s/^.*?\%/\@$project\%/;
		}
		push @{$sig{$sig}}, $refs;
	    }
	}
	close(S);
    } else {
	warn "l2p2-union.plx: can't open sigs `$file' for input\n";
    }
}

sub count_refs {
    if ($_[0]) {
	my @r = split(/\s+/, $_[0]);
	return $#r + 1;
    } else {
	return 0;
    }
}

sub
sigfiles_from {
    my $lang = shift;
    my @ret = ();
    foreach my $m (map { "$oracc/bld/$_/$lang/union.sig" } @_) {
	push(@ret, $m) if -r $m;
    }
    @ret;
}

sub
uniq {
    my %x = ();
    foreach (@_) {
	@x{split(/\s+/,$_)} = ();
    }
    sort keys %x;
}

1;
