# Algorithm

#solution of a sublime2 command adding into terminal 
#after install sublime but subl shrot cut key would not find whenever type subl in terminal 
#type this in 
alias subl="'/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl'"
alias nano="subl"
export EDITOR = "subl"


#For ssh-key possible solution 
1. check your existing RSA-key  -> ls -a ~/.ssh/
  if don't have any, genernate a new one by ssh-keygen
2. check agent pid by  -> eval "$(ssh-agent -s)"  
3. identity added -> ssh-add ~/.ssh/id_rsa
4. add id_rsa.pub to ssh key in github/bitbucket... 
