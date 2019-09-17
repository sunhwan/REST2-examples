#!/bin/bash

#let icnt=0         # current run number

NREPLICA=16        # number of replica
REPLICA_NODE=1     # number of node per replica
REPLICA_PPN=1      # number of processor per replica
OUTPUDIR=output    # output directory name
STEPS_PER_RUN=1000 # steps_per_run in rest2.conf
MAX_ICNT=50        # maximum number of runs
NAMD_DIR=/opt/namd # directory contains namd2 and charmrun

# DO NOT EDIT BELOW
let pcnt=$icnt-1
let pstep=$STEPS_PER_RUN*$icnt
let istep=$pstep+$STEPS_PER_RUN
let ncnt=$icnt+1

sed -e "s/\$pcnt/$pcnt/g" -e "s/\$pstep/$pstep/g" -e "s/\$istep/$istep/g" base.conf > job$icnt.conf

if [ $icnt -lt $MAX_ICNT ]
then
  # submit and hold for the next job
  echo
  #qsub --dependencies $COBALT_JOBID -t 1:00:00 -n 128 -A $PROJECT --env icnt=$ncnt:n=$n:nrep=$nrep run.sh
fi 

./make_output_dirs.sh $OUTPUTDIR $NREPLICA
let np=$REPLICA_NODE*$REPLICA_PPN

$NAMD_DIR/charmrun +p$np $NAMD_DIR/namd2 +replicas $nrep job$icnt.conf +stdout $OUTPUTDIR/%d/job$icnt.%d.log

