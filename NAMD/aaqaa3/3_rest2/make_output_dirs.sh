#!/bin/bash

if [[ $# != 2 ]]; then
  echo "usage: $0 <output_dir> <num_replicas>"
  exit -1
fi

mkdir -p $1

up=$(($2-1))
for i in $(seq 0 $up); do
  mkdir -p $1/$i
done

