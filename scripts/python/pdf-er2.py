#!/usr/bin/env python
# -*- coding: utf-8 -*-

from subprocess import run
from os import listdir,rename

homedir='/home/cafo/pdf/'

L = listdir(homedir)
file=homedir+L[0]
run(f'~/.local/bin/har-extractor {file} -o {homedir}',shell=True)
newfile=file+'.d'
pdf=newfile+'/online.vidyamandir.com/getpdf.php'
name = input('File name: ')

run(f'mv {pdf} /home/cafo/vmc-notes-pdf/{name.upper()}.pdf',shell=True)

run('rm -rf ~/pdf/*',shell=True)
