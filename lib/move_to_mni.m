function move_to_mni(template, varargin)
addpath('/apps/spm/12/spm12/');
spm_jobman('initcfg');
spm('defaults', 'PET');
fprintf('Template six is: %s\n', template);

files = cellfun(@(o) [o,',1'], varargin, 'UniformOutput', false); 
disp(['Number of image files: ', num2str(numel(files))]);

template
template = char(template);

urc1file=files(1:4:end)';
c1files=files(2:4:end)';     
c2files=files(3:4:end)';
c3files=files(4:4:end)';

urc1 = cellstr(urc1file);
urc1 = char(urc1)
urc1 = urc1(1:end-2)

c1 = cellstr(c1files);
c1 = char(c1)
c1 = c1(1:end-2)
c2 = cellstr(c2files);
c2 = char(c2)
c2 = c2(1:end-2)
c3 = cellstr(c3files);
c3 = char(c3)
c3 = c3(1:end-2)
matlabbatch{1}.spm.tools.dartel.mni_norm.template = {[template]};


matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = {urc1} ;



matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = { 
                                                             {c1}
                                                              {c2}
                                                              {c3}                                                  
                                                              }
                             
                             
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images

matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [1 1 1];

%IF USING MNI 1MM USE THIS BOUNDING BOX
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [-91 -126 -72
                                               90 91 109];

%IF USING MNI 2MM YOU CAN USE NAN  USE THIS BOUNDING BOX
%matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
 %                                              NaN NaN NaN];


matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 1;
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [8 8 8];


spm_jobman('run', matlabbatch);