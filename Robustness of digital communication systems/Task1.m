%% TASK 1
clc;
clear;

Fs = 1000;     % Sample rate
Rb = 100;       % Symbol rate
sps = Fs/Rb;    % Samples per symbol

%% Generating impulse train
n = 1000;   %number of transmiting bits
bit_stream=randi([0 1],n,1);
bpsk_sym=zeros(n,1);
for i=1:n
    if bit_stream(i)==0
        bpsk_sym(i)= -1;
    else
        bpsk_sym(i)= 1;
    end
end
figure;
stem(bpsk_sym,'filled');
title('Impulse Train-BPSK');
ylim([-1.2 1.2]);
xlim([0 100]);

t = 0:1/Fs:50/Rb-1/Fs; 
t_f = round(t*Fs+1);
  
%% Tranmit signal with impulse response as sinc function

rolloff = 0;  % Rolloff factor - Sinc Filter
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(bpsk_sym);

figure; 
plot(t, filteredTx(t_f));
title('Transmitted signal with impulse response as sinc function');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

eyeObj1 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram - Sinc function pulse shaping filter' ,...
    'YLimits', [-0.8 0.8]);
%eye diagram for transmitted signal 
eyeObj1(filteredTx);

%% Tranmit signal with impulse response as raised cosine pulse shaping filter
%with 0.5 roll-off factor
rolloff = 0.5;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(bpsk_sym);

figure; 
plot(t, filteredTx(t_f));
title('Transmitted signal with impulse response as raised cosine - 0.5 roll-off factor');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

eyeObj2 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' ,'Eye diagram- Raised cosine pulse shaping filter - 0.5 roll-off factor', ...
    'YLimits', [-0.8 0.8]);

%eye diagram for transmitted signal 
eyeObj2(filteredTx);
         
%% Tranmit signal with impulse response as raised cosine pulse shaping filter
%with 1 roll-off factor
rolloff = 1;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(bpsk_sym);

figure; 
plot(t, filteredTx(t_f));
title('Transmitted signal with impulse response as raise cosing - 1 roll-off factor');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

eyeObj3 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- Raised cosine pulse shaping filter - 1 roll-off factor' ,...
    'YLimits', [-0.8 0.8]);

% eye diagram for transmitted signal 
eyeObj3(filteredTx);   