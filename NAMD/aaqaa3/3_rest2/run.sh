#!/bin/bash

MAX_ICNT=1                    # maximum number of runs
NREPLICA=3                    # number of replica
REPLICA_NODE=1                # number of node per replica
REPLICA_PPN=8                 # number of processor per replica
STEPS_PER_RUN=500             # steps_per_run in rest2.conf
NAMD_DIR=/shared/namd/current # directory contains namd2 and charmrun

# DO NOT EDIT BELOW
let pcnt=$icnt-1
let pstep=$STEPS_PER_RUN*$icnt
let istep=$pstep+$STEPS_PER_RUN
let ncnt=$icnt+1
sed -e "s/\$pcnt/$pcnt/g" -e "s/\$pstep/$pstep/g" -e "s/\$istep/$istep/g" base.conf > job$icnt.conf

./make_output_dirs.sh output $NREPLICA
let np=$REPLICA_NODE*$REPLICA_PPN*$NREPLICA
# DO NOT EDIT ABOVE

if [ $icnt -lt $MAX_ICNT ]
then
  # submit and hold for the next job
  # edit the qsub command to match your environment
  #qsub -hold_jid $JOB_ID -v icnt=$ncnt -pe all.q $np run.sh
  echo
fi 

$NAMD_DIR/charmrun +p$np $NAMD_DIR/namd2 +replicas $NREPLICA job$icnt.conf +stdout output/%d/job$icnt.%d.log

