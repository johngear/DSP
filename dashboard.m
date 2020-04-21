%%Stereo file to be modified. Ex: 'dsp_SONG.wav'
input_file = 'drone.wav'; 

%%Size of the window in frames. Each frame has 1024 samples 
window_size = 10; 

%%Overlap percentage in decimal form (20% overlap = .2)
overlap = .2;

%%fade length in number of samples per fade-in and fade-out
fade_length = 128;

%%Call processing function and saving the input and output
[input,output] = liveProcessing(input_file,window_size,overlap,fade_length);

%%Writing output file to output.wav
fileWriter = dsp.AudioFileWriter('SampleRate',44100);
fileWriter(output);

%%Uncomment to play input audio

% player = audioplayer(input,fs);
% play(player);
% pause 

%%Uncomment to play output audio

player = audioplayer(output,44100);
play(player)

%%Uncomment to plot the pitch of each signal during each window  
% plotfreq(input,output,window_size*1024,44100);
