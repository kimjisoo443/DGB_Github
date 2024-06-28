# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 13:44:07 2024

@author: campus4D039
"""

# 품사 태거
import nltk
from nltk.tokenize import word_tokenize

text1 = "Cat domesticated member felid of the family Felidae. "
w_token = word_tokenize(text1.lower())


my_tag = ['NN','NNS','NNP']
my_word = [word for word, tag in nltk.pos_tag(w_token) if tag in my_tag]
print(my_word)

custom_my_word = ['/'.join(item) for item in nltk.pos_tag(w_token)]
print(custom_my_word)
# 단어/태그 이렇게 나옴

#result = [l_stem.stem(word) for word in w_token]

# <내가 생각한 태그 분류 방법>
# 리스트 접근 - 튜플 접근 - 튜플 2번째 받아옴 
# 비교 - nn 이면
# 리스트에 튜플 1번째 에팬드
# <강사님 방법>
# 리스트 컴프리핸드 써서 word, tag로 tag값 비교해서 word만 받아온다
word, tag = nltk.pos_tag(w_token)[0]
print(word,tag)
print(nltk.pos_tag(w_token)[0])

# a,b =(a, b) 이렇게 받을 수 있다