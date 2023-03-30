#!/usr/bin/env python3 

import os
from datetime import datetime

def generate_index_html(path):
    entries = os.scandir(path)
    html = '''
        <!DOCTYPE html>
        <html>
        <head>
            <title>FILES</title>
            <style>
                body {
                    background-color: #11111b;
                    color: #cdd6f4;
                }
                table {
                    width: 100%;
                    border-collapse: collapse;
                }
                th, td {
                    border: 1px solid #45475a;
                    padding: 8px;
                    text-align: left;
                }
                th {
                    background-color: #313244;
                    color: #cdd6f4;
                }
                a {
                    color: #cba6f7;
                }
            </style>
        </head>
        <body>
            <h1>FILES</h1>
            <table>
                <tr>
                    <th>Name</th>
                    <th>Size (mb)</th>
                    <th>Last Modified</th>
                </tr>
    '''
    for entry in entries:
        if entry.is_file():
            size = round(entry.stat().st_size / 1048576,2)
            modified = entry.stat().st_mtime
            dt = datetime.fromtimestamp(modified)
            modified = dt.strftime("%d %b, %I:%M %p")
            html += f'<tr><td><a href="{entry.name}">{entry.name}</a></td><td>{size}</td><td>{modified}</td></tr>'
        elif entry.is_dir():
            subdir_path = os.path.join(path, entry.name)
            subdir_index = os.path.join(subdir_path, 'index.html')
            with open(subdir_index, 'w') as f:
                f.write(generate_index_html(subdir_path))
            html += f'<tr><td><a href="{entry.name}/">{entry.name}/</a></td><td></td><td></td></tr>'
    html += '''
            </table>
        </body>
        </html>
    '''
    index_file_path = os.path.join(path, 'index.html')
    with open(index_file_path, 'w') as f:
        f.write(html)

    return html

generate_index_html('.')
