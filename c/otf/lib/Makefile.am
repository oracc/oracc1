include ../../../oracc-am-rules.txt

SUBDIRS=
noinst_LTLIBRARIES=libcdf.la
noinst_SCRIPTS=mk_rnc.sh

libcdf_la_SOURCES = \
	catvec.c cdf_rnc.c key.c linkcheck.c loadlabels.c \
	pnames.c rnvif.c symbolattr.c tree.c xmlnames.c

catvec.c: catvec.c.in
	$(ORACCIFY) catvec.c.in

cdf_rnc.c: mk_rnc.sh
	/bin/sh	mk_rnc.sh

pnames.c: pnames.c.in
	$(ORACCIFY) pnames.c.in


override AM_CPPFLAGS=${XAM_CPPFLAGS} -I@top_srcdir@/../oracc2/lib/{std,sys,lng,gvl,sll} \
	-I@top_srcdir@/../oracc2/include \
	-I@top_srcdir@/include -I ../ox
