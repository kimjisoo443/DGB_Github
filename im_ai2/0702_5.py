# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 17:09:07 2024

@author: campus4D039
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats

df = pd.read_csv('C:/Users/campus4D039/Documents/GitHub/DGB_Github/im_ai2/ch4_scores400.csv')
scores = np.array(df['score'])

# 평균, 분산 값 계산
p_mean = np.mean(scores)
p_var = np.var(scores)

# plot
fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111)

xs = np.arange(101)
rv = stats.norm(p_mean, np.sqrt(p_var))
ax.plot(xs, rv.pdf(xs), color='gray')
ax.hist(scores, bins=100, range=(0, 100), density=True)

plt.show()

# 표본추출
np.random.seed(0) # 시드값은 마음대로 설정가능 나는 0
n = 20
sample = np.random.choice(scores, n)
print(sample)

np.random.seed(50)
n_sample = 100000
samples = np.random.choice(scores, (n_sample, n))
print(samples)

# 표본평균에 대한 평균 = 모평균

# 5개만 뽑음 - 표본평균
for i in range(5):
    s_mean = np.mean(samples[i])
    print(f'{i+1}번째 표본평균 : {s_mean:.3f}')

# 모평균    
sample_means = np.mean(samples, axis=1)
print(np.mean(sample_means))

# 구간 더 늘어날때 어떻게 되는지
print(np.mean(np.random.choice(scores,int(1e6)))) # 백만개
# 백만개 가지고 봤을 때 기존 모평균이 타당한지에 대한 검증

s_mean = np.mean(sample)
print(s_mean)

for i in range(5):
    s_var = np.var(samples[i])
    print(f'{i+1}번째 표본분산 : {s_var:.3f}')
    
sample_vars = np.mean(samples, axis=1)
print(np.mean(sample_vars)) # 모분산의 불편차등량?
# 시드값 바꿈에 따라 값 바뀜

u_var = np.var(sample, ddof=1)
print(u_var)

# 불편성 : 기대값이 추측하기 원하는 모수가 되는 수
# 일치성

 
