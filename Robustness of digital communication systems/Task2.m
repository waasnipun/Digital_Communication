%% TASK 2
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

%% 
N0 = 10^( -0.1* 10 );
std = sqrt(N0/2); 

%% Tranmit signal with impulse response as sinc function with AWGN

rolloff = 0;  % Rolloff factor - Sinc Filter
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(bpsk_sym);
noise = std*rand(size(filteredTx));
filteredTxnoise = filteredTx+noise;

figure; 
plot(t, (filteredTxnoise(t_f)));
title('Received signal with impulse response as sinc function with AWGN');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

eyeObj4 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- Sinc function pulse shaping filter with AWGN' ,...
    'YLimits', [-0.8 0.8]);
%eye diagram for transmitted signal 
eyeObj4(filteredTxnoise);

%% Tranmit signal with impulse response as raised cosine pulse shaping filter with AWGN

%with 0.5 roll-off factor
rolloff = 0.5;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(bpsk_sym);
noise = std*rand(size(filteredTx));
filteredTxnoise = filteredTx+noise;

figure; 
plot(t, (filteredTxnoise(t_f)));
title('Received signal with impulse response as raised cosine with 0.5 roll-off factor with AWGN');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;


eyeObj5 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
     'EnableMeasurements',true,...
    'Name' ,'Eye diagram- Raised cosine pulse shaping filter with AWGN - 0.5 roll-off factor', ...
    'YLimits', [-0.8 0.8]);

%eye diagram for transmitted signal 
eyeObj5(filteredTxnoise);

 %% Tranmit signal with impulse response as raised cosine pulse shaping filter with AWGN
%with 1 roll-off factor
rolloff = 1;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(bpsk_sym);
noise = std*rand(size(filteredTx));
filteredTxnoise = filteredTx+noise;

figure; 
plot(t, real(filteredTxnoise(t_f))); 
title('Received signal with impulse response as raised cosine with 1 roll-off factor with AWGN');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;


eyeObj6 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- Raised cosine pulse shaping filter with AWGN - 1 roll-off factor' ,...
    'YLimits', [-0.8 0.8]);

% eye diagram for transmitted signal 
eyeObj6(filteredTxnoise);
          