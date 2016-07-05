% Get current path
rootDistribDir = pwd();

% Add GE package to path
disp('Adding bilateral filtering package to MATLAB path...');
path(genpath(rootDistribDir),path);

% Compile mex code
disp('Compiling bilateral filtering package...');
mex mex_thread_bilateralFilter.c;
disp('Finished');