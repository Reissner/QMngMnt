#!/bin/sh -

# The following commands control vs code's extension manager: 
#code --list-extensions --show-versions
#code --install-extension ms-vscode.cpptools
#code --uninstall-extension ms-vscode.csharp
# The name of the extension is always name of the provider dot name of the extension.
# I feel better solved with java: domain.
# to update the version just
# code --force --install-extension ms-vscode.cpptools

# Textual: markdown  
code --force --install-extension DavidAnson.vscode-markdownlint
code --force --install-extension joffreykern.markdown-toc
code --force --install-extension yzhang.markdown-all-in-one
code --force --install-extension shd101wyy.markdown-preview-enhanced
#code --uninstall-extension --force jrieken.md-navigate
code --force --install-extension alanwalk.markdown-navigation
code --force --install-extension tchayen.markdown-links

# Velocity Template Language (VTL)
code --force --install-extension luqimin.velocity

# antlr
code --force --install-extension mike-lischke.vscode-antlr4
code --force --install-extension ncthbrt.antlr4

# xml
code --force --install-extension redhat.vscode-xml
code --force --install-extension dotjoshjohnson.xml

# latex and friends 
code --force --install-extension james-yu.latex-workshop
code --force --install-extension mathematic.vscode-latex
# bib
code --force --install-extension phr0s.bib
code --force --install-extension twday.bibmanager
# nothing found for tikz
# metapost 
code --force --install-extension fjebaker.vscode-metapost
# gnuplot is separate below 
# TBD: zotero

# gnuplot
code --force --install-extension marioschwalbe.gnuplot
code --force --install-extension fizzybreezy.gnuplot

# svg
code --force --install-extension jock.svg
code --force --install-extension simonsiefke.svg-preview



#git
code --force --install-extension eamodio.gitlens

# related with maven (mostly java) 
# vulnerabilities
code --force --install-extension redhat.fabric8-analytics

#
#code --force --install-extension Gimly81.matlab
#code --force --install-extension ms-python.python
code --force --install-extension ms-python.pylint
#code --force --install-extension bmewburn.vscode-intelephense-client # php
#code --install-extension v--force scjava.vscode-java-pack# includes java5 runner

# to start vs code on the current directory just type
# code .
# this will start in the background automatically.

code --force --install-extension ithildir.java-properties

# C and C++
code --force --install-extension ms-vscode.cpptools-extension-pack

# makefile
code --force --install-extension ms-vscode.makefile-tools
code --force --install-extension carlos-algms.make-task-provider

# for docker 
code --force --install-extension ms-azuretools.vscode-docker
code --force --install-extension ms-vscode-remote.remote-containers

# spellchecker
code --force --install-extension valentjn.vscode-ltex

#code --list-extensions
#code --install-extension ms-vscode.cpptools
#code --uninstall-extension ms-vscode.csharp
#code --install-extension Gimly81.matlab
#code --install-extension DavidAnson.vscode-markdownlint

# groovy
code --force --install-extension mellowmarshmallow.groovy
code --force --install-extension nicolasvuillamy.vscode-groovy-lint
code --force --install-extension argylewolflabs.vscode-groovy
code --force --install-extension marlon407.code-groovy
code --force --install-extension dontshavetheyak.groovy-guru

# perl
code --force --install-extension d9705996.perl-toolbox

# java
code --force --install-extension vscjava.vscode-java-pack
# this also installs the following: 
#code --force --install-extension redhat.java
#code --force --install-extension vscjava.vscode-java-debug
#code --force --install-extension vscjava.vscode-java-test
#code --force --install-extension vscjava.vscode-maven
#code --force --install-extension VisualStudioExptTeam.vscodeintellicode

# also from vscjava: 
# code --force --install-extension vscjava.vscode-java-dependency

code --force --install-extension wmanth.jar-viewer
code --force --install-extension cracrayol.java-pmd

# alternative test runner: 
# code --force --install-extension javatest.java-test


code --force --install-extension shengchen.vscode-checkstyle
code --force --install-extension chuckjonas.apex-pmd
code --force --install-extension sonarsource.sonarlint-vscode

code --force --install-extension tintinweb.vscode-decompiler
code --force --install-extension dgileadi.java-decompiler


code --force --install-extension ryanluker.vscode-coverage-gutters

# octave: IDE and run
code --force --install-extension leafvmaple.octave
code --force --install-extension toasty-technologies.octave
code --force --install-extension lucasfa.octaveexecution

# matlab: IDE and run (partially interactively)
code --force --install-extension mathworks.language-matlab # IDE
code --force --install-extension bramvanbilsen.matlab-code-run
code --force --install-extension shinyypig.matlab-in-vscode
code --force --install-extension apommel.matlab-interactive-terminal


# lisp
code --force --install-extension mattn.lisp

# emails
code --force --install-extension tomashubelbauer.email-viewer

# misc
code --force --install-extension trond-snekvik.simple-rst
code --force --install-extension maarti.jenkins-doc



