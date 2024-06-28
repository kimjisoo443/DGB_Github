# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 10:34:47 2024

@author: campus4D039
"""

import re
# 특정 단어를 찾고 싶을 때

print(re.findall("[abc]", "How are you, boy?"))
# a,b,c로 시작하는 단어가 있는지 찾는 것임
print(re.findall("[0123456789]", "oi4askdw2e352"))
# 숫자만 두고 나머지 글자는 쳐낸다
print(re.findall("[a-z]", "oi4askdw2e352"))
# a-z로 알파벳 전체 의미할 수 있음
print(re.findall("[a-z0-9]", "QQQaa123"))
# 숫자하고 소문자글자
re.findall("[_]+","a_b, c__d, e___f")
# 패턴 [_]+ : 언더바 하나부터 뒤에 언더바 또 붙은거 있으면 붙여서 출력한다
# 출력결과 ['_', '__', '___']

re.findall( "[o]{2,4}", "oh, hoow aroooe yooooooooooooou, booooooooooooooooooooooooooooooooooy" )
# 문장 내 o 1개 3개 여러개 여러개 
# 패턴의 의미 : o가 2개 4개 보여줘, 근데 o가 많으면 4개 기준으로 잘라줘
# 중괄호