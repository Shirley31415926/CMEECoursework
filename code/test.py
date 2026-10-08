#! /usr/bin/env python3
# Author: Shirley Huang <xh2026@ic.ac.uk>
# Script: test.py
# Argument: None
# Date: Oct 2026

a = [1, 2, 3]
b = a[:]  # This is a "shallow" copy; one level deep
print(b)

a.append(4)
print(a)
print(b)
a[0] = 11
print(a)
print(b)

#0
a = [[1, 2, 3], [4, 5, 6]]
b = a[:]  #只copy了一层，深一层还是随着a的变化而变化
a[0][1] = 22
print(a)
print(b)
#1
import copy
a = [[1, 2, 3], [4, 5, 6]]
b = copy.deepcopy(a) # 深度复制，完全独立
a[0][1] = 22
print(a)
print(b)

### String ###
s = " this is a string "
len(s) 
s.replace(" ","-") 
s.find("s")
s.count("s")
t = s.split()
t
s.upper() #remove trailing spaces  去除尾部空格
s.upper().strip()
'wOrD'.lower()

x = 11
for i in range(x):
    if i > 3:
        print(i)


for i in range(10):
    print(i)

a = range(10)
print(a)

for i in range(2, 10, 2): #进两位
    print(i)

my_iterable = [1, 2, 3, 4]
type(my_iterable)
my_iterator = iter(my_iterable)
type(my_iterator)
next(my_iterator)       #1 可选1/2
my_iterator.__next__()  #2

# Loops examples
for i in range(5):
    print(i)

my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)

total = 0 
summands = [0,1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)

z = 0
while z < 100:
    z = z + 1


z = 0
while z < 100:
     print(z)
     z += 1

x = 0; y = 2

if x < y:
    print("yes")

if x == 0:
    print("yes")

x = True
if x:
    print("yes")

def foo(x):
    x *= x # same as x = x*x
    print (x)
    return x

foo(3)

y = foo(2)
y
type(y)

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)

my_list = [1, 2, 3]
print('before, my_list =', my_list)


modify_list_1(my_list)

def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list
my_list = modify_list_2(my_list)
print('after, my_list =', my_list)

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) # an actual modification of the list
    print('changed to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)
modify_list_3(my_list)
print('after, my_list =', my_list)

heights_m = [1.75, 1.68, 1.71, 1.89, 1.79]
above_threshold = 0
for h in heights_m:
    if h > 1.75:
        above_threshold += 1
print(above_threshold)

def count_above(heights_m, threshold_m):
    above_threshold = 0
    for h in heights_m:
        if h > threshold_m:
            above_threshold += 1
    return above_threshold

assert count_above([1.75, 1.68, 1.71, 1.89, 1.79], 1.75) == 3   
assert count_above([10], 10) == 0

