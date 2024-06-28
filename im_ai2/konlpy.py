# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 14:18:11 2024

@author: campus4D039
"""
# 한글 라이브러리 사용
# konlpy

text1 = '''
나 보기가 역겨워
가실 때에는
말없이 고이 보내 드리우리다

영변에 약산(藥山)
진달래꽃
아름 따다 가실 길에 뿌리우리다

가시는 걸음걸음
놓인 그 꽃을
사뿐히 즈려밟고 가시옵소서

나 보기가 역겨워
가실 때에는
죽어도 아니 눈물 흘리우리다
'''

import nltk 
from nltk.tokenize import word_tokenize
import konlpy
from konlpy.tag import Okt
# OKt : 형태소 분석기 중 트위터에서 만든 거

w_token = word_tokenize(text1)
print(w_token)

t = Okt()
print("형태소 : ", t.morphs(text1))
# 한국어의 가장 작은 단위
print("명사 : ", t.nouns(text1))
# 명사만 따로 추출 가능
print("pos",t.pos(text1))
# 형태소에 태그 달아놓음
