# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential wget git cmake python gfortran csh mpich2 libmpich-dev

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# You will need to have charmm.tar.gz file in this directory before running this
# charmm.tar.gz can be obtained from this webpage: http://charmm.chemistry.harvard.edu
ADD charmm.tar.gz /root/src

# Define default command.
RUN \
  cd /root/src/charmm && \
  ./install.com gnu xlarge X86_64 M mpif90 +REPDSTR +ASYNC_PME +GENCOMM +CMPI nolog && \
  ln -s /root/src/charmm/exec/gnu_M/charmm /root/charmm
