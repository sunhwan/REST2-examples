#!/bin/bash

MAX_ICNT=50
NAMD_DIR=/home/sunhwan/local/namd/2.13b1

let pcnt=$icnt-1
let pstep=1000*$icnt
let istep=$pstep+1000
let ncnt=$icnt+1

sed -e "s/\$pcnt/$pcnt/g" -e "s/\$pstep/$pstep/g" -e "s/\$istep/$istep/g" base.conf > job$icnt.conf

if [ $icnt -lt $MAX_ICNT ]
then
  qsub --dependencies $COBALT_JOBID -t 1:00:00 -n 128 -A $PROJECT --env icnt=$ncnt:n=$n:nrep=$nrep run.sh
fi 
./make_output_dirs.sh output $nrep
let np=$n*16*$nrep
let ppn=4

$NAMD_DIR/namd2 +replicas $nrep job$icnt.conf +stdout output/%d/job$icnt.%d.log +ppn $ppn

