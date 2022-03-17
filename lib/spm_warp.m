function spm_warp(varargin)
addpath('/apps/spm/12/spm12/');
spm_jobman('initcfg'); spm('defaults', 'PET');

deformationfield = varargin{1}
filetowarp = varargin{2}
prefix = varargin{3}

%-----------------------------------------------------------------------
% Job saved on 19-Jun-2020 18:30:27 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.normalise.write.subj.def = {[deformationfield]};
matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {[filetowarp, ',1']};


%matlabbatch{1}.spm.tools.longit{1}.pairwise.vols1 =
%matlabbatch{1}.spm.tools.longit{1}.pairwise.vols2 =


matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
%matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'avg_space_';
matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = prefix;

spm_jobman('run', matlabbatch);
