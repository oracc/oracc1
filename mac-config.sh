#!/bin/sh
if [ -r ../oracc2/oracc-am-rules.txt ] ; then
    ln -sf ../oracc2/oracc-am-rules.txt .
else
    echo "$0: ../oracc2/oracc-am-rules.txt not found. Stop."
fi
if [ ! -r $ORACC/bin/oraccenv.sh ]; then
    echo "$0: no ORACC-bin/oraccenv.sh. Please install Oracc II. Stop."
    exit 1
fi
. oraccenv.sh
glibtoolize
aclocal
autoheader
automake
autoconf
./configure --prefix=/Users/stinney/orc
make
make install
