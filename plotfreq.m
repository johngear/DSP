function[] = plotfreq(input,output,N,fs)
pit = pitch(input,fs,'WindowLength',N);
pit2 = pitch(output,fs,'WindowLength',N); 
x = size(output);
window = 1:(fix(x(1,1)/N));
y1 = pit(window,1);
y2 = pit2(window,1);
plot(window,y1',window,y2')
xlabel('Window');
ylabel('Frequency (Hz)')
legend('input signal','output signal');


