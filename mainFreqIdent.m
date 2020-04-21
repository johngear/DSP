function[outFreq, difference] = mainFreqIdent(freq, bins)
 
n = length(bins); %total number of freq bins
 
for i = 1:n
    if((freq > bins(1,i)) && (freq < (bins(2,i))))
        break
    end
end
 
% i is the bin we are in 
outFreq = bins(3,i);
if freq == -1 %accounts situation where we cannot find dominant frequency from transformed data
    outFreq = 0;
end

difference = outFreq - freq; 
