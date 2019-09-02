# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y wget

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
RUN \
  wget https://www.ks.uiuc.edu/Research/namd/2.13/download/412487/NAMD_2.13_Linux-x86_64-netlrts.tar.gz && \
  tar -xvzf NAMD_2.13_Linux-x86_64-netlrts.tar.gz && \
  ln -s NAMD_2.13_Linux-x86_64-netlrts namd


