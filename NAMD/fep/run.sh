#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --tasks=32

MAX_ICNT=50
NAMD_DIR=/home/sunhwan/local/namd/2.13b1-netlrts

let nrep=16
let icnt=0

let pcnt=$icnt-1
let pstep=1000*$icnt
let istep=$pstep+1000
let ncnt=$icnt+1

sed -e "s/\$pcnt/$pcnt/g" -e "s/\$pstep/$pstep/g" -e "s/\$istep/$istep/g" base.conf > job$icnt.conf

if [ $icnt -lt $MAX_ICNT ]
then
  echo 
  #sbatch --dependencies=afterok:$SLURM_JOB_ID --export icnt=$ncnt:n=$n:nrep=$nrep run.sh
  #qsub --dependencies $COBALT_JOBID -t 1:00:00 -n 128 -A $PROJECT --env icnt=$ncnt:n=$n:nrep=$nrep run.sh
fi 

./make_output_dirs.sh output $nrep
let nodes=1
let core_per_job=2
let np=$nodes*$nrep*$core_per_job

$NAMD_DIR/charmrun +p$np $NAMD_DIR/namd2 +replicas $nrep job$icnt.conf +stdout output/%d/job$icnt.%d.log

