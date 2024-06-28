# -*- coding: utf-8 -*-
"""
Created on Thu Jun 27 15:40:20 2024

@author: campus4D039
"""

class dog():
    def __init__(self,age,species):
        self.age = age
        self.species = species
        
    def bark(self,species):
        if species == '말티즈':
            return '왕!왕!'
        elif species == '진돗개':
            return '워어어엉'   
        else:
            return '멍멍'
            
    def get_age(self,age):
        self.age += 1
        return self.age
    
    def __str__(self):
        return f'강아지 정보 : species={self.species}, age={self.age}'
            

age = 2
species = '태삐'
choco = dog(age,species)
print(choco)
print(choco.bark(species))
print(choco.get_age(age))
print(f"우리 {species}가 {choco.bark(species)} 짖네요!")


class Dog_child():
    def __init__(self):
        dog(age, species) #상속