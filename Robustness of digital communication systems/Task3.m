%% TASK 3
clc;
clear;
close all;


Fs = 1000;     % Sample rate
Rb = 100;       % Symbol rate
sps = Fs/Rb;    % Samples per symbol        
M=2;

n = 1000;%number of transmiting bits
message = randi([0 M-1],1,2*n);
modulated = zeros(1,n);      %generate 4 PAM signal
for i = 1:n
    if (message(2*i-1:2*i) == [0,0])
        modulated(i) = -1.5;
    elseif (message(2*i-1:2*i) == [0,1])
        modulated(i) = -0.5;
    elseif (message(2*i-1:2*i) == [1,0])
        modulated(i) = 0.5;
    elseif (message(2*i-1:2*i) == [1,1])
        modulated(i) = 1.5;
    end
end

t1 = 0:1:n-1;
figure
stem((modulated),'filled');
title('Impulse Train - 4-PAM');
xlim([0 100]);
ylim([-1.6 1.6]);
grid;

t = 0:1/Fs:50/Rb-1/Fs; idx = round(t*Fs+1);
modulated=transpose(modulated);
%% Tranmit signal with impulse response as sinc function

rolloff = 0;  % Rolloff factor - Sinc Filter
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(modulated);

figure; 
plot(t, real(filteredTx(idx)));
title('Transmitted signal with impulse response as sinc function');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

eyeObj1 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- 4-PAM - Sinc function pulse shaping filter ' ,...
    'YLimits', [-1 1]);
%eye diagram for transmitted signal 
eyeObj1(filteredTx);


%% Tranmit signal with impulse response as raised cosine pulse shaping filter
%with 0.5 roll-off factor
rolloff = 0.5;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(modulated);

figure; 
plot(t, real(filteredTx(idx)));
title('Transmitted signal with impulse response as raised cosine with 0.5 roll-off factor');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;


eyeObj2 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
     'EnableMeasurements',true,...
    'Name' ,'Eye diagram- 4-PAM - Raised cosine pulse shaping filter - 0.5 roll-off factor', ...
    'YLimits', [-0.8 0.8]);

%eye diagram for transmitted signal 
eyeObj2(filteredTx);

               
%% Tranmit signal with impulse response as raised cosine pulse shaping filter
%with 1 roll-off factor
rolloff = 1;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(modulated);

figure; 
plot(t, real(filteredTx(idx)));
title('Transmitted signal with impulse response as raised cosine with 1 roll-off factor');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;


eyeObj3 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- 4-PAM - Raised cosine pulse shaping filter - 1 roll-off factor' ,...
    'YLimits', [-0.8 0.8]);

% eye diagram for transmitted signal 
eyeObj3(filteredTx);

                
                
 %% With Noise               
%% noise
Eb_1 = 15*( 1 ^2) /24;
gamma_1 = 10;
N0 = Eb_1 *10^( -0.1* gamma_1 );
std = sqrt(N0/2); 
%% Tranmit signal with impulse response as sinc function with AWGN

rolloff = 0;  % Rolloff factor - Sinc Filter
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(modulated);
noise = std*rand(size(filteredTx));
filteredTxnoise = filteredTx+noise;

figure; 
plot(t, real(filteredTxnoise(idx)));
title('Received signal with impulse response as sinc function with AWGN');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

eyeObj4 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- 4-PAM - Sinc function pulse shaping filter with AWGN' ,...
    'YLimits', [-0.8 0.8]);
%eye diagram for transmitted signal 
eyeObj4(filteredTxnoise);

%% Tranmit signal with impulse response as raised cosine pulse shaping filter with AWGN

%with 0.5 roll-off factor
rolloff = 0.5;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(modulated);
noise = std*rand(size(filteredTx));
filteredTxnoise = filteredTx+noise;

figure; 
plot(t, real(filteredTxnoise(idx)));
title('Received signal with impulse response as raised cosine with 0.5 roll-off factor with AWGN');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;


eyeObj5 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
     'EnableMeasurements',true,...
    'Name' ,'Eye diagram- 4-PAM - Raised cosine pulse shaping filter with AWGN - 0.5 roll-off factor', ...
    'YLimits', [-0.8 0.8]);

%eye diagram for transmitted signal 
eyeObj5(filteredTxnoise);

 %% Tranmit signal with impulse response as raised cosine pulse shaping filter with AWGN
%with 1 roll-off factor
rolloff = 1;  % Rolloff factor 
transmitFilter = comm.RaisedCosineTransmitFilter('RolloffFactor', rolloff, ...
    'OutputSamplesPerSymbol', sps);
filteredTx = transmitFilter(modulated);
noise = std*rand(size(filteredTx));
filteredTxnoise = filteredTx+noise;

figure; 
plot(t, real(filteredTxnoise(idx))); 
title('Received signal with impulse response as raised cosine with 1 roll-off factor with AWGN');
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;


eyeObj6 = comm.EyeDiagram(...
    'SampleRate', Fs, ...
    'SamplesPerSymbol', sps, ...
    'DisplayMode', 'Line plot', ...
    'EnableMeasurements',true,...
    'Name' , 'Eye diagram- 4-PAM - Raised cosine pulse shaping filter with AWGN- 1 roll-off factor' ,...
    'YLimits', [-0.8 0.8]);

% eye diagram for transmitted signal 
eyeObj6(filteredTxnoise);
           