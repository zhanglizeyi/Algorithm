
from misc import *
import crypt
import re


"""Load the words from the file filename that match the regular
       expression regexp.  Returns a list of matching words in the order
       they are in the file."""
def load_words(filename,regexp):
    name = filename+".txt" 
    f = open(name,'r')
    r = re.compile(regexp)
    wordList = []
    for line in f:
      word = re.match(regexp,line)
      i = re.match(regexp,line)
      if i != None:
        wordList.append(line[i.start():i.end()])
    return wordList 

  #raise Failure("to be written")

def transform_reverse(str):
    return str[::-1];

def transform_capitalize(str):
    new = [str.lower()]
    for i in range(1 << len(str)): #shift by 1 places
        word = list(str.lower())
        for j in range(0, len(str)):
            if i & 1 << j: # shift by 
              word[j:j+1] = list((''.join(word[j:j+1])).upper())
              new.append(''.join(word))
    return new

def transform_digits(str):
  res = [str]
  for s in res:
    i = 0
    while i < len(s):
      ch_low = s[i].lower()
      temp = s
      if ch_low == 'o':
          temp = helperFunc(temp,'0',i)
      elif ch_low == 'i':
          temp = helperFunc(temp,'1',i)
      elif ch_low == 'l':
          temp = helperFunc(temp,'1',i)
      elif ch_low == 'z':
          temp = helperFunc(temp,'2',i)
      elif ch_low == 'e':
          temp = helperFunc(temp,'3',i)
      elif ch_low == 'a':
          temp = helperFunc(temp,'4',i)
      elif ch_low == 's':
          temp = helperFunc(temp,'5',i)
      elif ch_low == 'b':
          temp = helperFunc(temp,'6',i)
          if (temp not in res):
              res.append(temp)
          temp = helperFunc(temp,'8',i)
      elif ch_low == 't':
          temp = helperFunc(temp,'7',i)
      elif ch_low == 'g':
          temp = helperFunc(temp,'9',i)
      elif ch_low == 'q':
          temp = helperFunc(temp,'9',i)
      else: pass
      if (temp not in res):
          res.append(temp)
      i += 1
  return res

# helper string helperFuncer function
def helperFunc(s, num, index):
  s = s[:index] + str(num) + s[index+1:]
  return s


    #raise Failure("to be written")
"""Check to see if the plaintext plain encrypts to the encrypted text enc"""
def check_pass(plain,enc):
    sat = enc[0]+enc[1] #get the first 2 letters for sat
    encrypted = crypt.crypt(plain,sat) #start the encryption
    if(encrypted == enc): #if match then return true else false
        return True
    else:
        return False
  
  #raise Failure("to be written")
"""Load the password file filename and returns a list of
    dictionaries with fields "account", "password", "UID", "GID",
    "GECOS", "directory", and "shell", each mapping to the
    corresponding field of the file."""

def load_passwd(filename):
    name = filename+".txt"
    fileList = []
    f = open(name, 'r')
    for line in f.readlines():
      tokens = re.split(':', line)
      d = dict(zip( ['account', 'password', 'UID', 'GID', 'GECOS', 'directory', 'shell'],tokens ))
      fileList.append(d)
    f.close()
    return fileList

  #raise Failure("to be written")
    """Crack as many passwords in file fn_pass as possible using words
       in the file words"""

def crack_pass_file(pass_filename,words_filename,out_filename):
  # open output file
  ostream = open(out_filename, 'w')
  accounts = load_passwd(pass_filename)
  words = load_words(words_filename, r'^.{6,8}$')
  # no transformations
  for account in accounts:
      username = account['account']
      passwd = account['password']
      for word in words:
        if check_pass(word, passwd):
          accounts.remove(account)
          ostream.write(username + "=" + word + "\n")
          ostream.flush()
          break
  # transformations
  for word in words:
      for c in transform_capitalize(word):
          for d in transform_digits(c):
              for r in transform_reverse(d):
                  for account in accounts:
                      username = account['account']
                      passwd = account['password']
                      if check_pass(r, passwd):
                          accounts.remove(account)
                          ostream.write(username + "=" + r + "\n")
                          ostream.flush()
                          break
  ostream.close()

  #raise Failure("to be written")

















