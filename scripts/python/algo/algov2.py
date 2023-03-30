#!/usr/bin/env python3
import random
import string
from tkinter import *

root = Tk()
root.geometry("430x150")
root.configure(background="#282a36")

chunksize=5
key_filename="sinha_key.txt"

letter_list=list(string.ascii_lowercase+string.ascii_uppercase+string.digits+string.punctuation)

letter_list.remove("'")
letter_list.remove("\\")
letter_list.remove('"')

## MAKING A NEW KEY ##

# jumbled_list=letter_list[:]
# random.shuffle(jumbled_list)
# print(jumbled_list)
# file = open(key_filename,'w')
# for i in jumbled_list:
#     file.write(i)
# file.close()

### OPENING KEY AND CREATING MAPPINGS ###

file = open(key_filename)
s = file.read().strip()
jumbled_list=list(s)
file.close()

dict_unenc2enc = {}
for i in range(len(letter_list)):
    dict_unenc2enc[letter_list[i]]=jumbled_list[i]

dict_enc2unenc = {}
for i in range(len(letter_list)):
    dict_enc2unenc[jumbled_list[i]]=letter_list[i]


## ENCRYPTION DECRYPTION FUNCTIONS ##
def substitute(a,b):
    global dict_unenc2enc
    global word
    s=a
    for i in range(b+1):
        if s in dict_unenc2enc:
            s=dict_unenc2enc[s]
        else:
            s=s
    return s


def unsubstitute(a,b):
    global dict_enc2unenc
    global word
    s=a
    for i in range(b+1):
        if s in dict_enc2unenc:
            s=dict_enc2unenc[s]
        else:
            s=s
    return s


def click(a):

## CONVERTING INPUT TO CHUNKS ##
    global E1
    global E2

    word = E1.get()
    E1.delete(0,END)
    E2.delete(0,END)

    
    L2=[]
    for i in range(0,len(word),chunksize):
        L = word[i:i+chunksize]
        blank=chunksize-len(L)
        L+=("*"*blank)
        L2.append(L)


## ENCRYPTING ##
    if a =="enc":
        L3=[]
        for i in range(len(L2)):
            x=''
            for j in range(len(L2[i])):
                x+=substitute(L2[i][j],j)
            L3.append(x)

        for i in range(1,len(L3),2):
            L3[i]=L3[i][::-1]

        result = ''
        for i in L3:
            result+=i
    


## DECRYPTING ##
    elif a=="dec":

        for i in range(1,len(L2),2):
            L2[i]=L2[i][::-1]

        result = ''
        for i in range(len(L2)):
            x=''
            for j in range(len(L2[i])):
                x+=unsubstitute(L2[i][j],j)
            result+=x

        result = result.replace("*","") 
   
    E2.insert(0,result)



B1 = Button(root,text="Encrypt",bg="#50fa7b",command=lambda:click("enc"))
B2 = Button(root,text="Decrypt",bg="#50fa7b",command=lambda:click("dec"))

E1 = Entry(root,bg="#f1fa8c")
E2 = Entry(root,bg="#f1fa8c")


B1.place(x=10,y=10,height=50,width=200)
B2.place(x=220,y=10,height=50,width=200)
E1.place(x=10,y=70,height=30,width=410)
E2.place(x=10,y=110,height=30,width=410)


root.mainloop()