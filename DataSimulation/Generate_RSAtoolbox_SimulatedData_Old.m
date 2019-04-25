clear;
close all;
nSubjects = 30;
SetRSADemo1SimulationParameters;
ConfigurationName = 'RSADemo1';
cd(fullfile(pwd,'rsatoolboxfunctions'));
FolderName = fullfile('..','..','Data',ConfigurationName);
mkdir(FolderName);
save(fullfile(FolderName,'SimulationOptions'));
for sID = 1:nSubjects
    [Signal,Data] = simulateClusteredfMRIData(simulationOptions);
    fName = fullfile(FolderName,sprintf('%03d',sID));
    save(fName,'Data','Signal');
end
cd('..');