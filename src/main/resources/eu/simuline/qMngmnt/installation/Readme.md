<!-- markdownlint-disable no-trailing-spaces -->
<!-- markdownlint-disable no-inline-html -->

# Installation

## Basic installation <a id='ssBasic'></a>

Computers shall be newly installed with SUSE tumbleweed. 
Currently, ISO images are available at the [internet](https://download.opensuse.org/tumbleweed/iso/), 
but only the current version. 
To keep installations uniform, we always use the same version, 
currently we use the ISO image with date 2020-03-22 kept at a disc. 

This description refers to the case, that no user directory was taken over from another installation. 
<!-- This would be an interesting aspect: how to take over... Also two partitions and so -->
The only specific settings are

- Choosing KDE, 
- a single user with name and passwords. 

Else, e.g. for locales, default settings are used, which means US. 

At this stage, the computer is endowed with a minimal installation with outdated software. 

We assume that the computer is connected to the internet which can be used for updates 
and for adding further software. 

Although SUSE offers an automatic update, it is not recommended using it. 
Instead, the computer is regularly updated typing as root in a shell: 

```[sh]
zypper dup
```

Note that `zypper` is the package manager for SUSE which is based on the rpm format, 
and the command `dup` stands for 'differential update'. 
A [cheat sheet](./Zypper-cheat-sheet-1.pdf) is available also. 

After having performed the basic installation followed by updating by `zypper dup`, 
the installation is as the basic installation with a newer date. 

Thus, the actual installation date of the basic installation should not be vital. 
Instead of just running `zypper dup`, we use a more [elaborate installation procedure](#sssInstScript) 
based on scripts. 

For more information on automatic updates, see also section on [automatic updates](#sssAutoUpdate). 

## Hardware Configuration <a id='ssHWConfig'></a>

Hardware are screen, printer and keyboard, USB and panel additions. 
Note that the hardware configurations require some software in advance: 

- `ocular`, which is available in the base config 
- `system-user-uucp` which must be installed by our installation script. 
  Thus, we recommend executing software installation by script [first](#sssInstScript). 

### Screen Settings <a id='sssHwScreen'></a>

The underlying computer is a laptop run with its own screen and an external one. 
Initially, this may cause problems but if so just switch off the external screen 
and use the laptop screen. 
Then the kicker shall be placed correctly. 

From start menu choose "System Settings" 
and therein move to "Hardware"--!>"Display and Monitor". 
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
In "System Settings" choose "Workspace"--!>"Window Management" 
to open "Window Behavior". 
In tab "Focus" choose windows activation policy: "Focus follows mouse" and 
Raising windows: "Raise on hover, ..."

### Printer Settings <a id='sssHwPrint'></a>

For the printer just open this document in `okular` 
(which should be installed before as described [above](#ssBasic])) 
and try to print. 
If offers only print to file, to printer is configured. 
Then enter YaST and select "Hardware"--!>"Printers". 
Note that also in "System Settings" one can choose "Hardware"--!>"Printers" 
but that seems not work properly. 
YaST also offers printing a test page.

### Keyboard settings <a id='sssHwKeyboard'></a>

As I use a US-international keyboard
which can be configured at installation time and changed later also. 
TBD: This is not really true: we use a European extension of a US-keyboard. 
The [layout](https://eurkey.steffen.bruentjen.eu/layout.html) 
and the 
[download of the `.xmodmap`](https://eurkey.steffen.bruentjen.eu/download/xmodmap/0/Xmodmap_alpha) 
are available from the internet. 
TBD: Further research. 

### USB settings <a id='sssHwUSB'></a>

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
Likewise, too with terminal. 

Next subject is ssh: it is preinstalled but necessary to create keys. 
Since already tied to `gitlab` and `github`, 
reconstruct `~/.ssh`. 

### Automatic Updates <a id='sssAutoUpdate'></a>

SUSE offers automatic updates but unfortunately, this frequently fails and the interface 
has no way to signify to the user what went wrong. 
SUSE suggests to use manual update typing as root in a shell: 

```[sh]
zypper dup 
```

Here, `dup` stands for 'differential update'. 
In some cases, the installation medium is required to fulfill the task. 
Sometimes decisions must be taken. 
This may introduce indeterminacy. 
There are simple rules to follow 
and which leave only one choice frequently: 

- never break a dependency, 
- never keep an obsolete package, 
- more to come here

Since those updates may comprise some thousands of packages, 
it is difficult to keep an overview of the most important packages changed. 
Note that the script [`instZypper.sh`](./instZypper.sh) 
not only installs the vital packages needed and going beyond the base installation, 
but it also serves to update. 
Thus, we recommend running `instZypper.sh` before `zypper dup` 
to obtain an impression of what packages are affected by the update. 
Note that unlike `zypper dup`, the script does not ask for confirmation. 

A very good feature of visual code is, 
that it allows installing extensions and updating them by script also. 
To that end run [`instVScode.sh`](./instVScode.sh) as user, not as root. 

### Installation with script <a id='sssInstScript'></a>

After [basic installation](#ssBasic), we have an outdated and very rudimentary software installation. 
At least a bash shell shall be available. 
The directory of this README contains a bunch of scripts to perform installations. 

First become the `root` user. 

The first step to extend the base installation is 
to add repositories invoking [`./addRepos.sh`](./addRepos.sh). 
This is mostly a sequence of `zypper`'s `addrepo` commands followed by a final `refresh` command. 
Note that if running this script if a repository is added already, 
an error is displayed. 
There is no simple way to tell `zypper` to add a repository if not yet added. 
So we accept the errors. 

Then run the script [`instZypper.sh`](./instZypper.sh) 
which is mostly a sequence of commands `zypper in -y ...`. 
Note that in rare cases, also software is uninstalled, using `zypper rm ...` so as for `python2`. 
In particular, `wget` and `snapd` are installed that way and later used to install further software 
not available via `zypper` directly. 
Whereas `snap` provided by `snapd` is standalone like `zypper`, `wget` is just for downloading. 
It is used in conjunction with `rpm` to install software. 
Note that `rpm`, like `zypper` is available on the base system. 

At this point in particular Google Chrome is already installed, 
but still the extensions are missing 
and shall be installed invoking [`instGCexts.sh`](./instGCexts.sh). 
Note that this script uses a JSON [template](.chromeExtId.json). 
For details on [`instGCexts.sh`](./instGCexts.sh), 
in particular how to generalize and to extend the script, 
see [here](./instGCexts.md). 


The rest of the installation scripts are performed 
not as `root` but as user. 

At this point `code` is installed already, 
but the extensions are still missing 
and shall be installed invoking [`instVScode.sh`](./instVScode.sh). 

Because neither Google Chrome nor Firefox 
work perfectly we need both browsers. 
At this stage Firefox is installed 
and to install the extensions also, 
invoke [`instFFexts.sh`](./instFFexts.sh). 
The user still has to acknowledge manually twice 
and close the browser also manually for each extension. 
After the last extension is installed, the script returns. 



CAUTION: For several pieces of software, 
an additional configuration is needed. 
This directory also contains further files, e.g. rpm's and folders 
needed by this script. 
One example is used to be `teams...`. 
Note that in those cases, there is no automatic upgrade. 
Now `teams` gets onto my nerves 
because of the splash screen it always shows when booting the computer. 
Thus, the script uninstalls it. 

A very good feature of visual code is, 
that it allows installing extensions and updating them by script also. 
To that end run [`instVScode.sh`](./instVScode.sh) as user, not as root. 

Similar mechanisms are available for our browsers to install extensions 
and for `conda` to install packages via `pip`. 
Some packages are also installed outside `conda` environments. 
These are installed via [`instPip.sh`](./instPip.sh). 

### Installation from `yast`

Note that besides installation, `yast` offers queries, 
update and uninstallation also. 
Among the queries is the file list. 

The focus is no longer on `yast`, 
since we have an installation script now, 
but it is still a good idea to try to install with `yast` first. 
The first step would be to look up the desired package. 
If found, that way the correct name is unveiled 
which can be added 
to the installation script [`instZypper.sh`](./instZypper.sh). 
Never install via `yast` to keep the scripts consistent, 
and if you do for check, uninstall the installed package immediately. 

Sometimes the desired package does not show up. 
Maybe only because the repository is not added. 
In this case try a [one click install](#sssOneClick). 



#### YaST Virtualization Hypervisor

Choose KVM server and tools
### Manual configurations 

First add a link to `yast` to the desktop. 
From `yast` install

- `MozillaThunderbird` is in the base installation, 
  whereas `MozillaThunderbird-translations-common` is provided by the script. 
  As the main directory was not preserved, 
  `~/.thunderbird` must be reconstructed.
  Add a link to the desktop. 
  It is advisable to start thunderbird and to ensure that all mails are present.
  Note:
  Does not work: Write an email, right click and "Add dictionary" choose `german`
  and install German language pack.

- Google Chrome is the browser we choose
  (*CAUTION*: package `google-chrome-stable` as given by the script).
  As browsers `firefox`, `chromium` and Google `chrome` are available,
  Google `chrome` is the only non-open source, but it is the sole
  supporting the important markdown extension markdown viewer. 
  It is installed by the installation script already 
  and also the extensions are assumed to be installed with a script. 
  Let us skip the [details](#sssInstScript) for now. 
  Make the default browser. 

  Enter Settings--!>Extensions, activate "Developer Mode". 
  One of the extensions must still be configured manually: 

  - "Markdown Viewer". Allow file access and collect errors. 
    An icon "m" occurs in the toolbar. 
    I feel theme markdown is best. 
    I would switch on all compiler options and all content options. 
    Most notably: `mathjax` and `toc`, 
    but not pedantic as this removes newline from code!!
    Appearance: show home button and bookmark bar. 

  Two further extensions shall be mentioned:

  - "Super Auto Refresh Plus" very important 
    if designing something for `html` 
    like markdown or code documentation (`javadoc` or `doxygen`). 
    Switch on "Bypass cache when reloading the page"
  - "Video downloader plus 7.2.0" (fun but also to store tutorials)


  and in the menu choose (**bottom!**) 
  "Open Chrome Webstore" and from that choose the extensions we need: 
  
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
  For SUSE yast is always preferred. -->
  While the installation script does install mercurial (`hg`) in itself, 
  activation of extensions must be done manual. 
  Further information is provided by `hg help extensions`. 
  For internal extensions like `purge`, 
  just ensure that in `~/.hgrc` there is a section `[extensions]` 
  and in this a line like `purge=`. 
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
  
  CAUTION: sth strange: installation from SUSE requires outdated python 2.7 
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
  `emacs` itself is not installed. 
  But of course certain settings are installed. 
  Install `emacs` and `gnuserv` which includes `emacsclient`.
  To make `emacsclient` run, add to `~/.emacs` the line "`(server-start)`".

  The first to customize is in menu Options--!>"Use CUA keys".  
  Next activate "delete selection mode".  
  Also time by time Options--!>"Show/Hide" contains valuable aspects
  like column/line number and even global line numbers.

  Next point is the `emacs` packages: Options--!>"Manage Packages"
  Experimental:
  It seems as if in `~/.emacs` one has to add the following
  to see the full range of packages in `melpa` (package manager):
  
  ```[lisp]
  (require 'package)
    (add-to-list 'package-archives
    '("melpa-stable" . "https://stable.melpa.org/packages/"))
    (package-initialize)
   ```

  Then we can add the packages we need:

  - `markdown-mode-2.3` and `markup` for markup/down (the latter TBC), 
  - `csharp-mode` for c-sharp
  - for `php`: `ac-php` and `phps-mode`
  - for python: `jedi`, maybe more like `importmagic`, `lsp-jedi` 
    (TBC: which `lsp`server)
  - for java we mainly rely on `eclim` which is based on eclipse. 
    It is not at all clear how to install this. 
    Maybe headless. TBC
    Seemingly, only plugins are available in tumbleweed. 
    Then there must be an installation of `eclim`, TBD. 
    What are clear, are the `emacs` packages to access eclipse via `eclim` 
    or directly. 
    Also, TBC: which of the packages are obsolete if we have `eclim`. 
    - `ac-emacs-eclim` for auto-completion which installs `eclim` package
         as a dependency (CAUTION: this is not `eclim` server), 
    - `lsp-java` relies on the `lsp` server from eclipse 
    - `java-imports`, `javaimp`, `organize-imports-java`: handle imports
    - `javadoc-lookup`: `javadoc` integration
    - `jdecomp`, `autodisass-java-bytecode`: for decompiler

    (not tried `meghananda`)

    - For latex: 
      - `auctex-12.2.0` TBC: seems to be a YaST package also `emacs-auctex` 
        which is already installed. 
        `auctex` in turn is quite complex and needs to be configured:  
        LaTeX--!>xxx--!>"Browse Options" then select:  
        "Tex command"--!>"Tex view" 
      Here there is something to do 

      - "Tex View Program Selection". 
           Here, under `output-pdf` replace `evince` by `okular`. 
       Then forward search shall already work. 
      - "Tex Source Correlate Mode": on  
      - "Tex Source Correlate Start Server": on  

      - To enable backward search in `okular` 
        choose Settings--!>"Configure Okular"
         Select Editor and choose `emacsclient`. 
      
      - Also, there seems a bug in current `auctex` and `okular` 
       as the "Tex View Program List" is just empty. 
       The old setting is no longer valid as master directory disappeared. 
          Thus, in `.gnu-emacs-custom` after
          `TeX-source-correlate-start-server` add 
        
```[lisp]
'(TeX-source-correlate-start-server t)
      '(TeX-view-program-list
(quote
    ;(("Okular" "okular -unique %o#src:%n%(masterdir)./%b"))
     (("Okular" "okular -unique %o#src:%n./%b"))
    ))
```

<!-- 
 -->
    The above tells okular to stick with a single frame
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
  
<!-- - whereas on SUSE tumbleweed, `java11` is installed directly, 
  for windows we found the site adoptopenjdk.net with installers, 
  currently also for java11.  -->
  

  

- We already installed `python` in the course of latex, 
  or maybe it is in the base system already. 
  Chosen to install `python3-devel` with the headers 
  in order to be able to include python in other programs. 
  Checked with `pip install pycosat`. 
  Also chosen `python3-pycodestyle`. 
  Very basic: `python3-pip`, where pip is the python installer 
  needed in a very general context but also e.g. for `mbed` tools. 
  Maybe as a first step `pip install -U pip` updating itself. 
  Whereas `pip list` uncovers that many packages are installed, 
  we shall use pip only to install via `pip install XXX`  
  the following packages: 
  - `docx2txt` on Linux, 
    because it is needed when checking in `docx` files in git. 
  - `mercurial`, `numpy` at least on Windows; 
    on SUSE Linux available as package `mercurial`, `python3-numpy`. 
  - For interaction with java: `jep`, 
    maybe `javabridge` because not available in
    package manager 
  - TBC: Install also `sphinx_rtd_theme` and `Sphinx` with pip, 
    the latter not from YaST where also available, 
    `restview` to view `rst`-files
 
  No good idea is to install `conda` that way, 
  because we need it as a standalone application. 
  All the rest we frequently need as `mbed` tools and that like, 
  shall be installed within a `conda` environment, 
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

- `icu` international components for Unicode 
  This is needed also for `dotnet core`. 
  
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

- `prosody` to use `jitsi` meet video conference
<!-- - `k3b` for burning cd's-->

- `docker`... `kubernetes`, and the part of ecosystem we need. 
  All is done by the installation script but adding users 
  These need to be in group `docker`. 
  To do this just command `usermod -aG docker $user` with the according user.
  This seems to work properly only after reboot. 
  
  To run `docker push` and `docker pull` precede this by `docker login`
  and after finishing, command `docker logout`. 
  TBD: eliminate warning on unencrypted password. 
  
  Here only some remarks: 
  - It may turn out to be a mistake, 
    but I decided to give `docker-kube`, which is specific for SUSE, 
    combining the two a chance. 
    So I installed `docker-kubic` (not `docker`). 
  - There is a problem with my firewall so for the moment I uninstalled it. 
  - Filed bug report to tumbleweed. 
   	https://bugzilla.opensuse.org/show_bug.cgi?id=1179978
  - Found somewhere that `python3-docker-compose` 
    is, despite its name, generally needed to compose. 
  - Note that `yast2-docker` is activated after reboot only. 
  
<!--   Further installed `docker-kubic-bash-completion` and 
  both `docker-client-java` and `docker-client-java-javadoc` 
  also `python3-docker`, the docker api client in python. 

  I also tried `yast2-docker` which (after restart of yast2) 
  shows the docker images and containers and you can do things, 
  well, maybe a very thin wrapper around command line. 
-->

- For java: `eclipse`. 
  The script installs `eclipse-jdt` (eclipse java development tools) 
  which includes among others `eclipse-platform`. 
  
  Some manual adaption is needed: 
  Startup on command line with `eclipse` and choose workspace. 
  In the long run maybe `Software` or `OpenSource` and `ClosedSource` or something. 
  This creates the workspace if not present and also creates `~/.eclipse` 
  in which also the location of the workspace is stored. 
  
  Open eclipse and select Help->"Install new Software". 
  After "Work with" type http://download.eclipse.org/releases/2020-03 
  which opens a tree of '?plugins?', which can be installed. 
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
  
  Open eclipse and select Help --!>"Market Place" and use find
  - `xtext` 
  - `jbc` (byte code)
  - `antlr 4 ide` 
  
- `virtualbox` is installed by the script, but nevertheless, 
  additional manual steps are required. 
  First it is advisable to put its icon on the desktop. 
  The next steps are all asked when trying to start `virtualbox`: 
  - add user to `vboxusers` group.  
     This can be done with YaST `user and group management`. 
  Don't forget to log in anew. 
  - Accept activation of `usb` device (`enable`). 
  - Enable cut and paste and others through guest additions: 
     For each vm crated choose from the menu bar 
  Devices--!>"insert guest additions CD image..." 
  even if you don't have a CD image. 
  Then it is looking for the guest addition on internet. 
  It shows the URL and asks whether to download. Confirm this. 
  Confirm also the rest (at the end it will ask whether allowed to run a script)
  - from the menu bar 
  - Devices--!>"Shared Clipboard" choose "bidirectional" 
  - Devices--!>"Drag and Drop" choose "bidirectional" 
  - The window is small. 
     To solve that problem shutdown the machine 
     and from `virtualbox`'s menu choose Machine --!>Settings--!>Display 
    - 'Scale Factor' as 200% (why so ever) and in next boot back to 100%
    - 'Graphics controller' as `VboxVGA` and then back to `VMSVGA`
    - for Ubuntu: root with `sudo -s`. 
  


### Installation with SUSE one click install / `zypper` <a id='sssOneClick'></a>

To find something like that, just google like `suse one click install eclipse`. 
Then the site recognizes already the distribution, which is tumbleweed for us. 
One click install offers `direct install` and `Expert Download`. 
The latter offers you command line operation 
typically consisting of the steps 
Normally `zypper addrepo`, `zypper refresh` and `zypper install`. 
If we use that directly on the console as, in contrast to `direct install`, 

- we find out what is wrong if something does not work, 
- we know how to include this into the installation scripts: in 
  - [`addRepos.sh`](./addRepos.sh) add `zypper addrepo`, ignore `zypper refresh` 
    because this is already present and 
  - [`instZypper.sh`](./instZypper.sh) add `zypper install`. 
  
Please uninstall after manual installation, e.g. with `yast`, 
extend the scripts accordingly and run them to reinstall with scripts. 

## Installation with yum and `zypper` <a id="instYZ"></a>

## Installing `conda` <a id="ssInstConda"></a>

This presupposes `python3` 

`conda`. As this relies on python, 
first install that through `yast` as specified there as described in 

https://docs.conda.io/projects/conda/en/latest/user-guide/install/rpm-debian.html
for rpm based systems (also for Debian as suggested by the URL). 

CAUTION: `conda` can be installed via `pip` also 
(`pip install conda`) but this does not yield `conda` 
as a standalone application as we need. 

Check installation with `conda info`. 
Activate shell support now typing `conda init bash` 
which results in an indication of the environment on the shell, 
which should be `(base)` initially. 

On
https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html 
there is an installer for `miniconda` and for `anaconda`. 
Seemingly, for anaconda there is no rpm available. 

A word on `anaconda`, `miniconda` and `conda`: 
anaconda and `miniconda` are distributions. 
`conda` is their common package manager and environment manager. 
`miniconda` is a subset of anaconda containing not much more than 

- `python`, 
- `conda`, `pip`, 
- some basic utilities as `xz`. 

The reason for needing `conda` is just the `mbed-cli`-tool 
which is sensitive to python version and is currently available for python
3.7.1 only. 
Thus, `mbed-cli` shall be used in `conda` environment only. 
Take the following steps: 

- check `python -V` displays version 3.8.3, 
- initialize bash shell to display environment: `conda init bash`;  
  close bash and re-open and check that environment is indicated `(base)`
- create an environment: `conda create --name envForMbedPy3.7.1 python=3.7.1`
  creates an environment with the given name based on python 3.7.1, 
- change into this environment: `conda activate envForMbedPy3.7.1` 
  and check python -V is 3.7.1, 
- update pip through `pip install -U pip` 
- install via `pip install XXX` the packages: 
  `pytest-shutil`, ...,
- install `mbed` tool via `pip install mbed-cli`, 
  and check by `mbed --version` whether version is still 
- `cd` into some `mbed-os` and upgrade via `pip install -r requirements.txt`
  Result is that this works for python versions 

  | version   | 3.6.10 | 3.7.1   | 3.7.6 | 3.8.2 |
  | :---------| ------ | ------- | ----- | ----- |
  | Result    | ok     | !`gcc`! |   ok  |   ok  |
 
  TBC: here seems something wrong: older trials unveiled problems, 
  but now they seem to be gone. 
- Now, we ensure that the compilation tool chain is installed. 
  Currently, we need one tool chain only: GCC_ARM. 
  This is described in [Installation by direct download](#test). 
  The binaries should be in `/home/ernst/SysAdmin/GccArmNoneEabi/latest/bin`.
- Finally, we configure the tool chain by 
  
  ```[sh]
    mbed config --global GCC_ARM /home/ernst/SysAdmin/GccArmNoneEabi/latest/bin
  ```

  To check whether all is ok, one could download the `blinky` example via 

  ```[sh]
    mbed import http://os.mbed.com/teams/mbed-os-examples/code/mbed-os-example-blinky/
  ```

  ...and compile with `mbed compile --flash`. 
  
## Installation by direct download <a name="instDL"></a>

Note that `emacs` has its own installation framework,
but this is treated under 
[Installation from YaST: `emacs`](#markdown-header-installation-from-YaST)
Same is true for Google `chrome` and for thunderbird to some extent. 
Also, `python` is installed only using `conda`. 

What we consider here, is software without such embedded package management. 
For all these pieces of software we have a separate folder in `~\SysAdmin`. 
There are cases, where there is no versioning (`EdsSharp`) 
but in general, there is a separate folder for each version, 
a link `latest` pointing to that folder and optionally further files 
prior to extracting folders, like `tgz` or related. 

- `GitAhead` installed from https://gitahead.github.io/gitahead.com/
- `TikzEdt` installed from https://code.google.com/archive/p/tikzedt/downloads 
  but here the problem is, that we need modifications. 
  Most probably, when trying to use, an error occurs, 
  The preview is marked to be `unavailable`, 
  in the Status-tab, a bad return value occurs and in tab `pdflatex` output 
  something like `Fatal format file error; I'm stymied` occurs. 
  
  The resolution is not really simple to find, but simple to execute: 
  Note that in `~/.config/TikzEdtWForms/TikzEdtWForms/0.2.1.0`, 
  well, version may deviate, 
  there is a file `temp_header.fmt`. 
  If `latex` is installed, this file is likely to be created anew. 
  Just delete it, and `tikzedt` will do it for you. 
  If you leave it, it cannot recover. 

  Note that we decided to use `lualatex` so in the options replace the default `pdflatex` by `lualatex`. 
  
- To compile with `mbed-cli`, 
  the package `arm-none-eabi-gcc` must be downloaded from 
  https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
  
- `EdsEditor` ***
  TBC: The main problem with this tool is that it is not cross-platform. 
  Another problem: there is no script version of it. 
  
- `dotnet sdk`: 
  For openSUSE consult https://snapcraft.io/install/dotnet-sdk/opensuse 
  CAUTION: for tumbleweed type 

  ```[sh]
  zypper addrepo --refresh
  https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed
  snappy
  ```

  This differs a little form the given `Leap_15.0`. 
  Well, all concerning `snapd.apparmor` didn't work for me, 
  but installation proceeded though. 
  
  A little problem because command line tool `dotnet` did not show up: 
  Instead I got `dotnet-sdk.dotnet`, but one can add an alias. 
  Just type `snap alias dotnet-sdk.dotnet dotnet` as superuser. 
  
  There is a second way to install `dotnet` shown by   
  https://docs.microsoft.com/de-de/dotnet/core/install/linux-package-manager-openSUSE15
  The problem is that the first `zypper install libicu` does not work. 
  ICU stands for "International Components for Unicode". 
  The installation via snap does not have this step. 
  What turns out is, that the `.dll` can be run without a problem, 
  but `dotnet run` does not work because `libicu` is not found. 
  In fact, it is present as `libicu66` (version 66) 
  but does not provide `libicu` and is thus not found.
  Most probably a packaging problem of SUSE tumbleweed. 
  
  The solution, or workaround we found is applied after creating a project 
  for each project individually. 
  Now one can use the basic `dotnet` tool 
  and one could also create a new project using `dotnet new console`, 
  or to specify a folder `dotnet new console --output ProjName` 
  where `console` is the kind of project and is just a simple example. 
  This creates files `Program.cs` and `ProjName.csproj`. 
  The workaround for missing ICU is using culture invariant setting 
  adding an item group to obtain the following `ProjName.csproj`: 

  ```[xml]
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
  among others `console` and `wpf`. 
  If I understand right, WPF can be developed on Linux, 
  but it cannot run... hm. 
  
  For several reasons, among those, WPF is not cross-platform 
  and needs a lot of boilerplate, and is ugly, well... 
  We decided to give `AvaloniaUI` a trial. 
  A how-to which seems to be excellent can be found in 

  ```[url]
  https://developer-blog.net/avalonia-ui-tutorial/?cookie-state-change=1587214517102
  ```
  
  We tell something about the steps:   
  First clone: 

  ```[sh]
  git clone https://github.com/AvaloniaUI/avalonia-dotnet-templates.git
  ```

  Then install (caution: `/` is Linux, for Windoofs use '\', 
  and please don't omit the slashes) 

  ```[sh]
    dotnet new --install ./avalonia-dotnet-templates/
  ```
  
  Listing the templates again with `dotnet new --list` 
  yields 4 additional lines: 

  ```[console]
  Avalonia .NET Core MVVM App avalonia.mvvm        [C#] ui/xaml  
  Avalonia .NET Core App      avalonia.app         [C#] ui/xaml  
  Avalonia UserControl        avalonia.usercontrol [C#] ui/xaml  
  Avalonia Window             avalonia.window      [C#] ui/xaml  
  ```

  This enables us to use these templates, 
  e.g. as `dotnet new avalonia.app -o Projektname`. 

- Installation for `eclipse` for java and for `csharp`. 
  First go to https://www.eclipse.org/downloads/ and download eclipse IDE. 
  In fact this is just the downloader. 
  You must `gunzip` and `untar` and then run the installer which asks you for the
  language to develop for. 
  Choose java. 
  Then start and observe the settings. 
  You easily find out the location of the executable `eclipse`. 
  You can start by `./eclipse`. 
  To install permanently, set the `PATH` environment variable accordingly. 
  
  Within eclipse from menu choose `help-->Eclipse Marketplace` and search for
  `acute` and install it. 
