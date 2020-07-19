clc;
clear;
close all;

k = power(10,5); %size of the binary bit stream
BER_array = zeros(15,1);
en_ratio = -5:10; %  symbols energy to noise ratio in dB

%Question 1
tx_bitStream = randi([0 1],k,1);
tx_sym = zeros(k,1);

for j = 1:k
    if tx_bitStream(j) == 0
        tx_sym(j) = 1;
    else
        tx_sym(j) = i;
    end
end


% Question 6

for j  = 1:16
    N0 = power(10,-0.1*en_ratio(j));
    BER = find_BER(k,N0,tx_bitStream,tx_sym);
    BER_array(j) = BER;
end
BER_array

figure;
semilogy(en_ratio,BER_array,'b');
hold on;
title('BER vs. Es/N0');
xlabel('E_s/N_0 (dB)'); ylabel('BER');
xlim([-6 11])
grid on;

%Question 7
y_q = zeros(15,1);
for j = 1:16
    y_q(j) = qfunc(sqrt(10^(en_ratio(j)/10)));
end  
y_q
plot(en_ratio,y_q,'ro');
legend('BER','function Q(Analytical)');



