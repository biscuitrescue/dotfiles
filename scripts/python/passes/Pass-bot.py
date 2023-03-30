#!/usr/bin/env python3

from random import shuffle,randint,sample
import string
from zipfile import ZipFile
from os import remove
from os import listdir
from os.path import exists
from time import sleep
from multiprocessing import Process

def make_passes(a,b):
    for z in range(a,b):
        z=str(z)
        z="0"*(2-len(z))+z
        name ="passlist"+z+".txt"
        file = open(name,'w')
        file_len = []

        dirc=listdir()
        dirc.remove('key.txt')
        for i in dirc:
            if i[-3:]!='txt' or i==".MASTER-PASSLIST.txt":
                dirc.remove(i)
        print("Passlist {x} created. {y} remaining.".format(x=len(dirc), y=100-(len(dirc))))

        while len(file_len) < 10**4:
            s=''
            while len(s)<(chars*sets)+sets-1:
                x = sample(L1,chars)
                for i in x:
                    s+=i
                s+=' '
            s=s[:-1]
            if satisfier(s):
                s2=''
                for j in s:
                    if j not in D1:
                        s2+=j
                    else:
                        s2+=D1[j]
                file.write(s2)
                file.write('\n')
            else:
                continue

            file.close()

            with open(name) as file:
                file_len = file.readlines()

            file = open(name,'a')

### PASSWORD CRITERIA DEFINING ###
def satisfier(a):
    fl1,fl2,fl3,fl4=0,0,0,0
    x = False
    for i in a:
        if i.isalnum()==False:
            fl1+=1
        if i.isdigit()==True:
            fl2+=1
        if i.isupper()==True:
            fl3+=1
        if i.islower()==True:
            fl4+=1
        if fl1>0 and fl2>0 and fl3>0 and fl4>0:
            x = True
            break
    return x


L2 = list(string.ascii_uppercase)+list(string.ascii_lowercase)+list(string.digits)+list(string.punctuation)

L2.remove("\\")
L2.remove('"')
L2.remove("'")
L2.remove(".")
L1 = L2[:]


resp = input('''1) Get password
2) Get random 6 digit key code
3) Create a new password database
4) Record

#If you are running this script for the first time, go with option 3 
#If you are going for option 1 please make sure you copied your keyfile in this directory

Response(1,2,3,4): ''')

print()

if resp=="1":

### CHECKING KEY EXISTENCE ###

    if exists("key.txt")==False:
        print("The key file does not exist. Please copy the key from your SECURE location to this directory")
        sleep(10)
        exit()

### MAKING DICTIONARY FOR DECRYPTING ###

    D2 = {}
    with open("key.txt") as file_enc:
        L3 = list(file_enc.read().strip())
    for i in range(len(L1)):
        D2[L3[i]]=L1[i]

### USER INPUT FOR GETTING PASSWORD ###

    file_code = input("File code: ")
    code = int(input("Password code: "))
    
    with open("passlist{}.txt".format(file_code)) as file:
        L = file.readlines()
    
### DECRYPTING PASSWORD ###

    enc_pass = L[code-1].strip()
    unenc_pass=''
    for i in enc_pass:
        if i not in D2:
            unenc_pass+=i
        else:
            unenc_pass+=D2[i]
    
    print("Your password is: ")
    print()
    print(unenc_pass)
    print()

### AUTOMATIC KEY DELETION ### 

    resp4 = input('''Would you like to delete the key copy present in this folder?
Please do make sure you have a copy already present in the secure location as 
once the key is deleted, you will NOT be able to retrieve your passwords.
Type "yes" in all capital letters to delete the key. [YES/n]: ''')
    if (resp4=='YES'):
        remove("key.txt")
        print("Key deleted (hope you kept a copy.)")
        
    else:
        print("Key not deleted.")



### GETTING A RANDOM KEY CODE ###

elif resp=="2":
    x = randint(100000,999999)

    print("Your randomly generated code is:")
    print(x)
    print("Since this key is just a random 6 digit code, you are free to think of one yourself")


### GENERATING PASSWORD DATABASE ###

elif resp=="3":
    while True:
        resp3 = input("Are you sure you want to generate a new database and key? [y/n]: ")

        if resp3.lower()=="y" or resp3.lower()=="yes":

            shuffle(L2)
### WRITING KEY ###

            with open("key.txt",'w') as enc_file:
                for i in L2:
                    enc_file.write(i)

### CREATING DICTIONARY FOR ENCRYPTING ###

            D1 = {}
            
            for i in range(len(L1)):
                D1[L1[i]]=L2[i]

            print("New key created")
            print()
            for i in L2:
                print(i,end='')
            print()
            print()

### INPUTTING PASSWORD SPECIFICATIONS ###

            sets=input("Number of character sets [Default => 4] (minimum = 1): ")
            if sets == '':
                sets = 4
            else:
                sets = int(sets)

            chars=input("Number of characters per set: [Default => 10] (minimum = 4): ")
            if chars == '':
                chars = 10
            else:
                chars = int(chars)


            print("Generating password database:\nCharacter sets:",str(sets),"\nCharacters per set:",str(chars))
            print()

### GENERATING THE PASSWORDS ###

            processes=[]
            a,b=1,21
            for i in range(5):
                process=Process(target=make_passes, args=(a,b))
                process.start()
                processes.append(process)

                a=b
                b+=20

            for i in processes:
                i.join()

            print()
            print("Database created.")
### BACKUP OF DATABASE ###

            while True:    
                compy=input('''Do you want to save a compressed copy (zip) of this database?
This may decrease security as someone could get a copy of your unique database.
Proceed? [y/n] ''')
                if compy == 'y' or compy=='Y':
                    zippy = ZipFile("Database.zip",'w')
                    for i in range(1,101):
                        i=str(i)
                        i="0"*(2-len(i))+i
                        zippy.write("passlist"+str(i)+".txt")
                    zippy.write("key.txt")
                    zippy.close()
                    print()
                    print('''Database backup has been stored as a compressed zip file in this directory.

Please copy/move this file to a SECURE location.''')
                    break
                elif compy == 'n' or compy == 'N':
                    print()
                    print("No backup of database created.")
                    break
                else:
                    print()
                    print("Invalid input")
                    continue
            print("Please move your key to a SECURE location for security purposes:)")    
            break


        elif resp3=='n' or resp3=='N':
            print("Cancelling process.")
            break
        
        else:
            print("Invalid input")


### PASSWORD MANAGER ###

elif resp == "4":

    file = ".MASTER-PASSLIST.txt"

    if not exists(file):
        f = open(file,'w')
        f.close()
        L=[]
    else:
        with open(file) as f:
            L=f.readlines() 

### NUMBER CHECKER ###

    def checker(a):
        fl1,fl2=0,0
        if len(a)==6:
            fl1=True
        if a.isdigit():
            fl2=True
        if fl1==True and fl2==True:
            return True
        else:
            return False
    
    resp1 = input('''
1) Add entries.
2) Get code.
3) Edit current record.

Response [1/2/3]: ''')

    print()


### ADDING ENTRIES ###

    if resp1 == "1":
        print('''This program takes entries straight away.
To stop adding entries, type "DONE!" and press enter when prompted for an entry.''')
        print()

        for i in range(len(L)):
            L[i]=L[i].split()
        L2=[]
        for i in L:
            L2.append(i[0].lower())
        while True:
            service = input("Service name: ")
            if service == "DONE!":
                break
            elif service.lower() in L2:
                print("Entry corresponding to",service,"already exists.")
                print()
                continue
            code = input("Password code: ")
            
            if checker(code):
                service = service[0].upper()+service[1:]
                s = service+('\t')*3+code
                with open(file,'a') as f:
                    f.write(s+'\n')
                print("Added entry for",service)
                print()
            else:
                print("Code must be only 6 digits.")
                print()
                continue

### GETTING CODES ###

    elif resp1 == "2":
        
        for i in range(len(L)):
            L[i]=L[i].split()
        for i in L:
            print(i[0])
        print()
        service = input("Service name: ")
        print()
        
        fl_exist=0
        for i in L:
            if i[0].lower()==service.lower():
                fl_exist+=1
                print("Code corresponding to",service,"is: ")
                print()
                print(i[1])
                print()
        if fl_exist<1:
            print(service,"could not be found.")
            print()


### EDITING THE CURRENT RECORD ###

    elif resp1 == "3":
        
        for i in L:
            print(i.strip())
        print()
        service=input("Which record would you like to edit?: ")
        L2=L[:]
        for i in range(len(L2)):
            L2[i]=L2[i].split()
        fl_exist=0
        for i in L2:
            if service.lower()==i[0].lower():
                fl_exist+=1
                goal=i
        
        if fl_exist==1:
            while True:
                code = input("Changing code for "+goal[0]+" from "+goal[1]+" to (To delete this entry, type 000000): ")
                if code=="000000":
                    L2.remove(goal)
                    break
                elif checker(code):
                    goal[1]=code
                    break
                else:
                    print("Code must be only 6 digits.")
                    print()
                    continue
        else:
            print(service,"does not exist in this record.")
            sleep(4)
            exit()

        L=L2[:]
        for i in range(len(L2)):
            L[i]=L2[i][0]+'\t'*3+L2[i][1]
        
        print()
        print("Finalising changes: ")
        print()
        for i in L:
            print(i)
        print()

### CONFIRMATION BEFORE COMMITING CHANGES ###

        resp2 = input("Commit changes? [y/n]: ")
        print()
        if resp2.lower()=="yes" or resp2.lower()=="y":
            print("Writing changes to file.")
            with open(file,'w') as f:
                for i in L:
                    f.write(i+'\n')
            print()
        else:
            print("CANCELLING CHANGES.")
            sleep(4)
            exit()


else:
    print("Please choose valid option!")

print("Exiting ...")
