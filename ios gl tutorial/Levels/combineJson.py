#!/usr/bin/python
import glob,sys
import re

def natural_sort(l): 
    convert = lambda text: int(text) if text.isdigit() else text.lower() 
    alphanum_key = lambda key: [ convert(c) for c in re.split('([0-9]+)', key) ] 
    return sorted(l, key = alphanum_key)
    
levels = glob.glob("/Users/mnolan/programming/objective-c/ios gl tutorial/ios gl tutorial/Levels/level*")
levels = natural_sort(levels)

out = open("/Users/mnolan/programming/objective-c/ios gl tutorial/ios gl tutorial/levelData.json", "w")
out.write("[\n")
for filename in levels:
    infile = open(filename,"r")
    json = infile.read()
    out.write(json)
    if(levels.index(filename) < len(levels)-1):
        out.write(",\n")
    infile.close()
out.write("]\n")
out.close()    
