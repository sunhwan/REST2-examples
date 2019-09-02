from __future__ import print_function
import os
from math import sqrt
from collections import defaultdict

NAMDDIR = '/root/namd'

def parse_energy(outputfile):
    energy = defaultdict(list)
    eterms = []
    for line in open(outputfile):
        if line.startswith("ETITLE:"):
            entry = line.split()[1:]
            eterms = entry
        if line.startswith("ENERGY:"):
            entry = line.split()[1:]
            for i, term in enumerate(eterms):
                energy[term].append(float(entry[i]))
    return energy

def is_almost_equil(x1, x2, threshold):
    if abs(x1 - x2) < threshold:
        return True
    print(x1, '!=', x2)
    return False

os.system('mkdir -p output')

# solute
os.system('%(NAMDDIR)s/namd2 solute.namd > output/solute.out' % locals())
solute_energy = parse_energy('output/solute.out')
solute_elec = solute_energy['ELECT'][-1]
solute_vdw = solute_energy['VDW'][-1]

# solvent
os.system('%(NAMDDIR)s/namd2 water.namd > output/water.out' % locals())
solvent_energy = parse_energy('output/water.out')
solvent_elec = solvent_energy['ELECT'][-1]
solvent_vdw = solvent_energy['VDW'][-1]

# solvent-solvent
os.system('%(NAMDDIR)s/namd2 solute_water.namd > output/solute_water.out' % locals())
solute_solvent_energy = parse_energy('output/solute_water.out')
solute_solvent_elec = solute_solvent_energy['ELECT'][-1]
solute_solvent_vdw = solute_solvent_energy['VDW'][-1]
inter_elec = solute_solvent_elec - solute_elec - solvent_elec
inter_vdw = solute_solvent_vdw - solute_vdw - solvent_vdw

# solute alone scaling
os.system('%(NAMDDIR)s/namd2 solute_spt.namd > output/solute_spt.out' % locals())
solute_energy = parse_energy('output/solute_spt.out')
assert is_almost_equil(solute_energy['ELECT'][0], solute_energy['ELECT'][1] * 2, 0.001)
assert is_almost_equil(solute_energy['ELECT'][2], 0.0, 0.001)
assert is_almost_equil(solute_energy['VDW'][0], solute_energy['VDW'][1] * 2, 0.001)
assert is_almost_equil(solute_energy['VDW'][2], 0.0, 0.001)

# solvent alone scaling
os.system('%(NAMDDIR)s/namd2 water_spt.namd > output/water_spt.out' % locals())
solvent_energy = parse_energy('output/water_spt.out')
assert is_almost_equil(solvent_energy['ELECT'][0], solvent_energy['ELECT'][1], 0.001)
assert is_almost_equil(solvent_energy['ELECT'][1], solvent_energy['ELECT'][2], 0.001)
assert is_almost_equil(solvent_energy['VDW'][0], solvent_energy['VDW'][1], 0.001)
assert is_almost_equil(solvent_energy['VDW'][1], solvent_energy['VDW'][2], 0.001)

# solute-solvent scaling
os.system('%(NAMDDIR)s/namd2 solute_water_spt.namd > output/solute_water_spt.out' % locals())
solute_solvent_energy = parse_energy('output/solute_water_spt.out')
assert is_almost_equil(solute_solvent_energy['ELECT'][1], solute_elec * 0.5 + solvent_elec + inter_elec * sqrt(0.5), 0.001)
assert is_almost_equil(solute_solvent_energy['ELECT'][2], solvent_elec, 0.001)
assert is_almost_equil(solute_solvent_energy['VDW'][1], solute_vdw * 0.5 + solvent_vdw + inter_vdw * sqrt(0.5), 0.001)
assert is_almost_equil(solute_solvent_energy['VDW'][2], solvent_vdw, 0.001)

print('all test passed')
