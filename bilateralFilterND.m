%% BILATERALFILTERND
% This function will apply a bilateral filter to intput volume in
% N-Dimmensions according to the methods described in:
% C. Tomasi and R. Manduchi
% "Bilateral Filtering for Gray and Color Images"
% Proceedings of the 1998 IEEE International Conference on Computer Vision
%
% Inputs:
% unfiltVol: non-complex noisy image
% filt_radius: filter radius
% proximity_sigma: geometric standard deviation 
% intensity_sigma: photometric standard deviation
% n_threads: number of threads to use
%
% Output:
% filtVol: filtered version of input "vol"
% 
% NOTE: This code is just a simple wrapper function to the underlying MEX
% function mex_thread_bilateralFilter, which assumes filtVol is already
% allocated. Using the MEX function directly is useful in applications
% where the volume is preallocated. 
%
% Author: Scott Haile Robertson

function varargout = bilateralFilterND(varargin)
% Parse inputs
unfiltVol = varargin{1};
filt_radius = varargin{2};
proximity_sigma = varargin{3};
intensity_sigma = varargin{4};
n_threads = varargin{5};

% Check if input is complex
if(~isreal(unfiltVol))
    % Warn if complex data is provided, then filter magnitude and phase
    % separately, then recombine. CAUTION - this will not work if phase
    % wraps are present
    warning(['Complex input volume detected - filtering '...
        'only the magnitude signal!']);
    unfiltVol = abs(unfiltVol);
end

% Allocate output matrix 
filtVol = zeros(size(varargin{1}));
    
% Apply bilateral filter
mex_thread_bilateralFilter(unfiltVol, filtVol, filt_radius, proximity_sigma, intensity_sigma, uint32(n_threads));

% Return result
varargout{1} = filtVol;
end