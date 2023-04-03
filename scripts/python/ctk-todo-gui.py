#!/usr/bin/env python3

from customtkinter import *
from datetime import datetime
import csv
import os

colours = {
    "pink":"#f5c2e7",
    "rosewater":"#f5e0dc",
    "flamingo":"#f2cdcd",
    "mauve":"#cba6f7",
    "red":"#f38ba8",
    "orange":"#fab387",
    "yellow":"#f9e2af",
    "green":"#a6e3a1",
    "teal":"#94e2d5",
    "blue":"#89b4fa",
    "lavender":"#b4befe",
    "fg":"#cdd6f4",
    "bg":"#1e1e2e",
    "base1":"#313244",
    "mantle":"#181825"
}

status_file = "/home/cafo/.config/tt.csv"
if not os.path.exists(status_file):
    with open(status_file,'w') as f:
        pass



def lister():
    with open(status_file) as f:
        robj = csv.reader(f)
        L = []
        for i in robj:
            L.append(i)
    return L

def add_entry(entry):
    date = datetime.now().strftime('%d %b %Y')
    day = datetime.now().strftime('%A')
    with open(status_file,'a',newline='') as f:
        wobj = csv.writer(f)
        wobj.writerow([date,day,entry])

def rewrite(entries):
    with open(status_file,'w',newline='') as f:
        wobj = csv.writer(f)
        wobj.writerows(entries)

def remove_entry(index):
    entries = lister()
    entries.pop(index-1)
    rewrite(entries)

def display():
    entries = lister()
    disp_entries = []
    for i in entries:
        disp_entries.append(f'{i[2]} ({i[1]}, {i[0]})')
    s = ''
    for index,i in enumerate(disp_entries,start=1):
        s+=f'{index}) {i}\n'
    disp_str.set(s)

def add_click():
    entry = main_entry.get()
    if len(entry)>0:
        add_entry(entry)
        display()
        main_entry.delete(0,END)

def remove_click():
    index = int(main_entry.get())
    try:
        remove_entry(index)
        display()
        main_entry.delete(0, END)
    except IndexError:
        pass


root = CTk()

root_x = 800
root_y = 500

root.geometry(f'{root_x}x{root_y}')
root.configure(fg_color=colours['mantle'])
root.title('ctk-todo')
def on_enter_key(event):
    add_click()

def on_delete_key(event):
    remove_click()

disp_str = StringVar()

# filler_frame_1 = CTkFrame(root,fg_color=colours['mantle'])
# filler_frame_2 = CTkFrame(root,fg_color=colours['mantle'])

# filler_frame_1.place(relx=0,rely=0,relheight=220/600,relwidth=1)
# filler_frame_2.place(relx=0,rely=380/600,relheight=220/600,relwidth=1)

disp_frame = CTkFrame(root,fg_color=colours['base1'])
disp_frame.place(relx=300/800,rely=0,relheight=1,relwidth=500/800)

date_label = CTkLabel(
    root,
    fg_color='transparent',
    # text_color=colours['fg'],
    text=f"{datetime.now().strftime('%A')}, {datetime.now().strftime('%d %b %Y')}",
    font=(None,22),
    corner_radius=8
)
date_label.place(relx = 20/800,rely = 50/600, relheight=50/600,relwidth=260/800)


main_entry = CTkEntry(root,fg_color=colours['fg'],text_color=colours['mantle'],font=(None,16))
main_entry.place(relx=50/800,rely=240/600,relheight=45/600,relwidth=200/800)

add_button = CTkButton(root,fg_color=colours['blue'],text='Add',text_color=colours['mantle'],font=(None,16),command=add_click)
add_button.place(relx=50/800,rely=315/600,relheight=45/600,relwidth=90/800)

remove_button = CTkButton(root,fg_color=colours['mauve'],text='Remove',text_color=colours['mantle'],font=(None,16),command=remove_click)
remove_button.place(relx=160/800,rely=315/600,relheight=45/600,relwidth=90/800)

disp_label = CTkFrame(disp_frame,fg_color=colours['flamingo'])
disp_label.place(relx=50/500,rely=50/600,relheight=500/600,relwidth=400/500)

todo_label = CTkLabel(
    disp_label,
    text = '--------------TO DO--------------',
    fg_color='transparent',
    text_color=colours['mantle'],
    font = (None,24)
)

final_disp_label = CTkLabel(
    disp_label,
    textvariable = disp_str,
    fg_color = 'transparent',
    text_color = colours['mantle'],
    justify='left',
    font=(None,20)
)

todo_label.place(
    relx = 0/400, rely = 30/500,
    relheight = 40/500, relwidth=0.99 
)

final_disp_label.place(
    relx = 20/400 , rely = 90/500
)

display()

root.bind('<Return>', on_enter_key)
root.bind('<Delete>',on_delete_key)

main_entry.focus_set()

root.mainloop()
