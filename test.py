
print "hello world"

# Mutable 易变得 when you alter the item, the id is still the same,
#dictionary, list

#Imutable 不变的 string integer tuple


a = 4 #integer
b = 5.6 # float
c = "hello" #string 
d = "4" #rebound to string

# + , - , * , / , **(power), %(mod)

print '''He said, "I'm sorry\\"'''

#string property
c.endswith("l")
c.find(sub)
c.format(*arg) # arg in string
c.index(sub) #returns index of sub or exception
c.join(list) #returns list items separated by string
c.strip() #removes whitespace from start/end


c = None    #Null false

a =[]
a.append(4)
a.append('hello')
a.append(1)
a.sort() # in place

#array list ---------------
a = [] 
a.sort()
a.reverse()
a.remove(item) #remove first item found
a.pop() #remove / return item ate end of list


#dictionary 

age = {}
age['george'] = 10
age['fred'] = 12

age.get('fred')
del age['fred']

def add_2(num):
	''' return 2 more than sum'''
	return num+2

#def
# Function name 
#indent
#body
#return

if grade > 90:
	print 'A'
elif grade > 80:
	print 'B'
elif grade > 70:
	print 'C'
else: 
	print 'D'


for number in range(1,7):
	print number

animals = ['cat','dog','bird']

for index in range(len(animals)):
	print index, animals[index]


for index, value in enumerate(animals):
	print index, value

if item < 0:
	break

dict = {"name": "matt", "cash":5.45}

for key in dict.keys():
	print key

for value in dict.values():
	print value

for key, value in dict.items():
	print value



fin = open("foo.txt")
for line in fin:
	#do somthing
fin.close()

with open("bar.txt")as fin:
	for line in fin:
		#something

fout = open("bar.txt", "w")
fout.write("hello world")
fout.close()



class animal(object):
	def __init__(self, name):  #dunder init constructor
		self.name = name 	 # all methods take self as first parameter
	def talk(self):
		print "Generic Animal Sound"

animal = Animal("thing")
animal.talk()


#subclass 
class cat(animal):
	def talk(self):
		print '%s says, "meow!" ' %(self.name)


cat = cat("Groucho")
cat.talk()

[start:end:step] <-> [end:start:-step]






















