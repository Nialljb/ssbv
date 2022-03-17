function run_inverse_warp(varargin)
addpath('/apps/spm/12/spm12/');
spm_jobman('initcfg');
spm('defaults', 'PET');

files = cellfun(@(o) [o,',1'], varargin, 'UniformOutput', false); 
disp(['Number of image files: ', num2str(numel(files))]);


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


matlabbatch{1}.spm.tools.dartel.crt_iwarped.flowfields = {urc1};
matlabbatch{1}.spm.tools.dartel.crt_iwarped.images = { 
                                                             {c1}
                                                              {c2}
                                                              {c3}                                                  
                                                              };
matlabbatch{1}.spm.tools.dartel.crt_iwarped.K = 6;
matlabbatch{1}.spm.tools.dartel.crt_iwarped.interp = 1;


spm_jobman('run', matlabbatch);
