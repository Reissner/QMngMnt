<!-- markdownlint-disable no-trailing-spaces -->
<!-- markdownlint-disable no-inline-html -->
# Quality Management for simuline (www.simuline.eu)

This project describes the quality management for simuline organization
and applies to all its projects. 

Among the [General Thoughts](#ssGen) is the strong emphasis on uniformity, reproducibility and automation. 
This applies in particular to [hardware and installation procedures](#ssHwInst), 
but also to [tooling and their configuration](#ssTools). 


The core mission of the simuline organization, 
is to provide computational software and the core technology is `java` 
which makes the application widely platform independent. 
Further, we first want to restrict ourselves to deliver software as a service (SAAS). 
Since computational software is particularly useful 
if integrated into programming languages, 
we deal also with the `matlab` language, i.e. with the `matlab` language interpreters 
`matlab` and its free clone `octave`, 
but also with `python`. 
To the minimal language set introduced above, 
in addition only Perl is needed which comes into the game indirectly because some tools rely on it. 

The build process is done with `maven` and maven also coins in many respects
our notion of quality.
As `maven` provides deployment of software 'build' but also 'site'
comprising documentation,
also quality management is centered
around [Software Deployment](#ssSoftwareDep) and
[Site Deployment](#ssSiteDep). 
One of these general thoughts are uniformity of the set of tools. 

The site of course comprises documentation which is devoted a separate [section](#ssDocumentation). 
As simuline organization relies on internal knowledge, 
[safety](ssSafety) is a subject we have to think carefully about. 

For sake of completeness,
subjects not fitting into that scheme are collected
under a common [roof](#ssMisc).
Aspects to be added are collected in [TBD](#ssTBD). 

## General Thoughts <a id='ssGen'></a>

At the time of this writing,
software was not maintained for a long span of time
and so also quality management did not keep pace with advances in that field.
In particular, new compiler and quality management tools became stricter.
So we must distinguish between what is desirable in future
and what is mandatory now.

The core development is in java solely.
This uniformity is important because of the tense resources of the company. 
In general, it is a principle to keep the tool set small, i.e. uniform. 
Also, tools used must be kept in a small range and tools must be open source and free. 

Besides, hardware and installation must be uniform. 
What applies to hardware and installation also applies to configuration. 
Beyond this, mainstream is preferred to special configuration. 
Thus, we use en_US locale internally; 
only for customer communication we may switch to another language if the customer desires to do so. 

Documentation is done with latex and with Markdown only 
and also the form of [documentation]() is quite restricted. 

Related with estimation of uniformity is the focus on automation. 
In particular, for installation we rely on scripts rather than on manual procedures. 
Also in quality management, the first step is running a linting tool, 
prior to manual review. 

This helps to keep up reproducibility. 


## Hardware and Installation <a id='ssHwInst'></a>

This section is on installation of computers. 
Currently, only general purpose computers are in use, to be more precise, laptops. 
These can be easily carried and can currently also be used for development. 
In a next step we plan to deliver our software as a service (SAAS) to avoid having to check on various platforms 
and to tackle questions on license management and reverse engineering. 


All computers are installed with openSUSE Tumbleweed. 
General information on installation can be fond in an according 
[Readme.md](./src/main/resources/eu/simuline/qMngmnt/installation/Readme.md). 
On the [project site](http://www.simuline.eu/QualityManagement/general.html) 
there is a link to a file `xxx.tgz` which can be unpacked with `tar -xvf xxx.tgz` 
which provides all what is needed to perform all parts of an installation. 
In particular, it contains the abovementioned `Readme.md`. 
As described therein, the first part with basic and uniform installation is manual, 
but for the second, specific part, 
[one can use scripts](./src/main/resources/eu/simuline/qMngmnt/installation/Readme.md#sssInstScript) 
to complete installation. 
These scripts are also contained in the `xxx.tgz` file. 


## Tools <a id='ssTools'></a>

This section describes the set of tools under use. 

Sources are under version control, of course software,
but also documentation.
Thus, internally we only use open, textual formats, like Markdown or LaTeX.

In future `git` shall be the only version management tool.
At the moment, there is still subversion in use,
but this shall be eliminated in the next releases. 
For details on git and how to use there is a separate [section](#sssVCSgit).

As regards editors or IDE's VS Code made the run. 
Still `emacs` is kept as a fallback tool. 
Also, `eclipse` has been evaluated, 
but it has the drawback that it is a pure java IDE,  
while we target uniform tooling. 
Moreover, `eclipse` turned out to consume a lot of resources and lacks stability. 
Still, for java development code from `eclipse` is under the hood, 
because the extension for VS Code we use, has common code base with `eclipse`. 

VS Code is a uniform editor adapting to each format under use by means of an according extension. 
There are extensions for all text formats we use: latex, Markdown, java, MATLAB, python, Perl, ... 
Many of the extensions, like `ltex` contribute to quality assurance. 
Uniformity of tools and processes itself helps keeping up quality. 

Detail information on VS Code and how to use can be found in a separate [section](#sssVSCode). 


The core tool besides VS Code and some java development extensions is `maven`
which supports the deployment process of both software and documentation.

It also supports quality management, mostly through its plugins,
sometimes in a subtle way,
like the `compiler` plugin emitting warnings.

The most basic is that in the `pom.xml`, all warnings
emitted by `mvn clean`,
`mvn deploy` and by `mvn site-deploy` must be eliminated
at least before next release.
This applies for the future, but not for the next release.
In particular, the source encoding must be set explicitly.
UTF-8 is mandatory, so there is an according entry in the properties section.
Another principal which overlaps with the latter one is,
to make the build reproducible.
Thus, one has to specify the version of maven itself and of each plugin used.
Use the enforcer plugin.
This implies that the properties-section is as follows (maven version at time of this writing): 

```xml
<project ...>
  <properties>
    <!-- checked during validation -->
    <versionMvn>3.6.3</versionMvn>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
</project>
```

For use of `release-plugin` (see below), 
the `scm` element with sub-elements in particular `developerConnection` 
shall be present. 

In the `build` element, the extensions `wagon-ftp`, `wagon-file` and `wagon-http` 
shall be present. 
In the `plugins` sub-element of the `build` element, 
the following plugins must be specified: 

- The `maven-enforcer-plugin` must be used 
  to determine the maven version and the java version at least. 
- The `maven-help-plugin` must be there to get info on the project or system. 
- The `maven-clean-plugin` is to clean a build. 
- The `maven-release-plugin` must be used to update releases. 
  Deployment of releases must be preceded by target `clean`,
  so use `mvn clean deploy` and `mvn clean site-deploy`.

  The target `clean` shall be configured in a way,
  that it cleans all files not under version control but not ignored.
  On the other hand, it shall not remove files under version control.
  All this must be checked with a command like `git status` in the root directory. 

The `reporting` element with its `plugin` sub-element must be present 
which must contain 

- The `maven-project-info-reports-plugin`
- The `versions-maven-plugin` to check for plugin updates. 
- The `maven-changes-plugin` to create a change report 
  from the `changes.xml` file 

To unveil further plugins to be specified, run 

```[sh]
mvn versions:display-plugin-updates
```

All projects shall depend on this quality management project.
They shall use all mechanisms for quality management
provided by this project.
If a new version of this project is released,
the dependent projects shall switch to that version as soon as possible.
It is advisable to use snapshot versions during development
and to develop this project and the dependent one side by side.

Release management must be based on `maven-release-plugin`. 
Please consult the [usage page](https://maven.apache.org/maven-release/maven-release-plugin/usage.html) 
and do a dry-run first. 


### Version Control with Git <a id='sssVCSgit'>

Here, we shall talk about how to use version control in general and `git` in particular. 
Version control is done mainly in `git`, 
but there are still some reminiscences to `svn`,
e.g. in the pom's. 
In the long run, `svn` shall be eliminated for sake of uniformity. 

Note that git cooperates well with maven release plugin. 

In the future, one shall prescribe a branching model for git. 

Also, the config files for git and also the inc-files must be specified. 


### On VS Code <a id='sssVSCode'></a>

This section describes treatment of VS Code. 
Currently, this is only a collection of thoughts and need rework. 

Besides VS Code itself, several extensions need to be installed. 
TBD: Provide further pieces of information on `instVSCode.sh`. 

Among those are `ltex` for linting [documentation](#ssDocumentation). 


One has to decide whether some setting is mandatory, 
like that [for the current project](./.vscode/settings.json). 


## The Software Deployment Process <a id='ssSoftwareDep'></a>

In the future, when compile time warnings occur, these must be eliminated,
at last for the release to come.

For the build, plugins `maven-pmd-plugin`, `maven-checkstyle-plugin` and
`spotbugs-maven-plugin`
shall be configured.
The rulesets are centralized in this project
and given by the following table.
Note that when a new version of this quality management project is released,
other projects 

| plugin                   | ruleset |
| ------------------------- | ------- |
|        `maven-pmd-plugin` | [myPmdRuleset.xml](./src/main/resources/eu/simuline/qMngmnt/pmd/myPmdRuleset.xml) |
| `maven-checkstyle-plugin` | [myChkStyleRuleset.xml](./src/main/resources/eu/simuline/qMngmnt/checkstyle/myChkStyleRuleset.xml) |
|   `spotbugs-maven-plugin` | [spotbugs-include.xml](./src/main/resources/eu/simuline/qMngmnt/spotbugs/spotbugs-include.xml) |

In future for code coverage we shall use `jacoco`.
Evaluate [https://checkerframework.org/](https://checkerframework.org/) also.
For an example see [https://github.com/glts/safer-spring-petclinic/wiki](https://github.com/glts/safer-spring-petclinic/wik). 

For tests, we use `maven-surefire-plugin` and `maven-failsafe-plugin`.

API documentation is mandatory.
To create documentation in `html` we use `maven-javadoc-plugin`.
In future before release, `javadoc` goal shall not fail and there shall be no warnings. 

## The Site Deployment Process <a id='ssSiteDep'></a>

One major part of site deployment is documentation.
We use `docbkx-maven-plugin` and `latex-maven-plugin`.
In the future, we plan a `texinfo` plugin to create `pdf` and `html` from the same sources using `mathjax`.

In the future, there shall be a uniform form for latex-documents
and the according includes defining the style shall be collected in this project.

At the moment, only bibliographies are standardized with the following rules:

- Public references coming from external, i.e. not provided by any own project
  are collected in [`litPublic.bib`](src/main/resources/eu/simuline/qMngmnt/latex/litPublic.bib).
- Publicly accessible `pdf`-documents shall be collected in this project also in the future.
  Note that public references may target documents which are not publicly accessible,
  e.g. paid norms.
  These are stored in non-public project `eu.simuline:ConfDocs`.
- References provided by a project of simuline organization shall be delivered with that project
  in the main jar file and have a name like `litProjName.bib`, where `Name` is the project name.
  That way it is as public/private as the enclosing project.

For documents provided by any project,
the following rules concerning bibliography apply.

- A document shall use references as usual in an academic environment.
- On its title page there must be a hint whether this document is public or private.
  Of course, in a public project there shall be no private documents,
  but the other way round it is possible.
- On the title page also a reference 
  to the project specific bibliography `litProjName.bib` must be given
  indicating how this document can be referred to.
- On the title page there shall be a link on the project site it belongs to.
  In the long run, the site shall offer all its documents for view or download.
  One shall consider also delivering `pdf`'s in jar-files. 
- Any document (we shall call the *referrer*) must refer to other documents 
  (called here *referee*) by either using the
  - internal bibliography `litProjName.bib` of its project `Name`,
  - a project specific bibliography `litProjDep.bib`
    from a project `Dep` the project `Name` depends on (in a maven sense),
  - public bibliography `litPublic.bib` provided by this quality management project
    (in which case `Name` depends on this quality management project)
  - confidential bibliography `litPrivate.bib` provided by the project `eu.simuline:ConfDocs`.
- The project specific bibliography `litProjName.bib` of its project `Name`
  contains references for all documents provided by this project by the above rule.
  It shall provide no more references than those.
  In addition, for each entry in a comment the relative path to the `tex`-source
  of the according reference shall be given.
- The project specific bibliography `litProjName.bib` of its project `Name`
  shall be placed on the root of the `tex`-sources.
  In the same directory there shall be a uniform `readmeBibtex.md` 
  indicating to the user, that before compiling latex one has to `mvn process-sources`
  to populate the enclosing directory with further bib files required
  and that like.

Besides latex also markdown is used. 
Check is performed by `markdownlint`, an extension to `vs code`. 
We deactivate the following rules: 

- `no-trailing-spaces` because single trailing space is good if line break changes, 
  but one would need a way to restrict to 1 or 2 trailing spaces. 
- `no-inline-html` because there is no common uniform way 
  to set an anchor in pure markdown, and so we need to use `html`, 
  namely an a-tag. 
  It would be worth if all **further** inline `html` is avoided, 
  whereas the a-tag shall be allowed. 

## Documentation <a id='ssDocumentation'></a>

Textual documentation is in latex and in Markdown. 
Both formats are written using VS Code with according extensions. 
These comprise `ltex` which can [lint both, latex and Markdown](#sssLintLtex). 
For latex, `latex-maven-plugin` is used to transform into any needed output format. 

Besides textual documentation, there is also code documentation, 
above all for java. 
Also, code is written with VS Code and for java the extension `redhat.java` is used. 
This supports [online linting and formatting](#sssLintFormat). 


### Linting LaTeX and Markdown with `ltex` <a id='sssLintLtex></a>

There is a code checker for latex and for Markdown 
at the same time, `ltex`. 
Its [documentation](https://valentjn.github.io/ltex/settings-de.html)
shows, among other things, how to treat documents with mixed language. 

Essentially, one has to write in general on documentation, 
then elaborate which is specific for the languages under use. 

### Linting and Formatting Java Online <a id='sssLintFormat'></a>

VS Code is used with extension `redhat.java` which includes linting and formatting also. 
The configuration can be done locally, but also via internet. 
We use the latter way to obtain uniformity across the projects 
and to minimize installation overhead. 
We are aware that there are also drawbacks as e.g. a lot of work when changing the ruleset. 
The [ruleset](./src/site/resources/java/eclipse-java-google-style.xml) 
is derived from the according config used by google. 
It is accessible on the site via 
[site](https://www.simuline.eu/QualityManagement/java/eclipse-java-google-style.xml).

The same configurations are also used by maven plugins. 

## Safety <a id='ssSafety'></a>

Have a look at [https://snyk.io/blog/10-maven-security-best-practices/](https://snyk.io/blog/10-maven-security-best-practices/)

Some literature on safety is [here](src/main/resources/eu/simuline/qMngmnt/literature/Safety/).

## Miscellaneous <a id='ssMisc'></a>
<!-- markdownlint-disable no-bare-urls -->
https://www.mojohaus.org/license-maven-plugin/examples/example-download-licenses.html

https://www.simplify4u.org/sign-maven-plugin/

https://github.com/verhas/License3j

https://github.com/yWorks/yGuard obfuscation

https://web.archive.org/web/20161217190546/http://www.excelsior-usa.com/articles/java-obfuscators.html
https://www.guardsquare.com/manual/configuration/examples
<!-- markdownlint-enable no-bare-urls -->

## To Be Done <a id='ssTBD'></a>

In the long run, the directory layout shall be the following tree, optional directories in brackets:

- src
  - [assembly]
  - changes
  - main
  - site
  - test

At the moment not even this project conforms with this.
TBD: add also the files, not directories only.

Besides the directory layout also the pom layout shall follow a scheme. 
The ordering shall be as given by 
[the official documentation for maven](https://maven.apache.org/ref/3.8.5/maven-model/maven.html). 
All top level elements shall be present, either active or commented out. 

For `maven-project-info-reports-plugin` do research on the set of available reports. 
Maybe the pom spec gives the decisive hint. 






