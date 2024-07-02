# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 14:04:14 2024

@author: campus4D039
"""
import numpy as np
import matplotlib.pyplot as plt

# 2차원 확률 분포
x_set = np.arange(2,13)
y_set = np.arange(1,7)
print(f"x_set : {x_set}\ny_set: {y_set}")

def f_XY(x,y):
    if 1<=y<=6 and 1<=x-y<=6: # 조건일 확률
        return y*(x-y) / 100
    else:
        return 0

XY = [x_set, y_set, f_XY] # 결합확률

prob = np.array([[ f_XY(x_i, y_j) 
                  for y_j in y_set] for x_i in x_set])
print(f"prob.shape[0] : {prob.shape[0]}\nprob.shape[1] : {prob.shape[1]}")
print(prob)

fig = plt.figure(figsize=(10,8))
ax = fig.add_subplot(111)

c = ax.pcolor(prob)
ax.set_xticks(np.arange(prob.shape[1]) + 0.5, minor=False)
ax.set_yticks(np.arange(prob.shape[0]) + 0.5, minor=False)
ax.set_xticklabels(np.arange(1,7), minor=False)
ax.set_yticklabels(np.arange(2,13), minor=False)

ax.invert_yaxis()
ax.xaxis.tick_top()
fig.colorbar(c,ax=ax)
plt.show()

print(np.all(prob >= 0)) # prob의 전체 합이 1인지 확인 -> 확률분포의 타당성 검증

# 주변 확률 분포
def f_X(x):
    return np.sum([f_XY(x,y_k) for y_k in y_set])

def f_Y(y):
    return np.sum([f_XY(x_k,y) for x_k in x_set])

X = [x_set, f_X]
Y = [y_set, f_Y]

prob_x = np.array([f_X(x_k) for x_k in x_set])
prob_y = np.array([f_Y(y_k) for y_k in y_set])

fig = plt.figure(figsize = (12,4))
# subplot 이미지 위치 알려주기 
# 121 1행에 2번째 열 가짐, 1번째
# 122 2번째
ax1 = fig.add_subplot(121) 
ax2 = fig.add_subplot(122)

# 이미지 세팅
ax1.bar(x_set, prob_x)
ax1.set_title('x-marginal probability')
ax1.set_xlabel('x_value')
ax1.set_ylabel('prob')

ax2.bar(y_set, prob_y)
ax2.set_title('y-marginal probability')
ax2.set_xlabel('y_value')
ax2.set_ylabel('prob')

plt.show()


print(np.sum([x_i * f_XY(x_i, y_j) for x_i in x_set for y_j in y_set]))

def E(XY, g):
    x_set, y_set, f_XY = XY
    return np.sum([g(x_i, y_j) * f_XY(x_i, y_j) for x_i in x_set for y_j in y_set])
'''
def lambda(x, y):
    return x
: x = 현재는 리턴 x, y만 한다 
'''
mean_x = E(XY, lambda x, y : x)
# 람다 : 특정 확률변수에 대한 값을 보고싶을 떄
# 함수 또 만들어서 식계산하는거 개귀찮으니까
print(mean_x)

mean_y = E(XY, lambda x, y : y)
print(mean_y)


# 1. XY 결합 이유 : 그냥 결합분포임 값1 값2 함수 구성
# 2. lambda x, y : x 면 x값이 2번 들어가는 거? ㄴㄴ 람다는 함수임 리턴 하나만 한다는 뜻
# 3. 주변 확률 분포 : 하나의 변수에 대한 확률분포를 추출함

# 평균 -> 분산으로 변수의 특성알 수 있다
# 공분산

# 2차원 분산 구하기
def V2(XY, g) :
    x_set, y_set, f_XY = XY
    mean = E(XY, g)
    return np.sum([(g(x_i, y_j)-mean)**2 * f_XY(x_i, y_j) for x_i in x_set for y_j in y_set])

def Cov(XY):
    x_set, y_set, f_XY = XY # 값 가져와서 3개로 나누어 넣음
    mean_x = E(XY, lambda x, y: x)
    mean_y = E(XY, lambda x, y: y)
    # x set, y set의 데이터 하나씩 가져와서 결과낸다 => 2차원
    return np.sum([(x_i - mean_x) * (y_j - mean_y) * f_XY(x_i, y_j) 
                   for x_i in x_set for y_j in y_set])

cov_xy = Cov(XY)
print(cov_xy)

# 공분산 -> 상관계수
# 기본 공식 : cov_xy/np.sqrt(var_x*var_y)
var_x = V2(XY, g=lambda x, y : x) # x분산값
var_y = V2(XY, g=lambda x, y : y) # y분산값
print(cov_xy/np.sqrt(var_x*var_y))






