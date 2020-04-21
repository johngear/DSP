function[input,output] = liveProcessing(input,window_size,overlap,fade_length)
%% Real-Time Audio Stream Processing
%
% The Audio System Toolbox provides real-time, low-latency processing of
% audio signals using the System objects audioDeviceReader and
% dsp.AudioFileWriter.
%
% This example shows how to acquire an audio signal using your microphone,
% perform basic signal processing, and write your signal to a file.
%
%% Create input and output objects
% Use the sample rate of your input as the sample rate of your output.
fileReader = dsp.AudioFileReader(input);
fileWriter = dsp.AudioFileWriter('SampleRate',fileReader.SampleRate);
n = 1:1024;
n = [n' n'];
output = [];
current_window = [];
input = [];
fs = 44100;
frames = 1024*window_size;

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
 
bins = zeros(2,N);
 
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
bins(3,:) = notes;
 
names = ["A", "Bb", "B", "C", "Cs", "D", "Eb", "E", "F", "Fs", "G", "Gs"];
full_names = names;
for R = 1:total_oct_range-1
    full_names= horzcat(full_names,names);
end
 
all_inf = [notes;full_names;bins];



%% Code for stream processing
% Place the following steps in a while loop for continuous stream
% processing:
%   1. Call your audio device reader with no arguments to
%   acquire one input frame. 
%   2. Perform your signal processing operation on the input frame. 
%   3. Call your audio file reader with the processed frame
%   as an argument.
%    	Note: The file is named 'output.wav' and written to current folder by default. 
    
while ~isDone(fileReader)
    mySignal = fileReader();
    input = [input;mySignal];
    [current_window,output] = tune(mySignal,frames,bins,current_window,output,overlap,fade_length);
end
