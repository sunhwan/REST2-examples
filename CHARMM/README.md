# CHARMM REST2 Examples

To use REST2 in CHARMM, BLOCK module and REPDSTR module can be used. BLOCK module allows arbitrary scaling of energy terms and REPDSTR allows replica-exchange simulation. The CHARMM binary needs to be compiled with options that activates REPDSTR module.

    ./install.com gnu xlarge X86_64 M mpif90 +REPDSTR +ASYNC_PME +GENCOMM

# Test

You can test 
