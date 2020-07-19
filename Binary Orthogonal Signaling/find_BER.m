function BER = find_BER(k,N0,tx_bitStream,tx_sym)

s = [1+0i 0+1i];
m = 2;

%Question 2
std = sqrt(N0/2); %standard deviation for noise
n = complex(std*randn(k,1),std*randn(k,1)); %random noise array
% figure;plot(n,'+');
% title('Noise');
% xlabel('Real Axis'); ylabel('Imag Axis');
% 
% %Question 3
r = tx_sym+n;
% figure;plot(r,'+');
% title('Received Symbols');
% xlabel('Real Axis'); ylabel('Imag Axis');


%Question 4
rx_sym = zeros(k,1);
%determining the trasnmitted symbols
for j = 1:k
    distance = zeros(m,1);
    for l = 1:m
        distance(l) = abs(r(j)-s(l));
    end
    [min_dist index] = min(distance);
    rx_sym(j) = s(index);
end
%determining the trasnmitted bitstream
rx_bitStream = zeros(k,1);
for k = 1:k
    if rx_sym(k) == complex(1,0)
        rx_bitStream(k) = 0;
    else
        rx_bitStream(k) = 1;
    end
end


%Question 5
%calculating the number of error bits and BER
error_bits = 0;
for j = 1:k
    if tx_bitStream(j) ~= rx_bitStream(j)
        error_bits = error_bits + 1;
    end
end
BER = error_bits/k;