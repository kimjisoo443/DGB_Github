# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 11:11:57 2024

@author: campus4D039
"""
# 정규표현식
from nltk.tokenize import RegexpTokenizer
rg_token = RegexpTokenizer("[\w']+")
# 문자 숫자 언더바 어퍼스트로피(') 까지 포함하고 이외의 내용들은 다 지우겠다
# [\w']{3,} 3자이상
# [\w]+
sent1 = "It's very good. Oh! yes~ ha_ha. ki-ki"
#print(rg_token.tokenize())

print(rg_token.tokenize(sent1.lower()))
# upper, lower
# 대문자 소문자 섞여있는데 기본 헝태인데 
# 언어에서는 대소문자 다르게 인식하니까 한번에 인식할 수 있도록 정규화 하는 것
