function make_template(icv, varargin)
addpath('/apps/spm/12/spm12/');
spm_jobman('initcfg');
spm('defaults', 'PET');
  
files = cellfun(@(o) [o,',1'], varargin, 'UniformOutput', false); 
disp(['Number of image files: ', num2str(numel(files))]);
 
c1files=files(1:3:end)';
disp(c1files');

%-----------------------------------------------------------------------
% Job saved on 14-Sep-2020 13:17:27 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.factorial_design.dir = {'/rds/general/user/nbourke/home/eph'};
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {c1files};
matlabbatch{1}.spm.stats.factorial_design.cov.c = 'icv';
matlabbatch{1}.spm.stats.factorial_design.cov.cname = 'TIV';
matlabbatch{1}.spm.stats.factorial_design.cov.iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov.iCC = 5;
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tma.athresh = 0.01;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_mean = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 2;


spm_jobman('run', matlabbatch);

end
