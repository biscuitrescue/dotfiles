#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

def delete_index_html(path):
    for root, dirs, files in os.walk(path):
        for file in files:
            if file == "index.html":
                file_path = os.path.join(root, file)
                os.remove(file_path)

delete_index_html(".")

