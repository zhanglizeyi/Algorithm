#PA 4

import re

"Miscellaneous functions to practice Python"

class Failure(Exception):
    """Failure exception"""
    def __init__(self,value):
        self.value=value
    def __str__(self):
        return repr(self.value)

# Problem 1

# data type functions


"""Return the element of the list l closest in value to v.  In the case of
       a tie, the first such element is returned.  If l is empty, None is returned."""
def closest_to(l,v):
  if not l:
    return None
  temp = l[0]
  for item in l:
    if abs(item-v) < abs(temp-v):
      temp = item
  return temp
         
''' 
test case
  closest_to([2,4,8,9],7)
  closest_to([2,4,8,9],5)
'''
  #raise Failure("to be written")

"""Return a dictionary pairing corresponding keys to values."""
def make_dict(keys,values):
  return {keys[i] : values[i] for i in range(len(keys))} 

#make_dict(["foo","baz"],["bar","blah"])
#make_dict([1],[100])

#raise Failure("to be written")
   
# file IO functions
"""Open the file fn and return a dictionary mapping words to the number
   of times they occur in the file.  A word is defined as a sequence of
   alphanumeric characters and _.  All spaces and punctuation are ignored.
   Words are returned in lower case"""
def word_count(fn):
  txt = open(fn, 'r')
  d = dict()
  pat = re.compile('[a-zA-Z0-9]+')
  words = "".join([c if pat.match(c) else ' ' for c in txt.read().lower()]) #make sure this 
  for w in words.split():  #for each words repeated
    if w in d:
      d[w] = d[w] + 1
    else: 
      d[w] = 1
  txt.close()
  return d

#raise Failure("to be written")





