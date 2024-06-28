# -*- coding: utf-8 -*-
"""
Created on Fri Jun 28 13:33:50 2024

@author: campus4D039
"""

# lemma
from nltk.stem import WordNetLemmatizer

w_lemma = WordNetLemmatizer()

print(w_lemma.lemmatize('cook'))
print(w_lemma.lemmatize('cooking'))
print(w_lemma.lemmatize('cookery'))

print(w_lemma.lemmatize('cooking',pos='v'))
# 원형 동사로 바꿔라


