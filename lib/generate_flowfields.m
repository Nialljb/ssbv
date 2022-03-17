function generate_flowfields(template, varargin)
addpath('/apps/spm/12/spm12/');
spm_jobman('initcfg');
spm('defaults', 'PET');
fprintf('Template six is: %s\n', template);

files = cellfun(@(o) [o,',1'], varargin, 'UniformOutput', false); 
disp(['Number of image files: ', num2str(numel(files))]);

rc1files=files(1:3:end)';
rc2files=files(2:3:end)';     
rc3files=files(3:3:end)';

rc1 = cellstr(rc1files)
rc1 = char(rc1)
rc2 = cellstr(rc2files)
rc2 = char(rc2)
rc3 = cellstr(rc3files)
rc3 = char(rc3)

 
template = char(template)

matlabbatch{1}.spm.tools.dartel.warp1.images = {
   
                                           {rc1}     
                                             {rc2} 
                                            {rc3}      
                                                }
                                                
size(matlabbatch{1}.spm.tools.dartel.warp1.images)
   
%%
matlabbatch{1}.spm.tools.dartel.warp1.settings.rform = 0;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).its = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).rparam = [4 2 1e-06];
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).K = 0;

%matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).template = {template,'/work/ngraham/sampledata/c3nl-example-data-raw/proc/templates/v1/Template_v1_1.nii'};


matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).template = {[template, '_1.nii']};

matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).its = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).rparam = [2 1 1e-06];
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).K = 0;
%matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).template = {'/work/ngraham/sampledata/c3nl-example-data-raw/proc/templates/v1/Template_v1_2.nii'};
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).template = {[template, '_2.nii']};


matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).its = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).rparam = [1 0.5 1e-06];
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).K = 1;
%matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).template = {'/work/ngraham/sampledata/c3nl-example-data-raw/proc/templates/v1/Template_v1_3.nii'};
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).template = {[template, '_3.nii']};

matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).its = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).rparam = [0.5 0.25 1e-06];
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).K = 2;
%matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).template = {'/work/ngraham/sampledata/c3nl-example-data-raw/proc/templates/v1/Template_v1_4.nii'};
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).template = {[template, '_4.nii']};



matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).its = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).K = 4;

%matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).template = {'/work/ngraham/sampledata/c3nl-example-data-raw/proc/templates/v1/Template_v1_5.nii'};
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).template = {[template, '_5.nii']};


matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).its = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).K = 6;

%matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).template = {'/work/ngraham/sampledata/c3nl-example-data-raw/proc/templates/v1/Template_v1_6.nii'};
matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).template = {[template, '_6.nii']};


matlabbatch{1}.spm.tools.dartel.warp1.settings.optim.lmreg = 0.01;
matlabbatch{1}.spm.tools.dartel.warp1.settings.optim.cyc = 3;
matlabbatch{1}.spm.tools.dartel.warp1.settings.optim.its = 3;


spm_jobman('run', matlabbatch);
