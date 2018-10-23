# NAMD REST2 Examples

NAMD 2.13b1 version officially support REST2. To use replica-exchange, NAMD with multi-copy algorithm support is required. Download the appropriate binary or compile the NAMD from source code (see the instruction found in `notes.txt` file).

# Test

The folder `test` contains a set of NAMD script that performs validation test for REST2. The test system consists of a small solute and a few water molecules. The test collect the potential energies of solute and solvent independently as well as the solute-solvent interaction energy without any scaling. Then, it applies the solute scaling and compare if the solute and solute-solvent interaction energy terms are scaled accordingly.

To run the test, edit the `run_test.py` script in the `test` folder to provide correct NAMD location (multi-copy algorithm enabled NAMD binary is required), and use the following command.

    $ python run_test.py

If all ran correctly, "all test passed" will be printed.

# Examples

* `aaqaa3`: (AAQAA)3 peptide folding
* `fep`: p-xylene binding affinity to T4 lysozyme
* `abl`: Abl kinase and peptide binding affinity
