#!/bin/sh
d=$1
#echo o2-init-cnf called from $d
ls -l 00lib/config.xml
(cd $d ; o2-cnf.sh)
