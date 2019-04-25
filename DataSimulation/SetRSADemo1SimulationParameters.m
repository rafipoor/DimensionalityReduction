%noise level
% simulationOptions.NoiseLevel =10;
% number of runs
simulationOptions.nRuns  = 10;
% A triple containing the dimensions of the simulated RoI in voxels.
if ~exist('P','var')
    P = 7;
end
simulationOptions.volumeSize_vox = [P P P];
ROI{1}     = prod(simulationOptions.volumeSize_vox);
nRegions   = numel(ROI);

% A triple containing the dimensions of one voxel in mm.
simulationOptions.voxelSize_mm = [3 3 3.75];

% The number of repititions of each stimulus which is "presented" to each of the
% simulated subjects.
simulationOptions.nRepititions = 4;

% The duration of the stimulus presentation in seconds.
simulationOptions.stimulusDuration = 0.3;

% The duration of one trial in seconds.
simulationOptions.trialDuration = 3;

% The time for one TR in seconds.
simulationOptions.TR = 1.5; % seconds

% The amount of noise to be added by the simulated scanner. This corresponds to
% the square of the standard deviation of the gaussian distibution from which
% the noise is drawn (?).
simulationOptions.scannerNoiseLevel = 10000;

% A 4-tuple. The first three entries are the x, y and z values for the gaussian
% spatial smoothing kernel FWHM in mm and the fourth is the size of the temporal
% smoothing FWHM.
simulationOptions.spatiotemporalSmoothingFWHM_mm_s = [4 4 4 4.5];

% The specification for the clustering of conditions.
% This should be a cell array. Clustering of the conditions is done in the
% following manner:
%        - Each cell represents a hierarchy.
%        - The first entry in a cell is the 'spread' of that level of the
%          hierarchy.
%        - If the second entry is another cell, it and all following entries
%          (which must also be cells) are sub-hierarchies.
%        - If the second entry is a number (in which case there must only be
%          two entries), this number represents a number of 'leaves', such that
%          the cell is hierarchically an 'atom'.
% So we have a well-defined recursive datatype for hierarchies.
% For example,
%        clusterSpec = {20, {6, {3, 5},{2, 3}}, {4, 7}}
% represents the following hierarchy:
%                                  |
%                      ------------------------- 20
%                      |                      |
%               ------------- 6               |
%               |           |              ------- 4
%             ----- 3      --- 2           |||||||
%             |||||        |||             |||||||
%               [5]         [3]               [7]
simulationOptions.clusterSpec = ...
	{2, ...
		{1, ...
			{0.5, 16}, ...
			{0.5, 16} ...
		}, ...
		{1, ...
			{0.5, 16}, ...
			{0.5, 16} ...
		} ...
	};
