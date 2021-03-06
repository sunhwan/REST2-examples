# AAQAA3

AAQAA3 is a short peptide have three repeating sequence of AAQAA. This
particular sequence and its variants have been widely used in protein
folding studies.

In this directory, we will build the initial system for simulation using
CHARMM and CHARMM-GUI, then perform REST2 simulation using NAMD. The example
directory contains `1_aaqaa3`, `2_system`, and `3_rest2` directories, which
corresponds to the numbered steps described below.

## 0. Preqiusite

Working CHARMM binary (see CHARMM folder for install guide)

## 1. Build initial peptide

First, we want to build the initial peptide with the correct sequence
in an extended conformation. This can be achieved in variety of ways.
Here, we will use CHARMM-GUI and CHARMM to build the initial peptide.

First, go to [CHARMM-GUI PDB Reader](http://charmm-gui.org/input/pdbreader)
and create a PSF file using `PDB:1LE0`. I used `PDB:1LE0` because it is one
of the smallest protein in RCSB. You may use your favorite protein.

Once you created PSF, download the whole input file using the `download .tgz`
file link on the upper right corner of the page. This will download all
the necessary input files.

Now, duplicate `step1_pdbreader.inp` file to `aaqaa3.inp` file. We will
edit this file to create the AAQAA3 peptide. The example file is shown
below.

    * GENERATED BY CHARMM-GUI (http://www.charmm-gui.org) v2.0 on Oct, 19. 2018. JOBID=1539953356
    * READ PDB, MANIPULATE STRUCTURE IF NEEDED, AND GENERATE TOPOLOGY FILE
    *

    DIMENS CHSIZE 3000000 MAXRES 3000000

    ! Read topology and parameter files
    stream toppar.str

    ! Read AAQAA3 sequence
    !
    ! An empty line after the sequence is necessary for CHARMM to
    ! recognize the end of sequence list.
    !
    read sequence card
    * AAQAA3
    *
    15
    ALA ALA GLN ALA ALA
    ALA ALA GLN ALA ALA
    ALA ALA GLN ALA ALA

    generate PROA setup warn first NTER last CT2

    ! generate conformer using internal coordinate
    !
    ic param
    ic print
    ic seed PROA 1 N PROA 1 CA PROA 1 C
    ic build


    !Print heavy atoms with unknown coordinates
    coor print sele ( .not. INIT ) .and. ( .not. hydrogen ) end

    ic param
    ic build
    prnlev 0
    hbuild
    prnlev 5


    ENERGY
    ! check if there are unknown coordinate
    define XXX sele .not. INIT show end
    if ?nsel .gt. 0 stop ! ABNORMAL TERMINATION: Undefined coordinates

    open write card unit 10 name aaqaa3.pdb
    write coor pdb  unit 10 official

Execute this input file using CHARMM and you will have `aaqaa3.pdb` output file.

## 2. Build simulation system

This is straightforward after you have the extended conformation.
We will just use [CHARMM-GUI Solution Builder](http://www.charmm-gui.org/input/solution) 
to build a solvated system. Download the whole input files using `download .tgz`
file link.

## 3. REST2 Simulation Setup

Now the fun part. We are ready to setup REST2 simulation. `toppar` directory is
copied from the CHARMM-GUI input folders downloaded in the previous step. 


