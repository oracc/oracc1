## Process this file with automake to produce Makefile.in
##
#  Copyright(c) Pennsylvania Sumerian Dictionary and Steve Tinney
#  1997 under the GNU General Public License (see /psd/COPYING).
# 
#  $Id: Makefile.lam,v 0.5 1997/09/08 13:01:43 sjt Exp $

include ../../../oracc-am-rules.txt

bin_PROGRAMS=haslinks haslinks1 isogmt \
	jpegsize linkfiles gdf labeltable unittable \
	newext oraccopt pqunion sigfixer sigmap xmlnl \
	xmlns xmlsplit utf8v xfrag filesize listdir \
	xns wid2err rootnode wid2lem xis2json linksets \
	xtfsigs oxg pllcfg

xis2json_SOURCES=xis2json.c
xis2json_LDADD= ${O2lib}
#@top_srcdir@/c/lib/liboracc.la

haslinks.c: haslinks.c.in
	$(ORACCIFY) haslinks.c.in

pqoutline.c: pqoutline.c.in
	$(ORACCIFY) pqoutline.c.in

sigmap.c: sigmap.c.in
	$(ORACCIFY) sigmap.c.in

#concord_SOURCES=concord.c
#concord_LDADD=@top_srcdir@/c/lib/liboracc.la @top_srcdir@/../oracc2/lib/liboracc2.la 

O1lib=@top_srcdir@/c/lib/liboracc.la
O2lib=@top_srcdir@/../oracc2/lib/liboracc2.la 

gdf_LDADD=@top_srcdir@/../oracc2/lib/liboracc2.la

haslinks_SOURCES=haslinks.c

isogmt_SOURCES=isogmt.c

labeltable_LDADD=${O2lib} ${O1lib}

linkfiles_SOURCES=linkfiles.c

jpegsize_SOURCES=jpegsize.c jpeginfo.c jpeginfo.h

newext_SOURCES=newext.c
newext_LDADD=@top_srcdir@/c/lib/liboracc.la

oraccopt_SOURCES=oraccopt.c
oraccopt_LDADD = ${O2lib} ${O1lib}

oxg_SOURCES=oxg.c
oxg_LDADD =  ${O2lib} ${O1lib}
#@top_srcdir@/c/lib/liboracc.la

pllcfg_LDADD=${O2lib} ${O1lib}
#@top_srcdir@/c/lib/liboracc.la

#pqoutline_SOURCES=pqoutline.c otlenum.h
#pqoutline_LDADD = ../expat/libexpat.la @top_srcdir@/c/lib/liboracc.la

#pqsort_SOURCES=pqsort.c
#pqsort_LDADD = @top_srcdir@/c/lib/liboracc.la

pqunion_SOURCES=pqunion.c

sigfixer_SOURCES=sigfixer.c
sigfixer_LDADD = @top_srcdir@/c/lib/liboracc.la

sigmap_SOURCES=sigmap.c
sigmap_LDADD = @top_srcdir@/c/lib/liboracc.la

unittable_LDADD=${O2lib} ${O1lib}

#xalias_SOURCES=xalias.c
#xalias_LDADD = @top_srcdir@/c/l2/libl2.la \
#	@top_srcdir@/c/otf/gdl/libgdl.la \
#	@top_srcdir@/c/lib/liboracc.la

# sas_SOURCES=sas.c
# sas_LDADD = @top_srcdir@/c/l2/libl2.la \
#	@top_srcdir@/c/otf/gdl/libgdl.la \
#	@top_srcdir@/c/lib/liboracc.la

rootnode_LDADD= ${O2lib}
#@top_srcdir@/c/lib/liboracc.la

xfrag_LDADD= ${O2lib}
# @top_srcdir@/c/lib/liboracc.la

#xisdb_SOURCES=xisdb.c
#xisdb_LDADD = @top_srcdir@/c/lib/liboracc.la

xns_SOURCES=xns.c
xns_LDADD = ${O2lib}
#@top_srcdir@/c/lib/liboracc.la

xmlns_SOURCES=xmlns.c
xmlns_LDADD = ${O2lib}

xmlsplit_SOURCES=xmlsplit.c
xmlsplit_LDADD =  ${O2lib}
#@top_srcdir@/c/lib/liboracc.la

utf8v_sources=utf8v.c

linksets_LDADD= ${O2lib} ${O1lib}
#@top_srcdir@/c/lib/liboracc.la

wid2err_LDADD= ${O2lib} ${O1lib}
#@top_srcdir@/c/lib/liboracc.la

wid2lem_LDADD= ${O2lib} ${O1lib}
#@top_srcdir@/c/lib/liboracc.la

xtfsigs_LDADD= ${O2lib} ${O1lib}
#@top_srcdir@/c/lib/liboracc.la

