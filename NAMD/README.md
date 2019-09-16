# NAMD REST2 Examples

NAMD 2.13 version officially support REST2. To use replica-exchange, NAMD with
multi-copy algorithm support is required. Download the appropriate binary or
compile the NAMD from source code (see the instruction found in `notes.txt`
file).

I also provide Dockerfile for installing NAMD 2.13 binary with multi-copy
algorithm. Use the following command to build and use NAMD.

    # build docker container (you may change the container name)
    docker build -t namd .

    # run docker interactively and obtain a shell
    docker run -it namd namd/namd2 [options]

    # or

    docker run -it namd namd/charmrun [options]

## Test

The folder `test` contains a set of NAMD script that performs validation test
for REST2. The test system consists of a small solute and a few water molecules.
The test collect the potential energies of solute and solvent independently as
well as the solute-solvent interaction energy without any scaling. Then, it
applies the solute scaling and compare if the solute and solute-solvent
interaction energy terms are scaled accordingly.

To run the test, edit the `run_test.py` script in the `test` folder to provide
correct NAMD location (multi-copy algorithm enabled NAMD binary is required),
and use the following command.

    $ python run_test.py

If all ran correctly, "all test passed" will be printed.

If you want to run above test using Docker, use following commands:

    # build docker container (you may change the container name)
    docker build -t namd .

    # run docker interactively and obtain a shell
    docker run --volume=$(pwd):/root -it namd /bin/bash

    # now we are in docker container;
    # namd is installed in /root/namd folder
    # test files are mounted in /root/rest2 folder
    cd /root/rest2
    python run_test.py

## Examples

* `aaqaa3`: (AAQAA)3 peptide folding
* `fep`: p-xylene binding affinity to T4 lysozyme
* `abl`: Abl kinase and peptide binding affinity

