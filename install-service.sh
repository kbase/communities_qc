#!/bin/bash

if [[ $# != 1 ]] ; then
    echo "Usage: $0 install_dir_path" 1>&2
    exit 1
fi

BDIR=$1

# install from bin dir
pushd bin
for B in `ls`; do
    cp $B $BDIR/$B
    chmod +x $BDIR/$B
done
popd