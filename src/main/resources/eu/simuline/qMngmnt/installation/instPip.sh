#!/bin/sh -

# run as user 

# the following error shows something new in python 3.11: 
# installation via pip only in environments. 
# I shall deinstall conda and reinstall. 
# I face that python in SysAdmin overrides internal one. 
# This seems all very inconsistent. 

# error: externally-managed-environment

# × This environment is externally managed
# ╰─> To install Python packages system-wide, try
#     zypper install python311-xyz, where xyz is the package
#     you are trying to install.

#     If you wish to install a non-rpm packaged Python package,
#     create a virtual environment using python3.11 -m venv path/to/venv.
#     Then use path/to/venv/bin/python and path/to/venv/bin/pip.

#     If you wish to install a non-rpm packaged Python application,
#     it may be easiest to use `pipx install xyz`, which will manage a
#     virtual environment for you. Install pipx via `zypper install python311-pipx` .

# note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
# hint: See PEP 668 for the detailed specification.

# [notice] A new release of pip is available: 23.3.2 -> 24.0
# [notice] To update, run: pip3.11 install --upgrade pip

# installation based on python
# but excluding conda environments. 
/usr/bin/python3 -m pip install --upgrade pip
pip3 install -U diff-pdf-visually
pip3 install -U unoserver
pip3 install -U python3-oct2py

#see https://pypi.org/project/unoserver/: 
#To find all Python installations that have the relevant LibreOffice libraries installed, you can run a script called find_uno.py:
wget -O find_uno.py https://gist.githubusercontent.com/regebro/036da022dc7d5241a0ee97efdf1458eb/raw/find_uno.py
python3 find_uno.py

