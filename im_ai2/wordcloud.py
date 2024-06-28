# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 15:32:50 2024

<워드 클라우드> 
- 자연어의 기본 전처리 과정
- 텍스트 데이터에서는 빈도순 정렬, 낮은 빈도수 제거

@author: campus4D039
"""

import nltk 
from nltk.corpus import gutenberg # 말뭉치에서 소설 가져옴
from nltk.tokenize import word_tokenize, RegexpTokenizer # 단어, 정규화
from nltk.stem import PorterStemmer # stem

p_stem = PorterStemmer()

# 라이브러리 내 소설 목록
file_name = gutenberg.fileids()
print(file_name)

# 햄릿 읽어오기
doc_hamlet = gutenberg.open('shakespeare-hamlet.txt').read()
print("#Number of Characters used:",len(doc_hamlet))
# print(doc_hamlet[:100])

# 토큰화
token_hamlet = word_tokenize(doc_hamlet)

# stem - poterstem
# 단어 사전에 없는 단어로 바꿔줌
stem_token_ham = [p_stem.stem(token) for token in token_hamlet]

# 정규화 전처리
# 의미없는 . , [ 같은 거 없앰 
# 3글자 이상의 단어들만 추출하고 나머지 버려
rege_token = RegexpTokenizer("[\w']{3,}")
reg_token_ham = rege_token.tokenize(doc_hamlet.lower()) 

# 불용어 - stop word
# the 이런거 없앰
from nltk.corpus import stopwords
en_stop = set(stopwords.words('english')) # 영어의 스탑워드 리스트

result_ham = [word for word in reg_token_ham if word not in en_stop]

# 단어 나오는 횟수 세기
# 키 - word, 벨류 - 횟수
ham_word_cnt = dict()
for word in result_ham : 
    ham_word_cnt[word] = ham_word_cnt.get(word, 0) + 1
print(len(ham_word_cnt))

# 정렬
# 키값 기준, 내림차순
sorted_ham = sorted(ham_word_cnt, key=ham_word_cnt.get, reverse=True)

# 위의 sorted_hame 딕셔너리 값 확인
for key in sorted_ham[:20]:
    print(f"{repr(key)} : {ham_word_cnt[key]}", end = ',') # end : 엔터키 기본값 대신 , 넣어서 출력
    # repr : 모든 객체를 문자열로 반환
    
# 데이터 시각화
import matplotlib.pyplot as plt
w = [ham_word_cnt[key] for key in sorted_ham]
plt.plot(w)
plt.show()

# 상위 n개의 데이터 보여주기 코드
n = sorted_ham[:20][::-1]
w = [ham_word_cnt[key] for key in n] # 기존에 다 가져오던 거에서 상위 20개의 값만 가져옴
plt.barh(range(len(n)), w, tick_label=n) # 가로막대
# 가로막대 when 텍스트 이름 긴거
# 세로막대 when 텍스트 이름 짧은거
plt.show()

## 워드 클라우드
from wordcloud import WordCloud
wc = WordCloud().generate(doc_hamlet)
plt.axis('off')
plt.imshow(wc, interpolation = 'bilinear')
plt.show()

wc_cnt = WordCloud(max_font_size=50).generate_from_frequence()
plt.figure()
plt.axis('off')
plt.imshow(wc, interpolation = 'bilinear')
plt.show()
