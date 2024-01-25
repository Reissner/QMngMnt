#!/bin/sh -

# run as user 

# USAGE: 
# without argument defaults to `code`
# with single argument giving the name of the clone of code. 
# Currently we use CODE for the flatpack version. 


# The following commands control vs code's extension manager: 
# Explanation 
# code --extensions-dir <dir>
#     Set the root path for extensions.
# code --list-extensions
#     List the installed extensions.
# code --show-versions
#     Show versions of installed extensions, when using --list-extension.
# code --install-extension (<extension-id> | <extension-vsix-path>)
#     Installs an extension.
# code --uninstall-extension (<extension-id> | <extension-vsix-path>)
#     Uninstalls an extension.
# code --enable-proposed-api (<extension-id>)
#     Enables proposed API features for extensions. 
#     Can receive one or more extension IDs to enable individually.
# The extension-id is always name of the provider dot name of the extension.
# I feel better solved with java: domain.
# to update the version just
# code --force --install-extension ms-vscode.cpptools

case $# in 
  0)
  code="code"
  ;;
  1)
  code=$1
  ;;
  *)
  echo "expected 0 or 1 arguments found $#."
  exit
esac
echo $code

echo "install from markdown to lisp" 

# Textual: markdown and friends 
$code --force --install-extension DavidAnson.vscode-markdownlint
$code --force --install-extension joffreykern.markdown-toc
$code --force --install-extension yzhang.markdown-all-in-one
$code --force --install-extension shd101wyy.markdown-preview-enhanced
#$code --uninstall-extension --force jrieken.md-navigate
$code --force --install-extension alanwalk.markdown-navigation
$code --force --install-extension tchayen.markdown-links
# ltex in the course of latex 
# plantuml 
$code --force --install-extension myml.vscode-markdown-plantuml-preview
#$code --force --install-extension well-ar.plantuml # seems not to work 
$code --force --install-extension pomdtr.markdown-kroki
#$code --force --install-extension yog.yog-plantuml-highlight # seems not to work for me
#$code --force --install-extension jebbs.plantuml # seems to do highlighting, preview, 
# but via server: security gap 
#$code --force --install-extension yzane.markdown-pdf  converts to pdf but also to html (png and jpg irrelevant)

# Velocity Template Language (VTL)
$code --force --install-extension luqimin.velocity

# antlr
$code --force --install-extension mike-lischke.vscode-antlr4
$code --force --install-extension ncthbrt.antlr4

# lex/yacc and flex/bison
$code --force --install-extension daohong-emilio.yash

# xml
$code --force --install-extension redhat.vscode-xml
$code --force --install-extension dotjoshjohnson.xml



# git
$code --force --install-extension eamodio.gitlens
# github
$code --force --install-extension github.vscode-github-actions

# related with maven (mostly java) 
# vulnerabilities
$code --force --install-extension redhat.fabric8-analytics

# python and jupyter notebook 
#$code --force --install-extension Gimly81.matlab
#$code --force --install-extension ms-python.python
$code --force --install-extension ms-python.pylint
#$code --force --install-extension bmewburn.vscode-intelephense-client # php
#$code --install-extension v--force scjava.vscode-java-pack# includes java5 runner

# to start vs code on the current directory just type
# code .
# this will start in the background automatically. 

$code --force --install-extension ms-toolsai.jupyter


# C and C++
$code --force --install-extension ms-vscode.cpptools-extension-pack

# makefile
$code --force --install-extension ms-vscode.makefile-tools
$code --force --install-extension carlos-algms.make-task-provider

# for docker 
$code --force --install-extension ms-azuretools.vscode-docker
$code --force --install-extension dunstontc.vscode-docker-syntax
$code --force --install-extension ms-vscode-remote.remote-containers


#$code --list-extensions
#$code --install-extension ms-vscode.cpptools
#$code --uninstall-extension ms-vscode.csharp
#$code --install-extension Gimly81.matlab
#$code --install-extension DavidAnson.vscode-markdownlint

# octave: IDE and run
$code --force --install-extension leafvmaple.octave
$code --force --install-extension toasty-technologies.octave
$code --force --install-extension lucasfa.octaveexecution

# matlab: IDE and run (partially interactively)
$code --force --install-extension mathworks.language-matlab # IDE
$code --force --install-extension bramvanbilsen.matlab-code-run
$code --force --install-extension shinyypig.matlab-in-vscode
$code --force --install-extension apommel.matlab-interactive-terminal


# lisp
$code --force --install-extension mattn.lisp

# no perl because this is in latex and friends 


$echo "install from java and groovy" 

# groovy
$code --force --install-extension mellowmarshmallow.groovy
$code --force --install-extension nicolasvuillamy.vscode-groovy-lint
$code --force --install-extension argylewolflabs.vscode-groovy
$code --force --install-extension marlon407.code-groovy
$code --force --install-extension dontshavetheyak.groovy-guru

# java
$code --force --install-extension vscjava.vscode-java-pack
# this also installs the following: 
#$code --force --install-extension redhat.java
#$code --force --install-extension vscjava.vscode-java-debug
#$code --force --install-extension vscjava.vscode-java-test
#$code --force --install-extension vscjava.vscode-maven
#$code --force --install-extension VisualStudioExptTeam.vscodeintellicode

# also from vscjava: 
# $code --force --install-extension vscjava.vscode-java-dependency

$code --force --install-extension wmanth.jar-viewer
$code --force --install-extension cracrayol.java-pmd

# alternative test runner: 
# $code --force --install-extension javatest.java-test


$code --force --install-extension shengchen.vscode-checkstyle
$code --force --install-extension chuckjonas.apex-pmd
$code --force --install-extension sonarsource.sonarlint-vscode

$code --force --install-extension tintinweb.vscode-decompiler
$code --force --install-extension dgileadi.java-decompiler


$code --force --install-extension ryanluker.vscode-coverage-gutters

$code --force --install-extension ithildir.java-properties

echo "install misc" 


# emails
$code --force --install-extension tomashubelbauer.email-viewer

# misc
$code --force --install-extension trond-snekvik.simple-rst
$code --force --install-extension maarti.jenkins-doc
$code --force --install-extension pdconsec.vscode-print
$code --force --install-extension pdconsec.vscode-print

source ./instVScode4tex.sh $@



