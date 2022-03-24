#!/bin/sh
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=16:mem=8gb

# Usage() {
# cat <<EOF
 
# HPC - Imperial College London

# DTITK_run 1.0 (March 2022)
# n.bourke@imperial.ac.uk

# Usage: localSubmit <working directory> 
# e.g. localSubmit 

# DEPENDENCY:
# DTIFIT output data must be in single directory 

# EOF
# exit 1
# }

# if [  $# -lt 1 ];
#   then
#   Usage
#   exit 1
# fi

# if [ $# -eq 1 ];
#     then
#     WORKINGDIR=$1
#     echo "input is = $input"
# fi

dateFunction(){
	date
}

export DTITK_ROOT=/apps/dti-tk/2.3.1/
export PATH=$PATH:$DTITK_ROOT/bin:$DTITK_ROOT/utilities:$DTITK_ROOT/scripts:$DTITK_ROOT/lib:$DTITK_ROOT/include
templates=/rds/general/project/c3nl_djs_imaging_data/live/templates

cd $WORKINGDIR

for f in *_dtitk.nii.gz;
do echo $WORKINGDIR/${f}>>${WORKINGDIR}/DTI_subjs.txt;
done

#cp /rds/general/user/nbourke/home/ml/dependencies/Tract_ROIs_required_files* ${WORKINGDIR}

dti_template_bootstrap ${templates}/ixi_aging_template_v3.0/ixi_aging_template.nii.gz $WORKINGDIR/DTI_subjs.txt;

echo "Complete-now performing affine registration"

#$WORKINGDIR/
dti_affine_population $WORKINGDIR/mean_initial.nii.gz DTI_subjs.txt EDS 3;

echo "Complete"

TVtool -in $WORKINGDIR/mean_affine3.nii.gz -tr;

echo "Creating mask for diffeomorphic registration"

BinaryThresholdImageFilter $WORKINGDIR/mean_affine3_tr.nii.gz $WORKINGDIR/mask.nii.gz 0.01 100 1 0;

echo "Done Step 1"
echo "Running Diffeomorphic registration"
#./
dti_diffeomorphic_population $WORKINGDIR/mean_affine3.nii.gz $WORKINGDIR/DTI_subjs_aff.txt $WORKINGDIR/mask.nii.gz 0.002;

echo "Complete"

module load fsl/5.0.10
module load mricogl

echo "Making images 1mm isotropic"

dti_warp_to_template_group DTI_subjs.txt ${WORKINGDIR}/mean_diffeomorphic_initial6.nii.gz 1 1 1;

echo "Combining the affine and diffeomorphic registrations"

for f in *_dtitk.nii.gz;do echo ${f/.nii.gz/};done>DTI_subjects_combined.txt;

for f in `cat DTI_subjects_combined.txt`;do dfRightComposeAffine -aff ${f}.aff -df ${f}_aff_diffeo.df.nii.gz -out ${f}_combined.df.nii.gz;done

echo "Rigid registration to IITmeantensor256-MNI space"

dti_rigid_reg ${templates}/IIT/IITmean_tensor_256.nii ${WORKINGDIR}/mean_diffeomorphic_initial6.nii.gz EDS 4 4 4 0.001;

echo "Affine registration to IITmeantensor256"

dti_affine_reg ${templates}/IIT/IITmean_tensor_256.nii ${WORKINGDIR}/mean_diffeomorphic_initial6.nii.gz EDS 4 4 4 0.001 1;

echo "Diffeomorphic registration to IITmeantensor 256"

dti_diffeomorphic_reg ${templates}/IIT/IITmean_tensor_256.nii ${WORKINGDIR}/mean_diffeomorphic_initial6_aff.nii.gz ${WORKINGDIR}/IITmean_tensor_mask_256.nii.gz 1 6 0.002;

dfRightComposeAffine -aff ${WORKINGDIR}/mean_diffeomorphic_initial6.aff -df ${WORKINGDIR}/mean_diffeomorphic_initial6_aff_diffeo.df.nii.gz -out ${WORKINGDIR}/mean_combined.df.nii.gz;

echo "Transforming subjects from native to standard space"

for f in `cat DTI_subjects_combined.txt`;do dfComposition -df2 ${f}_combined.df.nii.gz -df1 mean_combined.df.nii.gz -out ${f}_to_standard.df.nii.gz;done;

for f in `cat DTI_subjects_combined.txt`;do deformationSymTensor3DVolume -in ${f}.nii.gz -trans ${f}_to_standard.df.nii.gz -target ${templates}/IIT/IITmean_tensor_256.nii -out ${f}_to_standard.nii.gz;done;

echo "Creating 4d file of all subjects registrations to standard space for QC"
