include ../../../oracc-am-rules.txt

SUBDIRS=
noinst_LTLIBRARIES=libatf.la

text.c: text.c.in
	$(ORACCIFY) text.c.in

libatf_la_SOURCES = \
	block.c blocktok.c label.c labtab.c \
	lemline.c nonx.c nonxtok.c \
	protocols.c text.c translate.c transtok.c \
	xtfxcl.c wordmatrix.c note.c cdli.g

override AM_CPPFLAGS=${XAM_CPPFLAGS} -I@top_srcdir@/../oracc2/lib/{std,sys,lng,gvl,sll} \
	-I@top_srcdir@/../oracc2/include \
	-I@top_srcdir@/include -I ../ox
