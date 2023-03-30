#!/usr/bin/env python3
from datetime import datetime

s='''
##########################################
# Planner for classes and TODO list.     #
# Created by: Advay Makhija              #
# Github: https://github.com/rayquaza-69 #
##########################################
'''
print(s)


### COLOURS ###

col_deepblue="#282a36"
col_lighterblue="#44475a"
col_foreground="#f8f8f2"
col_lightestblue="#6272a4"
col_cyan="#8be9fd"
col_green="#50fa7b"
col_orange="#ffb86c"
col_pink="#ff79c6"
col_purple="#bd93f9"
col_red="#ff5555"
col_yellow="#f1fa8c"

### FONT ###
fontboi="Calibri"
print('Font:',fontboi)

### TT FILE ###
tt_file='tt.txt'
from os.path import exists
if not exists(tt_file):
    with open(tt_file,'w') as f:
        None
print('Name of tt file:',tt_file)

### DAY ###
Day = datetime.now().strftime('%A')
Date = datetime.now().strftime('%d/%m/%Y')
print(Day)
print(Date)

### Tk window ###
from tkinter import *

root = Tk()
root.title("Planner beby")
root.geometry("800x500")
root.configure(background=col_deepblue)

### DRAWING CANVAS ###
Lab1=Label(text='',bg=col_yellow).place(x=0,y=250,height=250,width=400)
Lab1=Label(text='',bg=col_yellow).place(x=400,y=0,height=250,width=400)

### DRAWING HEADINGS ###
## Classes ##
Lab1=Label(root,text='Classes   ['+Day+']',fg='#000000',bg=col_yellow,font=(fontboi,16),justify='center').place(x=400,y=0,height=30,width=400)
## To do ##
Lab1=Label(root,text='To do',fg='#000000',bg=col_yellow,font=(fontboi,16),justify='center').place(x=0,y=250,height=30,width=400)
## Keys ##
Lab1=Label(root,text='Usage',fg=col_yellow,bg=col_deepblue,font=(fontboi,16),justify='center').place(x=400,y=250,height=30,width=400)


### READING THE CLASSES TEXT FILE ###

day_list=['[Monday]','[Tuesday]','[Wednesday]','[Thursday]','[Friday]','[Saturday]','[Sunday]']

classes_file="classes.txt"
if not exists(classes_file):
    exit()
with open(classes_file) as f:
    class_list=f.readlines()

class_list_day=[]
L=[]
for i in range(len(class_list)):
    if class_list[i]=='\n':
        class_list_day.append(L)
        L=[]
        continue
    else:
        L.append(class_list[i].strip())


class_dict={}
for i in class_list_day:
    class_dict[i[0][1:-1]]=i[1:]

for i in class_dict:
    for j in range(len(class_dict[i])):
        class_dict[i][j]=tuple(class_dict[i][j].split())

### PRINTING THE CLASSES ###

class_day=class_dict[Day]
print(class_day)
Lab_classtime=Label(root,text="Time",bg=col_yellow,fg='#000000',justify='center',font=(fontboi,14)).place(x=400,y=40,height=20,width=200)
Lab_classtime=Label(root,text="Class",bg=col_yellow,fg='#000000',justify='center',font=(fontboi,14)).place(x=600,y=40,height=20,width=200)

class_y=70

for i in class_day:
    Lab_class=Label(root,text=i[0],bg=col_yellow,fg='#000000',font=(fontboi,12)).place(x=400,y=class_y,height=20,width=200)
    Lab_class=Label(root,text=i[1][0].upper()+i[1][1:],bg=col_yellow,fg='#000000',font=(fontboi,12)).place(x=600,y=class_y,height=20,width=200)
    
    class_y+=25


### EDIT BOX  AND TO DO ###

## Reading tt file ##
with open(tt_file) as f:
    tt_file_list=f.readlines()
for i in range(len(tt_file_list)):
    tt_file_list[i]=tt_file_list[i].strip()


def printer():
    ## Clearing screen ##
    Lab_yellow=Label(root,text='',bg=col_yellow).place(x=0,y=300,height=200,width=400)
    global tt_file_list
    todo_x,todo_y=0,300
    for i in range(len(tt_file_list)):
        Lab_todo=Label(root,text=' '*4+str(i+1)+') '+tt_file_list[i],fg='#000000',bg=col_yellow,font=(fontboi,14),anchor='w').place(x=todo_x,y=todo_y,height=20,width=400)
        todo_y+=25
printer()

## Button functions ##
fl=[0,'']
def click(a):
    global Entry_edit
    global fl
    print(Entry_edit.get())
    if a==1:
        tt_file_list.append(Entry_edit.get())
        Entry_edit.delete(0,END)
    elif a==2:
        if fl[0]==0:
            Button_add.config(state=DISABLED)
            Button_remove.config(state=DISABLED)
            word=tt_file_list[int(Entry_edit.get())-1]
            fl=[1,int(Entry_edit.get())-1]
            Entry_edit.delete(0,END)
            Entry_edit.insert(0,word)
            
        elif fl[0]==1:
            Button_add.config(state=NORMAL)
            Button_remove.config(state=NORMAL)
            tt_file_list[fl[1]]=Entry_edit.get()
            Entry_edit.delete(0,END)

    elif a==3:
        if Entry_edit.get().isdigit():
            tt_file_list.pop(int(Entry_edit.get())-1)
        else:
            tt_file_list.remove(Entry_edit.get())
        Entry_edit.delete(0,END)

    printer()
    with open(tt_file,'w') as f:
        for i in tt_file_list:
            f.write(i+'\n')




## Date ##
Lab_date=Label(root,text=Date,bg=col_purple,fg='#000000',font=(fontboi,16),anchor='center').place(x=0,y=0,height=20,width=400)
Entry_edit=Entry(root,fg='#000000',bg=col_yellow)
Entry_edit.place(x=80,y=95,height=30,width=240)

Button_add=Button(root,text='Add',bg=col_green,fg='#000000',bd=0,command=lambda:click(1))
Button_add.place(x=80,y=130,height=25,width=75)

Button_edit=Button(root,text='Edit',bg=col_cyan,fg='#000000',bd=0,command=lambda:click(2))
Button_edit.place(x=162.5,y=130,height=25,width=75)

Button_remove=Button(root,text='Remove',bg=col_red,fg='#000000',bd=0,command=lambda:click(3))
Button_remove.place(x=245,y=130,height=25,width=75)


### USAGE ###
usage='''\u2022 To add an element, type the required element in the entry feild and press the 'Add' button.

\u2022 To remove an element, type the required element's index or the element itself in the entry feild and press the 'Remove' button.

\u2022 To edit an element, type the index of the element in the entry feild and press the 'Edit' button, the text will now be inserted in the entry feild and the other \
buttons will be disabled. Edit the element and press the 'Edit' button again to commit the changes.

\u2022 For the class schedule, there should be a 'classes.txt' file in the same directory as this program. \
it's format can be viewed by clicking'''
print(usage)

def spawn():
    
    root2=Toplevel(root,bg=col_yellow)
    root2.geometry('250x550')
    
    s='''To be written in a file called 'classes.txt'
in the same directory as this program.
______________________________________

[Monday]
06:30-07:30 [class1]
09:00-11:00 [class2]

[Tuesday]
01:00-02:00 [class1]
02:00-03:00 [class2]

[Wednesday]
03:00-04:00 [class1]
08:00-02:00 [class2]

[Thursday]
02:00-11:00 [class1]
08:00-01:00 [class2]

[Friday]
01:00--2:00 [class1]
08:00-10:00 [class2]

[Satuday]
09:30-14:30 [class1]

[Sunday]
09:30-04:00 [class1]
'''
    Lab=Label(root2,text=s,bg=col_yellow,fg='#000000',justify='left',anchor='w').pack()

Lab_usage = Label(root,text=usage,bg=col_deepblue,fg=col_yellow,justify='left',anchor='n',font=(fontboi,10),wraplength=390)
Lab_usage.place(x=405,y=280,height=210,width=400)

B_format=Button(root,text='this.',bg=col_deepblue,fg=col_orange,bd=0,highlightthickness=0,font=(fontboi,10),command=spawn)
B_format.place(x=755,y=450,height=15,width=20)


root.mainloop()
