#!/bin/bash

NREPLICA=3         # number of replica
REPLICA_NODE=1     # number of node per replica
REPLICA_PPN=8      # number of processor per replica

let np=$REPLICA_NODE*$REPLICA_PPN*$NREPLICA

qsub -v icnt=0 -pe mpi $np run.sh
