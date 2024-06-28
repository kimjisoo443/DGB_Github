# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 09:44:45 2024

@author: kjs
"""

import nlkt
from nltk.tokenize import sent_tokenize
# nltk.download('punkt')

# 문장 토큰화
sentence = '전신마취 등 환자의 의식이 없는 상태에서 수술을 하는 병원은 수술실 내부에 CCTV를 의무적으로 설치'
token_sent = sent_tokenize(sentence)
print(sent_tokenize(sentence))
