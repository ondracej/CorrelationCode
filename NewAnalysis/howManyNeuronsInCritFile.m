function [] = howManyNeuronsInCritFile()


%load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimAllCriteriaMet.mat');
%load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimAllCriteriaNOTMet.mat');
%load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimAllStimNOTMet.mat');

load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllCriteriaMet.mat');
load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllCriteriaNOTMet.mat');
load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllStimNOTMet.mat');


%%
data = AllCriteriaMet_Final;
nels = numel(data);

for j = 1:nels
    ncels(j) = numel(data(j).sigLevel_spont);
end

data2 = AllCriteriaNOTMet_Final;
nels = numel(data2);

for j = 1:nels
    ncels2(j) = numel(data2(j).sigLevel_spont);
   
end

data3 = AllStimsNOTMet_Final;
nels = numel(data3);

for j = 1:nels
    ncels3(j) = numel(data3(j).rawDataChan);
end


metCrit = sum(ncels);
notmetCrit = sum(ncels2);
nostimCrit = sum(ncels3);

%% For the non stationary neurons

cnt = 1;
cnnt = 1;
nels = numel(data2);
for j = 1:nels
    ncels2 = numel(data2(j).sigLevel_spont);

    for k = 1:ncels2
        
        SpontDiff(cnt) = diff(data2(j).WN_mean_spont{1, k});
        cnt = cnt +1;
        
        StimDiff(cnnt) = diff(data2(j).WN_mean_stim{1, k});
        cnnt = cnnt +1;
    end
end

%%
cnt = 1;
cnnt = 1;
cnnnt = 1;
for c = 1:numel(SpontDiff)
    
    thisDiffSpont = SpontDiff(c);
    thisStimDiff = StimDiff(c);
    
    if thisDiffSpont > 0 && thisStimDiff > 0
        
        posIncreas(cnt) = c;
        
        cnt  = cnt +1;
    elseif thisDiffSpont <0 && thisStimDiff < 0
        
        negDecreas(cnnt) = c;
        cnnt = cnnt +1;
        
    else
        other(cnnnt) = c;
        cnnnt = cnnnt+1;
    end
    
end

decreaseInFR = numel(find(SpontDiff >0));

        
        disp('')
end


