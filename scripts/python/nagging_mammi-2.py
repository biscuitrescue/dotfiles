#!/usr/bin/env python
# -*- coding: utf-8 -*-

from customtkinter import *
import time

BACKGROUND_COLOR = '#282a36'
FOREGROUND_COLOR = '#f8f8f2'
BUTTON_COLOR = '#44475a'
BUTTON_HOVER_COLOR = '#6272a4'
BUTTON_ACTIVE_COLOR = '#8be9fd'

time_delay = 3600 
yes_delay = 3600
no_delay = 300

def check_productivity():
    # Create the window
    global time_delay
    window = CTk()
    window.title("Productivity Check")
    window.geometry("600x300")
    window.configure(fg_color=BACKGROUND_COLOR)

    # Add a label and buttons to the window
    label = CTkLabel(window, text="Padh raha hai?", text_color=FOREGROUND_COLOR, fg_color=BACKGROUND_COLOR, font=("Helvetica", 20, "bold"))
    label.place(relx = 0,rely = 20/150,relheight = 20/150,relwidth=1)
    def yes():
        global time_delay
        time_delay = yes_delay
        window.destroy()

    def no():
        global time_delay
        time_delay = no_delay
        window.destroy()

    yes_button = CTkButton(window, text="Yes", command=yes, text_color=FOREGROUND_COLOR, fg_color=BUTTON_COLOR, hover_color=BUTTON_HOVER_COLOR, font=("Helvetica", 18))
    yes_button.place(relx = 40/300,rely = 80/150,relheight=30/150,relwidth=70/300)
    
    no_button = CTkButton(window, text="No", command=no, text_color=FOREGROUND_COLOR, fg_color=BUTTON_COLOR, hover_color=BUTTON_HOVER_COLOR, font=("Helvetica", 18))
    no_button.place(relx = 190/300,rely = 80/150,relheight=30/150,relwidth=70/300)

    # Show the window
    window.mainloop()

while True:
    
    check_productivity()

    time.sleep(time_delay)


