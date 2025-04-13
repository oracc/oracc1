include ../../../oracc-am-rules.txt

.g.c:
	gperf -N `basename $*` -tT $< >$@
SUBDIRS=

props_auto.c: props_auto.c.in
	$(ORACCIFY) props_auto.c.in

props_load.c: props_load.c.in
	$(ORACCIFY) props_load.c.in

instdir=$(libdir)/data
inst_DATA=props.xml props-qpn.xml

noinst_LTLIBRARIES=libprops.la
libprops_la_SOURCES=props_head.c props_link.c props_list.c \
	props_load.c props_util.c props_auto.c
