# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

def cal(a,b):
    cho = input('사칙연산 기능을 선택하세요 [sum, minus, mul, div]: ')
    while True:
        if cho == '종료':
            break
        
        if cho=='sum':
            return a+b
        elif cho =='minus':
            return a-b
        elif cho == 'mul':
            return a*b 
        elif cho=='div':
            try:
                a = float(a)
                b = float(b)
                return a/b
            except ZeroDivisionError:
                print('숫자를 0으로 나눌 수 없습니다.')
                break
