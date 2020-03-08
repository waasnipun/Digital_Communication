import matplotlib.pyplot as plt 
import numpy as np 
import random
import math
import cmath 

N = 64
T = 1
Tb = 0.5
b = []
spacing = 1024
t = np.linspace(0,N,spacing)

#randomly generating the information signal
for i in range(2*N):
	b.append(random.SystemRandom().randint(0, 1))
print("b(Informaion Signal) :")
print(b)

#mapping bits into symbols and obtaining a complex symbol sequence and a 2D list and seperate
#parts for real and imaginary components

#notation 0 ---->  1
#		  1 ----> -1
x = []
real_x = []
imaginary_x = []
complex_numbers = [[1,1],[1,-1],[-1,1],[-1,-1]]
for i in range(0,int(2*N)-1,2):
	if b[i]==0 and b[i+1]==0:
		real_x.append(complex_numbers[0][0])
		imaginary_x.append(complex_numbers[0][1])
		x.append(complex_numbers[0])
	elif b[i]==0 and b[i+1]==1:
		real_x.append(complex_numbers[1][0])
		imaginary_x.append(complex_numbers[1][1])
		x.append(complex_numbers[1])
	elif b[i]==1 and b[i+1]==0:
		real_x.append(complex_numbers[2][0])
		imaginary_x.append(complex_numbers[2][1])
		x.append(complex_numbers[2])
	elif b[i]==1 and b[i+1]==1:
		real_x.append(complex_numbers[3][0])
		imaginary_x.append(complex_numbers[3][1])
		x.append(complex_numbers[3])
print("\nx(Mapped Complex symbol sequence) :")
print(([complex(i[0],i[1]) for i in x]))

print("\nRe{x[k]} :")
print(real_x)
print("\nIm{x[k]} :")
print(imaginary_x)

#plotting the information signal
plt.plot(b, color='blue', drawstyle='steps-post')
plt.xlabel('t')
plt.ylabel('m(t)')
plt.title(r'Information Signal')
plt.xlim([-5, 135])
plt.figure()

#making the real component of s(t)
temp_i = 0
E = 1 #phase noise factor
for i in range(N):
	temp_i+=(real_x[i]*np.cos((2*np.pi*i*t*E)/(N*T)) - imaginary_x[i]*np.sin((2*np.pi*i*t*E)/(N*T)))
I =	(1/math.sqrt(N*T))*temp_i

#plotting the real partof s(t) - I
plt.plot(t,I)
plt.xlabel('t')
plt.ylabel('I(t)')
plt.title(r'Real component of s(t)')
plt.xlim([-5, 65])
plt.figure()

#making the imaginary component of s(t)
temp_q = 0
for i in range(N):
	temp_q+=(real_x[i]*np.sin((2*np.pi*i*t*E)/(N*T)) + imaginary_x[i]*np.cos((2*np.pi*i*t*E)/(N*T)))
Q =	(1/math.sqrt(N*T))*temp_q

#plotting the imaginary partof s(t) 
plt.plot(t,Q)
plt.xlabel('t')
plt.ylabel('Q(t)')
plt.title(r'Imaginary component of s(t)')
plt.xlim([-5, 65])
plt.figure()

#magnitude of s(t)

mag_s = []
for i in range(spacing):
	mag_s.append(math.sqrt(math.pow(I[i],2)+math.pow(Q[i],2)))

#plotting the magnitude part of s(t) 
plt.plot(t,mag_s)
plt.xlabel('t')
plt.ylabel('|s(t)|')
plt.title(r'Magnitude of s(t)')							
plt.xlim([-5, 65])
plt.figure()

#phase if s(t)

alpha_t = []
for i in range(spacing):
	alpha_t.append(np.arctan(abs(Q[i])/abs(I[i])))
arg_t = []
for i in range(spacing):
	if Q[i]>0 and I[i]>0:
		arg_t.append(alpha_t[i])
	elif Q[i]>0 and I[i]<0:
		arg_t.append(np.pi-alpha_t[i])
	elif Q[i]<0 and I[i]<0:
		arg_t.append(-np.pi+alpha_t[i])
	elif Q[i]<0 and I[i]>0:
		arg_t.append(-alpha_t[i])

#plotting the phase part of s(t) 
plt.plot(t,arg_t)
plt.xlabel('t')
plt.ylabel('Arg|s(t)|')
plt.title(r'phase of s(t)')							
plt.xlim([-5, 65])
plt.figure()

#sampling of I(t)

sampled_i = []
for m in range(0,spacing,int((spacing/(N))*T)):
	sampled_i.append(I[m])
m = [i for i in range(N)]
#plotting the sampled real part of s(t) - I
plt.plot(t,I,color='green', linestyle='dashed')
plt.stem(m,sampled_i,linefmt='grey',use_line_collection = True)
plt.xlabel('t')
plt.ylabel('Re{s(mt)}')
plt.title(r'sampling the real component of s(t)')							
plt.xlim([-5, 65])
plt.figure()

plt.stem(m,sampled_i,linefmt='grey',use_line_collection = True)
plt.xlabel('m')
plt.ylabel('Re{s[m]}')
plt.title(r'Real component of s[m]')							
plt.xlim([-5, 65])
plt.figure()


#sampling of Q(t)

sampled_q = []
for m in range(0,spacing,int((spacing/(N))*T)):
	sampled_q.append(Q[m])
m = [i for i in range(N)]
#plotting the sampled real part of s(t) - I
plt.plot(t,Q,color='green', linestyle='dashed')
plt.stem(m,sampled_q,linefmt='grey',use_line_collection = True)
plt.xlabel('t')
plt.ylabel('Im{s(mt)}')
plt.title(r'sampling the imaginary component of s(t)')							
plt.xlim([-5, 65])
plt.figure()

plt.stem(m,sampled_q,linefmt='grey',use_line_collection = True)
plt.xlabel('m')
plt.ylabel('Im{s[m]}')
plt.title(r'Imaginary component of s[m]')							
plt.xlim([-5, 65])
plt.figure()


#sampling of |s(mt)|

sampled_mag = []
for m in range(0,spacing,int((spacing/(N))*T)):
	sampled_mag.append(mag_s[m])
m = [i for i in range(N)]
#plotting the sampled real part of s(t) - I
plt.plot(t,mag_s,color='green', linestyle='dashed')
plt.stem(m,sampled_mag,linefmt='grey',use_line_collection = True)
plt.xlabel('t')
plt.ylabel('|s(mt)|')
plt.title(r'sampling the magnitude of s(t)')							
plt.xlim([-5, 65])
plt.figure()

plt.stem(m,sampled_mag,linefmt='grey',use_line_collection = True)
plt.xlabel('m')
plt.ylabel('|s[m]|')
plt.title(r'Magnitude of s[m]')							
plt.xlim([-5, 65])
plt.figure()

#sampling of Arg{s(mt)}

sampled_ph = []
for m in range(0,spacing,int((spacing/(N))*T)):
	sampled_ph.append(arg_t[m])
m = [i for i in range(N)]
#plotting the sampled real part of s(t) - I
plt.plot(t,arg_t,color='green', linestyle='dashed')
plt.stem(m,sampled_ph,linefmt='grey',use_line_collection = True)
plt.xlabel('t')
plt.ylabel('Arg{s(mt)}')
plt.title(r'sampling the phase of s(t)')							
plt.xlim([-5, 65])
plt.figure()

plt.stem(m,sampled_ph,linefmt='grey',use_line_collection = True)
plt.xlabel('m')
plt.ylabel('Arg{s[m]}')
plt.title(r'Phase of s[m]')							
plt.xlim([-5, 65])
plt.figure()

#making s[m]
s_m = []
for i in range(N):
	s_m.append(complex(sampled_i[i],sampled_q[i]))

#applying discrete fourier transform to s[m]
def DFT(fx):
    fx = np.asarray(fx, dtype=complex)
    M = fx.shape[0]
    fu = fx.copy()

    for i in range(M):
        u = i
        sum = 0
        for j in range(M):
            x = j
            tmp = fx[x]*np.exp(-2j*np.pi*x*u*np.divide(1, M, dtype=complex))
            sum += tmp
        # print(sum)
        fu[u] = sum
    # print(fu)

    return (math.sqrt(T)/math.sqrt(N))*fu

arr = DFT(s_m)
recovered_signal_complex = []
for i in arr:
	recovered_signal_complex.append([int(round(i.real)),int(round(i.imag))])
print("\nrecovered signal:")
print(print(([complex(i[0],i[1]) for i in recovered_signal_complex])))

#recovering the information signal
#notation 1 ---->  0
#		  -1 ---->  1
recovered_information_signal = []
for i in recovered_signal_complex:
	if i[0] == 1:
		recovered_information_signal.append(0)
	elif i[0] == -1:
		recovered_information_signal.append(1)
	if i[1] == 1:
		recovered_information_signal.append(0)
	elif i[1] == -1:
		recovered_information_signal.append(1)
print("\nRecovered Information Signal")
print(recovered_information_signal)

#comparing the message signal and the recovered signal
count = 0
for i in range(N):
	if recovered_signal_complex[i]==x[i]:
		count+=1
print("\nAccuracy: "+str((count/N)*100)+"%")

#plotting the Recovered information signal
plt.plot(b, color='blue', drawstyle='steps-post')
plt.xlabel('t')
plt.ylabel('m(t)')
plt.title(r'RecoveredInformation Signal')
plt.xlim([-5, 135])
plt.show()