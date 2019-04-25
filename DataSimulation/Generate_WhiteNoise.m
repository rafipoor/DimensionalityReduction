clear;
MaxSubjects  = 30;
MaxSamples   = 96;   % number of points
MaxVoxels    = 343;  % dimension of emmbedding space
NoiseMu    = zeros(MaxVoxels,1);
NoiseSigma = eye(MaxVoxels);

WhiteNoise = zeros(MaxSamples,MaxVoxels,MaxSubjects);
for i=1:MaxSubjects
    WhiteNoise(:,:,i) = mvnrnd(NoiseMu,NoiseSigma,MaxSamples);
end

save('WhiteNoise','WhiteNoise');
