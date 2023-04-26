<!-- markdownlint-disable no-trailing-spaces -->
<!-- markdownlint-disable no-inline-html -->

# Conventions for writing java code 

At the moment, this document is an unstructured collection. 
Let us begin with tooling: It is decided that development is on SUSE Linux 
and that `vscode` is used as sole editor 
in conjunction with several extensions relevant for java. 
The script [instZypper.sh](../installation/instZypper.sh) installs it and keeps it up to date. 
These are installed automatically with the script [instVScode.sh](../installation/instVScode.sh). 
In this script there is a section on java comprising a bunch of extensions. 
Most notably there is `vscjava.vscode-java-pack`, 
but also a plugin to use `checkstyle` and another one for `PMD`. 

All extensions shall be installed and activated in the workspace only. 

## Formatting 

Formatting is offered just with a mouse right click. 
The only things to is selecting the tab quality (tab or space) and the width. 

A word on indentation: 
I could not find a java-specific indentation check, 
but a global one for `vscode`. 
In the status bar on bottom there is a field Tabs or spaces. 
The setting shall be `Spaces 2`. 
To change, just press the field and select `Indent using Spaces` and set number of spaces to `2`. 

It is recommended to define this globally for the project in `.settings/settings.json` 
which can be found in the base directory of the project like so: 

```[json]
// The number of spaces a tab is equal to. This setting is overridden
// based on the file contents when `editor.detectIndentation` is true.
"editor.tabSize": 4,

// Insert spaces when pressing Tab. This setting is overriden
// based on the file contents when `editor.detectIndentation` is true.
"editor.insertSpaces": true,

// When opening a file, `editor.tabSize` and `editor.insertSpaces`
// will be detected based on the file contents. Set to false to keep
// the values you've explicitly set, above.
"editor.detectIndentation": false
```

TBD: consider defining a `settings.json` file globally. 

Naturally, a java file has various sections like 

- inner classes, 
- fields, both static and member, 
- constructors and 
- methods last of which is the `main` method, if present 

For `enum`s the grammar is a bit different. 
TBD: specify more precisely. 
The java grammar allows these elements to come in arbitrary order, 
but by convention we always keep the same order, namely the one given above. 

Each of these sections is started with a separator like the following one: 

```[java]
 /* ----------------------------------------------------------------------- *
  * inner classes. *
  * ----------------------------------------------------------------------- */
```

The length is so that after the last slash column 80 is reached. 
Thus, it depends on the indent. 
These lines can be used to keep overview of the line length 
which is restricted to 80 characters. 

The encoding is always `UTF-8` and the end of line sequence is always `LF` (Unix style). 

## Documentation 

The full `javadoc` documentation is required, even for `private` methods, fields and classes. 

The class documentation shall mention all `public` fields, constructors and methods; 
also inner classes, whether static or not. 
The documentation of a method comprises the textual documentation 
and the documentation of input parameters, return values and exceptions. 

The textual documentation shall mention all input parameters. 
