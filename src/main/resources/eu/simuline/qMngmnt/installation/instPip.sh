#!/bin/sh -

# installation based on python
# but excluding conda environments. 
/usr/bin/python3 -m pip install --upgrade pip
pip3 install -U diff-pdf-visually
pip3 install -U unoserver

#see https://pypi.org/project/unoserver/: 
#To find all Python installations that have the relevant LibreOffice libraries installed, you can run a script called find_uno.py:
wget -O find_uno.py https://gist.githubusercontent.com/regebro/036da022dc7d5241a0ee97efdf1458eb/raw/find_uno.py
python3 find_uno.py

