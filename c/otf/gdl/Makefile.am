include ../../../oracc-am-rules.txt

SUBDIRS=
noinst_LTLIBRARIES=libgdl.la

#
# gvl.c removed to use c2/gdl
#
libgdl_la_SOURCES = \
	graphemes.c inline.c c1c2gvl.c gdl_init.c \
	gdlopts.c splitwords.c tokcheck.c tokenizer.c 

override AM_CPPFLAGS=${XAM_CPPFLAGS} -I@top_srcdir@/../oracc2/lib/{std,sys,lng,gvl,sll} \
	-I@top_srcdir@/../oracc2/include \
	-I@top_srcdir@/include -I ../ox
