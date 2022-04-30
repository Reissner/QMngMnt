# The following commands control vs code's extension manager: 
#code --list-extensions
#code --install-extension ms-vscode.cpptools
#code --uninstall-extension ms-vscode.csharp
# The name of the extension is always name of the provider dot name of the extension.
# I feel better solved with java: domain.
# to update the version just
# code --install-extension --force ms-vscode.cpptools

# Textual: markdown  
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension joffreykern.markdown-toc
code --install-extension yzhang.markdown-all-in-one
code --install-extension shd101wyy.markdown-preview-enhanced
#code --uninstall-extension jrieken.md-navigate
code --install-extension alanwalk.markdown-navigation
code --install-extension tchayen.markdown-links

# xml
code --install-extension redhat.vscode-xml
code --install-extension dotjoshjohnson.xml

# latex
code --install-extension james-yu.latex-workshop
code --install-extension phr0s.bib
code --install-extension twday.bibmanager
# TBD: zotero

#git
code --install-extension eamodio.gitlens

# related with maven (mostly java) 
# vulnerabilities
code --install-extension redhat.fabric8-analytics

#
#code --install-extension Gimly81.matlab
#code --install-extension ms-python.python
#code --install-extension bmewburn.vscode-intelephense-client # php
#code --install-extension vscjava.vscode-java-pack# includes java5 runner

# to start vs code on the current directory just type
# code .
# this will start in the background automatically.

# for docker 
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-containers

# spellchecker
code --install-extension valentjn.vscode-ltex
