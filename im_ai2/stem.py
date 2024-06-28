# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 13:16:48 2024

@author: campus4D039
"""
# 정규화
# stem 스테미 -> 알고리즘 : 포터 , 램커스터 -> 사전에 없는 말로 바꿔준다
# lemma 렘마 -> 기본형 단어로 바꿔 줌 영어는 she goes we go 동사가 달라지기 때문에 형태소 분석 시 의미 다르게 해석 가능해서
# 원형으로 고친다

from nltk.stem import LancasterStemmer, PorterStemmer
from nltk.tokenize import word_tokenize
# l_stem = LancasterStemmer()
# p_stem = PorterStemmer()

# print(p_stem.stem('cook'))
# print(p_stem.stem('cooking'))
# print(p_stem.stem('cookery'))

# print(l_stem.stem('cooking'))
# print(l_stem.stem('cooking'))
# print(l_stem.stem('cookery'))

text1 = "Cat, (Felis catus), domesticated member (felid) of the family Felidae. "
w_token = word_tokenize(text1.lower())

result = [l_stem.stem(word) for word in w_token]

print(text1)
print(w_token)
print(result)