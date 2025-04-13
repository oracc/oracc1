include ../../../oracc-am-rules.txt

##.g.c:
##	gperf -N `basename $*` -tT $< >$@
SUBDIRS=
noinst_LTLIBRARIES=libbigrams.la

libbigrams_la_SOURCES=bigrams.c collos.c

bigrams.c: bigrams.c.in
	$(ORACCIFY) bigrams.c.in

collos.c: collos.c.in
	$(ORACCIFY) collos.c.in
