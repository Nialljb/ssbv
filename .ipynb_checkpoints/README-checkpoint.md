# Subject specific brain volume estimation (SSBV)

### Overview
This notebook takes a set of scans and tells you what the volumes of grey matter, white matter and CSF are. It also lets you run a voxelwise comparison (voxel based morphometry) between the two groups (patients versus controls) to see whether the volume at each voxel is significantly different. Eg. Do patients have smaller brains (ie are they more atrophic) than controls?

The notebook uses SPM12 (UCL) to do most of the heavy lifting, and then FSL for the stats. You might find the SPM manual useful: https://www.fil.ion.ucl.ac.uk/spm/doc/manual.pdf.

### Setup
#### See notebook for details
- Requires local installation of Jupyter (with desired env setup)
    This can be done via conda
- Expects remote file system mounted as a volume (e.g. macFuse https://osxfuse.github.io/)
- Local installations of software (e.g. fsl, mrtrix)
- A login file is required that contains your ssh login details
- This notebook should sit on the cluster

### Development notes
1. Work out starting point/dependencies
2. Assume BIDS datastructure 
3. Relative paths when data is remote
4. Work with out of the box functionanality in mind
5. Could/should take out dependency of shell scripting in Jupyter. Each of these BASH cells could be shell scripts called from lib. This would simplify the workflow

