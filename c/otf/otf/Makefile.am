include ../../../oracc-am-rules.txt

SUBDIRS=
noinst_LTLIBRARIES=libotf.la

cdt_reader.c: cdt_reader.c.in
	$(ORACCIFY) cdt_reader.c.in

libotf_la_SOURCES = \
	cdt_atf.c cdt_database.c cdt_data.c cdt_findfile.c \
	cdt_foreign.c cdt_inline.c cdt_reader.c cdt_style.c \
	cdttoks.c cdt_warning.c scan.c style_props.c gdlstring.c

override AM_CPPFLAGS=${XAM_CPPFLAGS} -I@top_srcdir@/../oracc2/lib/{std,sys,lng,gvl,sll} \
	-I@top_srcdir@/../oracc2/include \
	-I@top_srcdir@/include -I ../ox
