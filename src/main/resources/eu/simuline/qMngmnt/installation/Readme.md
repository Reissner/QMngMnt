

# Installation

## Basic installation

This computer is newly installed with suse tumbleweed with date 2020-03-22.
For further updates keep an iso copy of that installation. 
No user directory was taken over from an oder installation. 
The only specific settings are

- choosing KDE, 
- a single user with name and passwords. 
Else, e.g. for locales, default settings are used. 

Note that the computer is connected to the internet. 

This computer is regularly updated typing as root in a shell: 

```
zypper dup
```




Thus the actual installation date should not be vital. 
See also section on automatic updates.



## Hardware Configuration 

Hardware are screen, printer and keyboard. 

### Screen Settings 

The underlying computer is a laptop run with its own screen and an external one. 
Initially, this may cause problems but if so just switch off the external screen 
and use the laptop screen. 
Then the kicker shall be placed correctly. 

From start menu choose "System Settings" 
and therein move to "Hardware"-->"Display and Montior". 
Click opens dialog "Display Configuration". 
First we choose device other than "Laptop Screen" which is the external one. 
It shall be enabled and primary. 
Then move on to "Laptop Screen" which shall be enabled also but 
(which is automatically) not primary. 
Then choose that it is a "Replica of" the external screen. 

Note that if the big screen is switched off or disconnected, 
the laptop screen is represented correctly, 
and if the external screen is reconnected, 
this is the one represented correctly. 


Still needed is Windows behavior: 
In "System Settings" choose "Workspace"-->"Window Management" 
to open "Window Behavior". 
In tab "Focus" choose windows activation policy: "Focus follows mouse" and 
Raising windows: "Raise on hover,..."

### Printer Settings
For the printer just open this document in Okular and try to print. 
If offers only print to file, to printer is configured. 
Then enter yast and select "Hardware"-->"Printers". 
Note that also in "System Settings" one can choose "Hardware"-->"Printers" 
but that seems not work properly. 
Yast also offers printing a test page.

### Keyboard settings
As I use an US-international keyboard
which can be configured at installation time an changed later also. 

### USB settings 

Add user to groups `dialout`, `lock`, `tty` and `uucp`. 
For the latter first install package `system-user-uucp` 
as described below. 

### Panel additions 

Add widgets to the panel: hoover over panel 
and right click mouse to add widgets: 
- Battery widget; battery only available after reboot 

## Software installation 

On desktop there is Dolphin starting at "Home" folder, 
but this does not update correctly, 
so delete and add a link instead: choose Dolphin from start menu 
and add as link. 
Likewise too with terminal. 

Next subject is ssh: it is preinstalled but necessary to create keys. 
Since already tied to gitlab and github, 
reconstruct `~/.ssh`. 


### Automatic Updates
We follow all automatic updates offered by suse. 
Unfortunately, this frequently fails and the interface 
has no way to signify to the user what went wrong. 
Thus, if update fails, run an update manually 
typing as root in a shell: 

```
zypper dup 
```

In some cases, the installation medium is required to fulfill the task. 
Sometimes decisions must be taken. 
This may introduce nondeterminacy. 
There are simple rules to follow 
and which leave only one choice frequently: 

- never break a dependency 
- never keep an obsolete package. 
- there may be more to come here... 


### Installation with script

This directory contains a script `installZypper.sh` 
which is mostly a sequence of commands `zypper in -y ...`. 
Note that for several pieces of software, 
an additional configuration is needed. 
This directory also contains further files, e.g. rpm's and folders 
needed by this script. 
One example is `teams...`. 
Note that there is no automatic upgrade. 



### Installation from Yast

TBD: rework: the focus is no longer on yast, 
since we have an install script now 

Note that besides installation, yast offers update and deinstallation also. 

First add a link to `yast` to the desktop. 
From yast install

- `MozillaThunderbird` is in the base installation, 
  whereas `MozillaThunderbird-translations-common` is provided by the script. 
  As the main directory was not preserved, 
  `~/.thunderbird` must be reconstructed.
  Add a link to the desktop. 
  It is advisable to start thunderbird and to ensure that all mails are present.
  Note:
  Does not work: Write an email, right click and "Add dictionary" choose german
  and install german language pack.

- Google chrome is the browser we choose
  (*CAUTION*: package `google-chrome-stable` as given by the script).
  As browsers firefox, chromium and google chrome are available,
  google chrome is the only non-open source but it is the sole
  supporting the important markdown extension markdown viewer 3.9. 
  It is installed by the install script already. What we need is extensions. 
  Make the default browser. 

  Enter Settings-->Extensions, activate "Developer Mode" 
  and in the menu choose (**bottom!**) 
  "Open Chrome Webstore" and from that choose the extensions we need: 
  
  - "markdown viewer". Allow file access and collect errors. 
	An icon "m" occurs in the tool bar. 
    I feel theme markdown is best. 
	I would switch on all compiler options and all content options. 
	Most notably: mathjax and toc, 
	but not pedantic as this removes newline from code!!
	Appearance: show home button and bookmark bar. 
	  
  - "Super Auto Refresh Plus" very important 
    if designing something for html 
	like markdown or code documentation (javadoc or doxygen). 
	Switch on "Bypass cache when reloading the page"
  
  - "video downloader plus 7.2.0" (fun but also to store tutorials)
  
<!-- - `mathjax` to render math in the browser -->

<!-- - for zabbix: `zabbix-server-mysql`, `zabbix-proxy-mysql`, 
  `zabbix-java-gateway`, `zabbix-phpfrontend` -->
  
<!-- - `drush` maybe providing drupal also -->

<!-- - `okular` is installed in basic version but needed are also 
  - `calligra-extras-okular` viewing MS trash 
  - `okular-spectre` viewing postscript and that like. -->
  
<!-- - `evince` for support of xfa forms. 
  As soon as okular supports them, evince is no longer needed. -->
  
<!-- - `qemu-kvm` for virtualization. -->
  
<!-- - git: packages `git` and `git-doc`. 
  Note that this installs also `subversion`, 
  possibly just to be able to convert. 
  Also needed: package `bash-git-prompt` and follow 
  `/usr/share/bash-git-prompt/README.md`.
    
  Follow the instructions in `/etc/bash_completion.d/git.sh`. -->
  
  
  

  
 
<!-- - some gui for git... there is sould make more experiments 
  giggle, gitg, gitk, qgit, cgit, gitgslave, stgit fsagdfa, git-cola: 
  Currently, only GitAhead described 
  in [Installation by direct download: GitAhead](#instYast) is used. -->
  
  
<!-- - `svn` and `kdesvn` which is used also by dolphin (see below). 
  Maybe in the long run, this is not really necessary. -->
  
 
<!-- - `mercurial`: needed for mbed cli tool as many libraries are under hg control. 
  As `mercurial` is written in python, 
  we could also install via `pip install mercurial` 
  but this seems a way for windows. 
  For suse yast is always preferred. -->
  While the installation script does install mercurial (hg) in itself, 
  activation of extensions must be done manual. 
  Further information is provided by `hg help extensions`. 
  For internal extensions like `purge`, 
  just ensure that in `~/.hgrc` there is a section `[extensions]` 
  and in this a line like `purge = `. 
  Of course, restoring the home folder restores also extensions. 

<!-- - `dolphin-plugins`: installed by script but then in dolphin also: 
	maybe after restarting dolphin: 
  Settings- ->"Configure Dolphin"- ->Services: Mercurial and Git, subversion
  Note that overlays work only if tab shows folder within git control. -->
  
<!-- - A LAMP server (Linux, Apache, mysql/Mariadb, PHP). 
  This is quite a complicated task 
  so that we refer to https://en.opensuse.org/SDB:LAMP_setup 
  which is a mixture between yast usage and configuration going beyond this. 
  Note that in tumbleweed mariadb replaces mysql 
  but has same functionality. -->
  
<!-- - `bugzilla` as a buck tracker (requires a lot as mysql, apache2 and so on)
  Requires LAMP server as described above. 
  The problem is, that this installation is not complete. 
  TBD: inform tumbleweed team. 
  To complete enter `/srv/www/bugzilla` and type 
  `./checksetup.pl --check-modules`. 
  Do installation as required there. 
  
  CAUTION: sth strange: installation from suse requires outdated python 2.7 
  although i cannot figure out why python at all!!! -->
  

<!-- - `yum` always important -->

<!-- - gcc: package `gcc` needed e.g. for `pip` 
  Stange: although `cross-arm-none-gcc9` if look at file list unveils
  `arm-none-eabi-cpp` which is exactly what we need for `mbed`, 
  it turns out that there are deviations: 
  in `bin`, `arm-none-eabi-gcc` is present, 
  whereas `arm-none-eabi-g++` is missing. 
  Thus for mbed one has to download gcc separately 
  as described in [Installation by direct download: gcc-none-eabi](#TBD).  -->
  
<!-- - package `gcc-c++` also necessary for C++ support, 
  likewise `gcc-fortran` for fortran, e.g. in conjunction with `octave` 
  also `gcc-ada` for ada . 
  Finally, cross compiler `cross-arm-gcc10`. 
  Also available: `gcc-go`, `gcc-d`, `gcc-objc`, `gcc-obj-c++` -->
  
  
<!-- - `readline-devel` for octave compiling myself. -->

<!-- - package `f2c`: A fortran to c translator. 
  Although octave can be installed directly, 
  to access older versions and to compile them, 
  besides `gcc-fortran` also `f2c` is needed. -->
  
<!-- - package `gperf`, `flex` perfect hash 
for building octave from the source. -->

<!-- - `mono-core`: needed to run net cross platform. 
  later on also needed to develop. 
  Then also interesting: `monodoc-core`
  To build: `mono-addins-msbuild`
  
  TBC: not sufficient  
  - did `apt-get install mono-complete` 
  - also `wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe`
  This enables us to run nuget as `mono nuget.exe` -->

- The script installs `texlive` .... a lot of packages including `latexmk` 
  Unfortunately, there are packages including python 2.7 still. 
  The script removes these packages and also python 2.7 
  after having installed `texlive`. 
  In fact, `texlive` not only installs packages we dont need, 
  in contrary, we need additional packages 
  also installed by the script. 
  
  `texlive` includes `texlive-latexmk` providing the "make tool" `latexmk`. 
  Here also an evaluation 
  of `texlive-arara`, `rubber` and `texlive-cluttex` would be fine. 
  
  <!--
  Another aspect is connecting the beautiful world of latex with 
  the ugly but frequently used. 
  To that end, we installed `latex2rtf`, `latex2html`, 
  `texlive-latex2man`, `texlive-latex2nemeth`. 
  In addition we have `unoconv` and `pandoc`. 
  Note that we are very versatile here, 
  because we must support our latex-maven-plugin. 
  Note that `unoconv` offers a lot of stuff: 
  `odt2xxx` and `ooxml2xxx` and many other. 
  Seemingly.. hm nothing about html to odt or what. 
  
  Here is a list (to be extended) 
  Note that `texlive-srcltx` is deprecated.
  Also installed by the script: 
  - `texlive-xurl`: break in url, 
  - not yet `texlive-latexgit` (not yet useable), ...  
  - `texlive-import`, `texlive-verbatimbox`, 
  - `texlive-splitindex`, `texlive-robustindex`, `xindy`, `xindy-doc`
   For use with doxygen: `texlive-hanging`, `texlive-stackengine`, 
  `texlive-tocloft`, `texlive-etoc`, .... 
  
  git in texlive: details TBD  -->

  
 <!--  TBD: For creating html, evaluate `texlive-lpwarp`
  
  
- `texi2html`, `texinfo`
- `docbook2x`, `docbook2x-doc`
  -->
  
  <!--
- `pandoc` converting between various documentation formats. 
  This will be used in future by my latex plugin. 

- `libreoffice` mainly used headless for scripting.  
-->

<!-- - Install `aspell` with language packages german, english, french. -->

- Although in some cases `~/.emacs` exists in basic installation from prior installations, 
  emacs itself is not installed. 
  But of course certain settings are installed. 
  Install `emacs` and `gnuserv` which includes emacsclient.
  To make emacsclient run, add to `~/.emacs` the line "`(server-start)`".

  The first to customize is in menu Options-->"Use CUA keys".  
  Next activate "delete selection mode".  
  Also time by time Options-->"Show/Hide" contains valuable aspects
  like column/line number and even global line numbers.

  Next point is the emacs packages: Options-->"ManagePackages"
  Experimental:
  It seems as if in `~/.emacs` one has to add the following
  to see the full range of packages in melpa (package manager):
  

  
  ``` 
  (require 'package)
    (add-to-list 'package-archives
    '("melpa-stable" . "https://stable.melpa.org/packages/"))
    (package-initialize)
   ```

   Then we can add the packages we need:
   - for markup/down (the latter TBC): `markdown-mode-2.3` and `markup` 
   - `csharp-mode` for csharp
   - for php: `ac-php` and `phps-mode`
   - for python: `jedi`, maybe more like `importmagic`, `lsp-jedi` 
     (TBC: which lsp server)
	 - For java we mainly rely on eclim which is based on eclipse. 
	   It is not at all clear how to install this. 
	   Maybe headless. TBC
	   Seemingly, only plugins are available in tumbleweed. 
	   Then there must be an installation of eclim, TBD. 
	   What are clear, are the emacs packages to access eclipse via eclim 
	   or directly. 
	   Also TBC: which of the packages are obsolete if we have eclim. 
	   - `ac-emacs-eclim` for auto completion which installs `eclim` package
         as a dependency (CAUTION: this is not eclim server), 
	   - `lsp-java` relies on the lsp server from eclipse 
	   - `java-imports`, `javaimp`, `organize-imports-java`: handle imports
	   - `javadoc-lookup`: javadoc integration
	   - `jdecomp`, `autodisass-java-bytecode`: for decompiler

	   (not tried `meghananda`)

   - For latex: 
     - `auctex-12.2.0` TBC: seems to be a yast package also `emacs-auctex` 
	   which is already installed. 
        Auctex in turn is quite complex and needs to be configured:  
		LaTeX- ->xxx- ->"Browse Options" then select:  
		"Tex command"- ->"Tex view" 
		Here there is something to do 
	 
		 - "Tex View Program Selection". 
           Here, under output-pdf replace evince by okular. 
		   Then forward search shall already work. 
		 - "Tex Source Correlate Mode": on  
		 - "Tex Source Correlate Start Server": on  
	   
		 - To enable backward search in Okular 
		   choose Settings-->"Configure Okular"
		   Select Editor and choose emacsclient. 
	   
		 - Also there seems a bug in current auctex and okular 
		   as the "Tex View Program List" is just empty. 
		   The old setting is no longer valid as masterdir disappeared. 
	      	Thus in `.gnu-emacs-custom` after
	       `TeX-source-correlate-start-server` add 
		   
```
'(TeX-source-correlate-start-server t)
		   '(TeX-view-program-list
(quote
    ;(("Okular" "okular -unique %o#src:%n%(masterdir)./%b"))
     (("Okular" "okular -unique %o#src:%n./%b"))
    ))
``` 
<!-- 
 -->

	    which tells okular to stick with a single 
		even if invoked with new location. 
		also `%n` is the line number in the source tex-file given by `%b`. 
	
		No adaption but a hint: 
		LaTeX-->xxx-->"Browse Options" then select:  
	 	"Tex command"-->"Latex view" 
	 	Here the default is `latex` but if you run, it is `pdflatex`. 
	 	This really makes a difference (bounding box of graphics). 
	 
	 - `auctex-latexmk` to access `latexmk`
	 - `math-symbol-lists` to access math symbols of latex 
	 - `lsp-latex` which needs an lsp server TBD: install 
	 
	   
	  - `lsp-treemacs`
	  
	  - `go-mode` for go. 
	 
	 
	 
<!--
- `autoconf`, `automake`, `libtool`
	   
- `make`: package make is in fact gnu make and cmake, 
  which is cross plattform and for the latter also the gui 
  (we will test later). 
  -->
  
<!-- - whereas on suse tumbleweed, `java11` is installed directly, 
  for windows we found the site adoptopenjdk.net with installers, 
  currently also for java11.  -->
  
- `whereas `java11` is installed directly, 
  all packages `java-15-openjdk***` must be installed explicitly.  
  
- `maven`: must be installed explicitly and  
  in addition the following plugins are needed: TBC: really? 
  At the moment did not install. 
  `antlr4-maven-plugin`, `exec-maven-plugin`, `maven-assembly-plugin`, 
  `maven-checkstyle-plugin`, `maven-clean-plugin`, 
  `maven-compiler-plugin`, `maven-dependency-plugin`, `maven-deploy-plugin`, 
  `maven-failsafe-plugin`, `maven-install-plugin`, `maven-jar-plugin`, 
  `maven-javadoc-plugin`, maven-jaxb2-plugin`, ...
  `maven-surefire-provider-junit` and `maven-surefire-provider-junit5` 
  and `maven-surefire-provider-junit5-javadoc` 
  
- antlr: package `antlr4-maven-plugin` described in the context of maven 
  presupposes most of the pieces of software required for antlr4. 
  The only packages to be installed in addition currently are  
  `antlr4-javadoc` 
  and `python3-antlr4-python3-runtime` to use in python runtime.
  
- `gradle`: downloaded experimental
  this requires `ecj` and `jgit` from eclipse foundation. 

- we already installed `python` in the course of latex, 
  or maybe it is in the base system already. 
  Choosen to install `python3-devel` with the headers 
  in order to be able to include python in other programs. 
  Checked with `pip install pycosat`. 
  Also chosen `python3-pycodestyle`. 
  Very basic: `python3-pip`, where pip is the python installer 
  needed in a very general context but also e.g. for mbed tools. 
  Maybe as a first step `pip install -U pip` updating itself. 
  Whereas `pip list` uncovers that many packages are installed, 
  we shall use pip only to install via `pip install XXX`  
  the following packages: 
  - `docx2txt` on linux, 
    because it is needed when checking in docx files in git. 
  - `mercurial`, `numpy` at least on windows; 
    on suse linux available as package `mercurial`, `python3-numpy`. 
  - For interaction with java: `jep`, 
    maybe `javabridge` because not available in
    package manager 
  - TBC:   Install also `sphinx_rtd_theme` and `Sphinx` with pip, 
    the latter not from yast where also available, 
    `restview` to view rst-files
 
  
  No good idea is to install `conda` that way, 
  because we need it as a standalone application. 
  All the rest we frequently need as mbed tools and that like, 
  shall be installed within a conda environment, 
  yet using `pip install xxx` but only within that environment. 
  That is described in a separate section. 

  Since `pip` has no dependency management, 
  also install `python3-pipdeptree`. 
  
- `jython` is the implementation of python in java. 
  This is useful in conjunction with mixed programs: 
  invoking java from python and the other way round. 
  PROBLEM: jython3 only in early stages: 
  https://github.com/jython/jython3 and https://github.com/Stewori/Jython-3.7
  
<!-- - interpreter for the matlab language: octave. 
  Install packages `octave`, `octave-cli`, `octave-doc`, 
  but in addition `octave-devel` to be able to add packages, 
  some packages from `octave-forge` (all to be evaluated) as 
  `octave-forge-cgi`, 
  `octave-forge-data-smoothing`, `octave-forge-divand`, 
  `octave-forge-interval`, `octave-forge-linear-algebra`, 
  `octave-forge-lssa`, `octave-forge-quaternion`,... 
  Also, since python is very important: `python3-oct2py` 
  
  In addition i need to compile octave myself. 
  This is to support various versions. 
  Thus it is good to have Qhull -->
  
- `php` as package `php7`; maybe this is a bit experimental 
  and is needed mainly for some application, it may be useful. 
  
<!-- - javascript, i.e. package `js`
   
- `uucp`: unix to unix copy and 
  `system-user-uucp`: experimental because of problems with usb. 
  
- `cutecom` to connect to a serial interface (analog to hterm for windows). 

- `moreutils` provides a bunch of utilities, e.g. errno

- `zip` for win compatibility

- `gparted` zum partitionieren. Auch wegen mbed controller. -->

<!-- - `xsane` for linux

- `gimp` TBC: which packages in addition -->

- `icu` international components for unicode 
  This is needed also for dotnet core. 
  
<!-- - `disount` a package providing command `markdown` -->

<!-- - `doxygen`, `doxygen2man` and `doxywizard`

- For testing: `junit` which means junit 4.x is already installed, 
  but to be installed yet: `junit-javadoc` and `junit-manual`. 
  I decided to switch to junit5 and so have to install
  `junit5`, `junit5-guide` and `junit5-javadoc`, 
  
- Give a trial (not yet recommended to install) to `junitperf` (TBC)
  also do research on cunit, libunittest++, xunit, nunit, truth, xmlunit
  
<!-- - the script installs `xfig` for drawing 
  although outdated and replaced by `tikzedt`. 
  Still needed e.g. for my doctoral thesis and to support latex-maven-plugin. 
  -->
  
<!-- - `gnuplot` and `gnuplot-doc` 

- `inkscape`
- `exif`, `exiftool` command line tools to show exif metadata, e.g. of jpg s
- `Photini`, `exiv2` and `gexif` along the same lines as exif -->

<!-- - `scrot` screenshot capture utility (seems not to work and quite simple), 
  `kshot`-->

- `prosody` to use jitsi meet video conference
<!-- - `k3b` for burning cd's-->

- 'docker'... 'kubernetes', and the part of ecosystem we need. 
  All is done by the installation script but adding users 
  These need to be in group `docker`. 
  To do this just command `usermod -aG docker $user` with the according user.
  This seems to work properly only after reboot. 
  
  To run `docker push` and `docker pull` preceed this by `docker login`
  and after finishing, command `docker logout`. 
  TBD: eliminate warning on unencrypted password. 
  
  Here only some remarks: 
  - It may turn out to be a mistake, 
	but I decided to give docker-kube, a suse-specificum 
	combining the two a chance. 
	So I instelled `docker-kubic` (not `docker`). 
  - There is a problem with my firewall so for the moment I uninstalled it. 
	Filed bug report to tumbleweed. 
	https://bugzilla.opensuse.org/show_bug.cgi?id=1179978
  - Found somewhere that `python3-docker-compose` 
	is despite of its name generally needed to compose. 
  - note that `yast2-docker` is activated after reboot only. 
  
<!--   Further installed `docker-kubic-bash-completion` and 
  both `docker-client-java` and `docker-client-java-javadoc` 
  also `python3-docker`, the docker api client in python. 

  I also tried `yast2-docker` which (after restart of yast2) 
  shows the docker images and containers and you can do things, 
  well, maybe a very thin wrapper around command line. 
-->

- for java: `eclipse`. 
  The script installs `eclipse-jdt` (eclipse java development tools) 
  which includes among others `eclipse-platform`. 
  
  Some manual adaption is needed: 
  Startup on command line with `eclipse` and choose workspace. 
  In the long run maybe `Software` or `OpenSource` and `ClosedSource` or sth. 
  This creates the workspace if not present and also creates `~/.eclipse` 
  in which also the location of the workspace is stored. 
  
  Open eclipse and select Help-->"Install new Software". 
  After "Work with" type  http://download.eclipse.org/releases/2020-03 
  which opens a tree of ?plugins? which can be installed. 
  We need 
  - Collaboration 
    - Git integration for Eclipse (maybe)
  - General Purpose Tools
     - m2e maven Integration for eclipse
	 - marketplace client
  - Programming Languages 
     - Eclipse Java Development Tools (maybe)

  Note that one has to install this for each workspace anew. 
  
  CAUTION: be sure to uncheck "Contact all update sites..."
  
  Open eclipse and select Help -->"Market Place" and use find
  - xtext 
  - jbc (byte code)
  - antlr 4 ide 
  
- `virtualbox` is installed by the script, but nevertheless, 
   additional manual steps are required. 
   First it is advisable to put its icon on the desktop. 
   The next steps are all asked when trying to start `virtualbox`: 
   - add user to `vboxusers` group.  
     This can be done with yast `user and group management`. 
	 Dont forget to login anew. 
   - accept activation of usb device (`enable`). 
   - enable cut and paste and others through guest additions: 
     For each vm crated choose from the manu bar 
	 Devices- ->"insert guest additions CD image..." 
	 even if you dont have a CD image. 
	 Then it is looking for it on internet. 
	 It shows the url and asks whether to download. Confirm this. 
	 Confirm also the rest (at the end it will ask whether allowed to run a scipt)
   - from the manu bar 
	 - Devices- ->"Shared Clipboard" choose "bidirectional" 
	 - Devices- ->"Drag and Drop" choose "bidirectional" 
   - The window is small. 
     To solve that problem shutdown the machine 
	 and from virtualbox's menu choose Machine - ->Settings- ->Display 
	 - 'Scale Factor' as 200% (why so ever) and in next boot back to 100%
	 - 'Graphics controller' as 'VboxVGA' and then back to `VMSVGA`
   - for ubuntu: root with `sudo -s`. 
  
#### Yast Virtualization Hypervisor

Choose KVM server and tools
  


## Installation with suse one click install / zypper

To find sth like that, just google like `suse one click install eclipse`. 
Then the site recognizes already the distribution, which is tumbleweed for
me. 
One click install offers `direct install` and `Expert Download`. 
The latter offers you command line operation 
typically consisting of the steps 
Normally `zypper addrepo`, `zypper refresh` and `zypper install`. 
We use that directly on the console as, in contrast to `direct install`, 
- we find out what is wrong if something does not work, 
- we know how to include this into the installation script `./instZypper.sh`. 

  

## Installation with yum and zypper <a id="instYZ"/>

conda. As this relies on python, 
first install that through yast as specified there. 

as described in 

https://docs.conda.io/projects/conda/en/latest/user-guide/install/rpm-debian.html
for rpm based systems (also for debian as suggested by the url). 

	CAUTION: `conda` can be installed via `pip` also 
	(`pip install conda`) but this does not yield conda 
	as a standalone application as we need. 

Check installation with `conda info`. 
Activate shell support now typing `conda init bash` 
which results in an indication of the environment on the shell, 
which should be `(base)` initially. 

On
https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html 
there is an installer for miniconda and for anaconda. 
Seemingly, for anaconda there is no rpm available. 

A word on anaconda, miniconda and conda: 
anaconda and miniconda are distributions. 
conda is their common package manager. 
miniconda is a subset of anaconda containing no much more than 

- python, 
- conda, pip, 
- some basic utilities as xz. 


The reason for needing conda is just the `mbed-cli`-tool 
which is sensitive to python version and is currently available for python
3.7.1 only. 
Thus `mbed-cli` shall be used in conda environment only. 
Take the following steps: 

- check `python -V` displays version 3.8.3 
- initialize bash shell to display environment: `conda init bash`.  
  Close bash and re-open and check that environment is indicated `(base)`
- create an environment: `conda create --name envForMbedPy3.7.1 python=3.7.1`
  creates an environment with the given name based on python 3.7.1. 
- change into this environment: `conda activate envForMbedPy3.7.1` 
  and check python -V is 3.7.1 
- update pip through `pip install -U pip` 
- install via `pip install XXX` the packages: 
  `pytest-shutil`, ...

- install mbed tool via `pip install mbed-cli` 
  and check by `mbed --version` whether version is still 
- cd into some `mbed-os` and upgrade via `pip install -r requirements.txt`
  Result is that this works for python versions 

  |version   | 3.6.10 | 3.7.1 | 3.7.6 | 3.8.2 |
  |:---------| ------ | ----- | ----- | ----- |
  |Result    | ok     | !gcc! |   ok  |   ok  |
 

  TBC: here seems sth wrong: older trials unveilled problems 
  but now they seem to be gone. 
- now we ensure that the compilation toolchain is installed. 
  Currently we need one toolchain only: GCC_ARM. 
  This is described in [Installation by direct download](#test). 
  The binaries should be in `/home/ernst/SysAdmin/GccArmNoneEabi/latest/bin`.
- Finally, we configure the toolchain by 
  ```
	  mbed config --global GCC_ARM /home/ernst/SysAdmin/GccArmNoneEabi/latest/bin
  ```
  To check whether all is ok, one could download the blinky example via 
  ```
	  mbed import http://os.mbed.com/teams/mbed-os-examples/code/mbed-os-example-blinky/
  ```
  and compile with `mbed compile --flash`. 
  
 
  


## Installation by direct download <a name="instDL"></a>

Note that emacs has its own installation framework
but this is treated under 
[Installation from Yast: emacs](#markdown-header-installation-from-yast)
Same is true for google chrome and for thunderbird to some extent. 
Also `python` is installed only using `conda`. 

What we consider here, is software without such embedded package management. 
For all these pieces of software we have a separate folder in `~\SysAdmin`. 
There are cases, where there is no versioning (EdsSharp) 
but in general, there is a separate folder for each version, 
a link `latest` pointing to that folder and optionally further files 
prior to extracting folders, like tgz or related. 



- GitAhead installed from https://gitahead.github.io/gitahead.com/
- TikzEdt installed from https://code.google.com/archive/p/tikzedt/downloads 
  but here the problem is, that we need modifications. 
  Most probably, when trying to use, an error occurs, 
  The preview is marked to be `unavailable`, 
  in the Status-tab, a bad return value occurs and in tab pdflatex output 
  something like `Fatal format file error; I'm stymied` occurs. 
  
  The resolution is not really simple to find, but simple to execute: 
  Note that in `~/.config/TikzEdtWForms/TikzEdtWForms/0.2.1.0`, 
  well, version may deviate, 
  there is a file `temp_header.fmt`. 
  If `latex` is installed, this file is likely to be created anew. 
  Just delete it, and tikzedt will do it for you. 
  If you leave it, it cannot recover. 
  
- To compile with mbed-cli, 
  the package `arm-none-eabi-gcc` must be downloaded from 
  https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
  
  
- EdsEditor ***
  TBC: The main problem with this tool is that it is not cross plattform. 
  Another problem: there is no script version of it. 
  
  
- dotnet sdk: 
  For opensuse consult https://snapcraft.io/install/dotnet-sdk/opensuse 
  CAUTION: for tumbleweed type 
  ```
  zypper addrepo --refresh
  https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed
  snappy
  ```
  which differs a little form the given `Leap_15.0`. 
  Well, all concerning `snapd.apparmor` didn't work for me, 
  but installation proceeded though. 
  
  A little problem because command line tool `dotnet` did not show up: 
  Instead I got `dotnet-sdk.dotnet` but one can add an alias. 
  Just type `snap alias dotnet-sdk.dotnet dotnet` as superuser. 
  
  There is a second way to install dotnet shown by   
  https://docs.microsoft.com/de-de/dotnet/core/install/linux-package-manager-opensuse15
  The problem is that the first `zypper install libicu` does not work. 
  ICU stands for "International Components for Unicode". 
  The installation via snap does not have this step. 
  What turns out is, that the `.dll` can be run without a problem, 
  but `dotnet run` does not work because `libicu` is not found. 
  In fact it is present as `libicu66` (version 66) 
  but does not provide `libicu` and is thus not found.
  Most probably a packaging problem of suse tumbleweed. 
  
  The solution, or workaround we found is applied after creating a project 
  for each project individually. 
  Now one can use the basic dotnet tool 
  and one could also create a new project using `dotnet new console`, 
  or to specify a folder `dotnet new console --output ProjName` 
  where `console` is the kind of project and is just a simple example. 
  This creates files `Program.cs` and `ProjName.csproj`. 
  The workaround for missing ICU is using culture invariant setting 
  adding an item group to obtain the following `ProjName.csproj`: 
  ```
	<Project Sdk="Microsoft.NET.Sdk">
	
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp3.1</TargetFramework>
      </PropertyGroup>

      <ItemGroup>
        <RuntimeHostConfigurationOption Include="System.Globalization.Invariant" Value="true"/>
      </ItemGroup>
    </Project>
  ```
  
  By the way, `dotnet new --list` lists the kinds of applications supported, 
  amoth others `console` and `wpf`. 
  If I understand right, wpf can be developed on linux 
  but it cannot run... hm. 
  
  For several reasons, among those, wpf is not cross plattform 
  and needs a lot of boilerplate, and is ugly, well... 
  We decided to give AvaloniaUI a trial. 
  A howto which seems to be really good can be found in 
  ```
  https://developer-blog.net/avalonia-ui-tutorial/?cookie-state-change=1587214517102
  ```
  
  We tell sth about the steps:   
  First clone: 
  ```
  git clone https://github.com/AvaloniaUI/avalonia-dotnet-templates.git
  ```
  Then install (caution: `/` is linux, for windoofs use '\' 
  and please dont omit the slashes) 
  ```
  	dotnet new --install ./avalonia-dotnet-templates/
  ```
  
  Listing the templates again with `dotnet new --list` 
  yields 4 additional lines: 
  ```
  Avalonia .NET Core MVVM App avalonia.mvvm        [C#] ui/xaml  
  Avalonia .NET Core App      avalonia.app         [C#] ui/xaml  
  Avalonia UserControl        avalonia.usercontrol [C#] ui/xaml  
  Avalonia Window             avalonia.window      [C#] ui/xaml  
  ```

  This enables us to use these templates, 
  e.g. as `dotnet new avalonia.app -o Projektname`. 

- installation for `eclipse` for java and for csharp. 
  First go to https://www.eclipse.org/downloads/ and download eclipse ide. 
  In fact this is just the downloader. 
  You must gunzip and untar and then run the installer which asks you for the
  language to develop for. 
  Choose java. 
  Then start and observe the settings. 
  You easily find out the location of the executable `eclipse`. 
  You can start by `./eclipse`. 
  To install permanently, set the `PATH` environment variable accordingly. 
  
  Within eclipse from menu choose `help-->Eclipse Marketplace` and search for
  `acute` and install it. 
  
