import numpy as np 
import matplotlib.pyplot as plt 
import random
import math

N = 64
T = 1
Tb = 0.5
b = []
spacing = 1000
t = np.linspace(0,2*N,spacing)
print(t)
#randomly generating the information signal
for i in range(2*N):
	b.append(random.SystemRandom().randint(0, 1))
print("b :")
print(b)

#mapping bits into symbols and obtaining a complex symbol sequence and a 2D list and seperate
#parts for real and imaginary components
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
print("x :")
print(x)

print(real_x)
print(imaginary_x)

#plotting the information signal
plt.plot(b, color='blue', drawstyle='steps-post')
plt.xlabel('t')
plt.ylabel('m(t)')
plt.title(r'Information Signal')
plt.xlim([0, 65])
plt.figure()

#making the real component of s(t)
temp_i = 0
for i in range(N):
	temp_i+=(real_x[i]*np.cos((2*np.pi*i*t)/(N*T)) - imaginary_x[i]*np.sin((2*np.pi*i*t)/(N*T)))
I =	(1/math.sqrt(N*T))*temp_i

#plotting the real partof s(t) - I
plt.plot(t,I)
plt.xlabel('t')
plt.ylabel('I(t)')
plt.title(r'Real component of s(t)')
plt.xlim([0, 65])
plt.figure()

#making the imaginary component of s(t)
temp_q = 0
for i in range(N):
	temp_q+=(real_x[i]*np.sin((2*np.pi*i*t)/(N*T)) + imaginary_x[i]*np.cos((2*np.pi*i*t)/(N*T)))
Q =	(1/math.sqrt(N*T))*temp_q

#plotting the imaginary partof s(t) - I
plt.plot(t,Q)
plt.xlabel('t')
plt.ylabel('Q(t)')
plt.title(r'Imaginary component of s(t)')
plt.xlim([0, 65])
plt.figure()

#magnitude of s(t)

mag_s = []
for i in range(spacing):
	mag_s.append(math.sqrt(math.pow(I[i],2)+math.pow(Q[i],2)))

#plotting the magnitude part of s(t) - I
plt.plot(t,mag_s)
plt.xlabel('t')
plt.ylabel('|s(t)|')
plt.title(r'Magnitude of s(t)')
plt.xlim([0, 65])
plt.show()