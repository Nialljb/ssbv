#!/bin/sh

usage() {
    cat <<EOF

hpcwrap_matlab.sh 

Usage: hpcwrapmatlab.sh <command> 
e.g.   hpcwrapmatlab.sh "myfunction('go', 2, 4);"

	<command>			MATLAB function to execute, inside ""

EOF
    exit 1
}

############################################################################
[ "$#" -lt 1 ] && usage

module load matlab/R2018a;

wd=`dirname "$(readlink -f "$0")"`;
cmd="matlab -nodesktop -r \"addpath('$wd');$1;exit\"";
eval ${cmd}
