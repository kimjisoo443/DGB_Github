# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 11:27:29 2024

@author: campus4D039
"""
# 쿠퍼스 : 말뭉치
from nltk.corpus import stopwords
from nltk.tokenize import RegexpTokenizer

en_stop = set(stopwords.words('english'))
# 불용어 179개
my_stop = ['i','go']
text1 = "Sorry, I couldn't go to movie yesterday"

re_tok = RegexpTokenizer("[\w']+")
token_sent = re_tok.tokenize(text1.lower())
# 소문자로 바꿔주고 정규화

# en_stop의 단어 들어있으면 제거
result_tok = [word for word in token_sent if word not in en_stop] # 리스트 내포
my_stop_result = [word for word in token_sent if word not in my_stop] # 리스트 내포

