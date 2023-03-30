#!/usr/bin/env python3

from tkinter import *

class Main_window(Tk):
    def __init__(self):
        super().__init__()
        self.configure(background="#1e1e2e")
        self.geometry("1200x700")


class Page(Frame):
    def __init__(self, main):
        super().__init__(main, bg="#1e1e2e")


root = Main_window()
root.mainloop()
