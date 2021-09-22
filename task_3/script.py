#!/usr/bin/env python

# Assume these values for object and key
object = {"x":{"y":{"z":"a"}}}
key = "x/y/z"


def find_value(object, key):
    i = 0                               # counter intail value
    keys = key.split("/")               # put key in a list to handle it
    length = len(keys) - 1              # set the number of iterations
    while i <= length:                  
        for K1, K2 in object.items():   # divided the object to find the value
            if isinstance(K2, dict):    # check if value is dict type
                break                   # back to main loop
        object = K2                     # get the finded value 
        i +=1                           # increment the iterator 
    return (object)                     # return the final value 

print("the value is", find_value(object, key))

