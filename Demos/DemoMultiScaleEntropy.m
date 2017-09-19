%	OVERVIEW:
%       Compute the MultiScale Entropy using RR intervals generated by
%       RRgen
%   OUTPUT:
%       Generates a file containing the Multiscale Entropy values
%
%   DEPENDENCIES & LIBRARIES:
%       HRV_toolbox https://github.com/cliffordlab/hrv_toolbox
%       WFDB Matlab toolbox https://github.com/ikarosilva/wfdb-app-toolbox
%       WFDB Toolbox https://physionet.org/physiotools/wfdb.shtml
%   REFERENCE: 
%	REPO:       
%       https://github.com/cliffordlab/hrv_toolbox
%   ORIGINAL SOURCE AND AUTHORS:     
%       Main script written by Giulia Da Poian
%       Dependent scripts written by various authors 
%       (see functions for details)       
%	COPYRIGHT (C) 2016 
%   LICENSE:    
%       This software is offered freely and without warranty under 
%       the GNU (v3 or later) public license. See license file for
%       more information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc; close all;
HRVparams = InitializeHRVparams('demo');   % Initialize settings for demo

% Check existence of Input\Output data folders and add to search path

if  isempty(HRVparams.readdata) || ~exist([pwd filesep HRVparams.readdata], 'dir')    
    error('Invalid data INPUT folder');    % If folder name is empty
end
addpath(HRVparams.readdata)


HRVparams.writedata = [HRVparams.writedata filesep 'MultiscaleEntropy'];
if ~exist(HRVparams.writedata, 'dir')
   mkdir(HRVparams.writedata)
end
addpath(HRVparams.writedata)

%% 1. Generate Data using RRgen

rr = rrgen(HRVparams.demo.length,HRVparams.demo.pe,HRVparams.demo.pn,HRVparams.demo.seed);
t = cumsum(rr);

%% 2. Preprocess RR Data - Using HRV Toolbox
% Remove noise, Remove ectopy, Don't detrend (yet)
[NN, tNN, fbeats] = RRIntervalPreprocess(rr,t,[], HRVparams);

%% 3. Calculate the Multiscale Entropy

fprintf('Computing MSE...this may take a few minutes...\n')
fprintf('Parameters used to calculate SempEntropy: m=%i r=%.2f \n', HRVparams.MSE.MSEpatternLength, HRVparams.MSE.RadiusOfSimilarity);
mse = ComputeMultiscaleEntropy(NN,HRVparams.MSE.MSEpatternLength, HRVparams.MSE.RadiusOfSimilarity, HRVparams.MSE.maxCoarseGrainings);
fprintf('MSE completed!\n')
plot(mse)
xlabel('Scale Factor');
ylabel('SampEn');

%% 4. Save Results


results = mse;
col_titles = {'MSE'};

% Generates Output - Never comment out
resFilename = GenerateHRVresultsOutput('MSE_RRgenDemoData',[],results,col_titles, 'MSE', HRVparams, tNN, NN);


%clearvars NN tNN t rr sqi ac dc ulf vlf lf hf lfhf ttlpwr methods fdflag NNmean NNmedian NNmode NNvariance NNskew NNkurt SDNN NNiqr RMSSD pnn50;

fprintf('A file named %s.%s \n has been saved in %s \n', ...
    resFilename,HRVparams.output.format, HRVparams.writedata);


