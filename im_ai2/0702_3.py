# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 15:01:21 2024

@author: campus4D039
"""
# 베르누이 효과  
    # 확률에서 취할 것이 0과 1밖에 없는 것 False True
# 이항분포
    # n번 실행했을 때 분호값에 따른 것

import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

# 그래프 선의 종류
linestyles = ['-', '--', ':']
def E(X, g=lambda x: x):
    x_set, f = X
    return np.sum([g(x_k) * f(x_k) for x_k in x_set])

def V(X, g=lambda x: x):
    x_set, f = X
    mean = E(X, g)
    return np.sum([(g(x_k)-mean)**2 * f(x_k) for x_k in x_set])

def check_prob(X):
    x_set, f = X
    prob = np.array([f(x_k) for x_k in x_set])
    assert np.all(prob >= 0), 'minus probability'
    prob_sum = np.round(np.sum(prob), 6)
    assert prob_sum == 1, f'sum of probability{prob_sum}'
    print(f'expected value {E(X):.4}')
    print(f'variance {(V(X)):.4}')
    
def plot_prob(X):
    x_set, f = X
    prob = np.array([f(x_k) for x_k in x_set])
    fig = plt.figure(figsize=(10, 6))
    ax = fig.add_subplot(111)
    ax.bar(x_set, prob, label='prob')
    ax.vlines(E(X), 0, 1, label='mean')
    ax.set_xticks(np.append(x_set, E(X)))
    ax.set_ylim(0, prob.max()*1.2)
    ax.legend()
    plt.show()
    
# 베르누이 분포 함수
def Bern(p):
    x_set = np.array([0, 1])
    def f(x):
        if x in x_set:
            return p ** x * (1-p) ** (1-x)
        else:
            return 0
    return x_set, f

p = 0.3
X = Bern(p) # 기대값
check_prob(X) # 분산값
plot_prob(X)

# 이때까지 구현한 함수들 scipy라이브러리에 있음
from scipy.stats import bernoulli
vr = bernoulli(p)
print(vr.pmf(0), vr.pmf(1)) 
print(vr.cdf([0,1]))
print(vr.mean())
print(vr.var())

# 이항 분포
# 독립적으로 뭔가 시행할 때, 성공 실패(베르누이) 정해져 있고
# 시행 횟수 정해져 있는데 내가 몇번 성공하는지
from scipy.special import comb

def Bin(n,p):
    x_set = np.arange(n+1)
    def f(x):
        if x in x_set:
            return comb(n, x) * p ** x * (1-p) ** (n-x)
        else:
            return 0
    return x_set, f

n = 10
X = Bin(n,p)
check_prob(X)
plot_prob(X)

fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111)

x_set = np.arange(n+1)
for p, ls in zip([0.3, 0.5, 0.7], linestyles):
    rv = stats.binom(n, p)
    ax.plot(x_set, rv.pmf(x_set),
            label=f'p:{p}', ls=ls, color='gray')
ax.set_xticks(x_set)
ax.legend()

plt.show()

# 기하분포
# n번 시행했을 때 처음에 성공할 확률
def Ge(p):
    x_set = np.arange(1,30)
    def f(x):
        if x in x_set: # 이 안에 들어있는 값이라면
            return p * (1-p) ** (x-1) # p : 확률(기대값) 
        else:
            return 0
    return x_set, f

p = 0.5
X = Ge(p)
check_prob(X)
plot_prob(X)

# scipy 라이브러리 사용
fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111)
x_set = np.arange(1, 15)
for p, ls in zip([0.2, 0.5, 0.8], linestyles):
    rv = stats.geom(p)
    ax.plot(x_set, rv.pmf(x_set),
            label=f'p:{p}', ls=ls, color='gray')
ax.set_xticks(x_set)
ax.legend()
plt.show()
# p값에 따라 처음 시도시 성공할 확률이 변하는 것 확인 가능


# 푸아송 분포
# 실패할 가능성을 기대값으로 잡고
# 실패는 임의의 시점에 일어난다 가정
# ex. 기계가 오작동발생할 때 특정 기간동안(조건) 언제 고장날지 
from scipy.special import factorial # 팩토리얼 사용함

def Poi(lam):
    x_set = np.arange(20)
    def f(x):
        if x in x_set:
            return np.power(lam, x) / factorial(x) * np.exp(-lam)
        else:
            return 0
    return x_set, f

lam = 3 
X = Poi(lam)

check_prob(X)
plot_prob(X)

fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111)

x_set = np.arange(20)
for lam, ls in zip([3, 5, 8], linestyles):
    rv = stats.poisson(lam)
    ax.plot(x_set, rv.pmf(x_set),
            label=f'lam:{lam}', ls=ls, color='gray')
ax.set_xticks(x_set)
ax.legend()

plt.show()

