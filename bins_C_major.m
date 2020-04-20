%%GENERATES BINS for C Major Scale

a = 55; %low reference pitch
lowest_freq_possible = a - 10;
halfstep = 2.^(1/12); %an octave is defined as 2x the frequency. 12 half steps seperate octaves
 
past = a;
total_oct_range = 5;
N = 12 * total_oct_range; % total number of notes we are creating. 12 x 12 means 12 octave range
 
notes = zeros(1,N); %preallocates memory for better performance
notes(1) = a; 
 
for R = 2:N
     current = past .* halfstep;
     notes(R) = current;
     past = current;
end

names = ["A", "B", "C", "D", "E", "F", "G"];
full_names = names;

for R = 1:total_oct_range-1
    full_names= horzcat(full_names,names);
end

% remove notes not needed for MAJOR scale
% KEEP:     1 3 4 6 8 9 11
% REMOVE:   2 5 7 10 12
keep_notes = [1 0 1 1 0 1 0 1 1 0 1 0];
mask = keep_notes;

for R = 1:total_oct_range-1
    mask = horzcat(keep_notes,mask);
end

major_scale = mask.*notes;

for R = 1: (total_oct_range * 7)+1
    if major_scale(R) == 0;
       major_scale(R) = [];
       R = R-1;
    end
end

all_inf = [major_scale;full_names];

N = (total_oct_range * 7)+1;

for R = 2:(N-1)
     low_bound = ( notes(R) + notes(R-1) )./2;
     upper_bound = ( notes(R) + notes(R+1))./2;
     bins(1,R) = low_bound;
     bins(2,R) = upper_bound;
end
 
bins(2,1) = bins(1,2); %set the lowest bin max freq
bins(1,1) = lowest_freq_possible;
bins(1,end) = bins(2,end-1); %set the last bin min freq
bins(2,end) = bins(1,end) * 2; %set the last bin max freq
bins(3,:) = major_scale;
 
 
all_inf = [full_names;bins];