include ../../../oracc-am-rules.txt

SUBDIRS=
noinst_LTLIBRARIES=libprj.la

set_project.c: set_project.c.in
	$(ORACCIFY) set_project.c.in

libprj_la_SOURCES = \
	default.c proj_load.c set_project.c

override AM_CPPFLAGS=${XAM_CPPFLAGS} -I@top_srcdir@/../oracc2/lib/{std,sys,lng,gvl,sll} \
	-I@top_srcdir@/../oracc2/include \
	-I@top_srcdir@/include -I ../ox
