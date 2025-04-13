include ../../../oracc-am-rules.txt

.g.c:
	gperf -N `basename $*` -tT $< >$@
SUBDIRS=
noinst_LTLIBRARIES=libpsus.la

psus.c: psus.c.in
	$(ORACCIFY) psus.c.in

libpsus_la_SOURCES=psu2.c links_psu.c
