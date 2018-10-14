#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -j y
#$ -N rest2
#$ -l h_data=500M,h_rt=999:00:00
#$ -pe ppn8 32
#$ -R y
#$ -m es

charmm=/charmm/c37a2/exec/gnu_M/charmm.rest
mpirun="mpirun --leave-session-attached"
ulimit -c 4

cp c7eq.lys.inp c7eq.lys.inp_0
cp c7eq.lys.inp c7eq.lys.inp_1
cp c7eq.lys.inp c7eq.lys.inp_2
cp c7eq.lys.inp c7eq.lys.inp_3

$mpirun $charmm < rest.c7eq.lys.inp > rest.c7eq.lys.out
