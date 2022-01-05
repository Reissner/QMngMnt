# Quality Management for simuline (www.simuline.eu)

This project describes the quality management for simuline organization
and applies to all its projects.

The core mission is to provide computational software
and the core technology is `java`.
The build process is done with `maven` and maven also coins in many respects
our notion of quality.
As `maven` provides deployment of software 'build' but also 'site'
comprising documentation,
also quality management is centered
around [Software Deployment](#ssSoftwareDep) and
[Site Deployment](#ssSiteDep) and are surrounded
by some [General Thoughts](#ssGen).
For sake of completeness,
subjects not fitting into that scheme are collected
under a common [roof](#ssMisc).
Aspects to be added are collected in [TBD](#ssTBD). 


## General Thoughts <a id='ssGen'/>

At the time of this writing,
software was not maintained for a long span of time
and so also quality management did not keep pace with advances in that field.
In particular, new compiler and quality management tools became sticter.
So we must distinguish between what is desirable in future
and what is mandatory now.

The core development is in java solely.
This uniformity is important because of the tense resources of the company.
Also tools used must kept in a small range and tools must be free.


Sources are under version control, of course software,
but also documentation.
Thus internally we only use open, textual formats, like markdown or latex.

In future `git` shall be the only version managment tool.
At the moment, there is still subversion in use,
but this shall be eliminated in the next release. 

The core tool besides the java development kit is `maven`
which supports the deployment process of both software and documentation.

It also supports quality management, mostly through its plugins,
sometimes in a subtile way,
like the `compiler` plugin emitting warnings.

The most basic is that in the `pom.xml`, all warnings
emitted by `mvn clean`,
`mvn deploy`  and by `mvn site-deploy` must be eliminated
at least before next release.
This applies for the future, but not for the next release.

The target `clean` shall be configured in a way,
that it cleans all files not under version control but not ignored.
On the other hand, it shall not remove files under version control.
All this must be checked with a command like `git status` in the root directory. 

Deployment of releases must be preceeded by target `clean`,
so use `mvn clean deploy` and `mvn cleansite-deploy`.

The `maven-enforcer-plugin` must be used.

All projects shall depend on this quality management project.
They shall use all mechanisms for quality management
provided by this project.
If a new version of this project is released,
the dependent projects shall switch to that version as soon as possible.
It is advisable to use snapshot verions during development
and to develop this project and the dependent one side by side.

Release management must be based on `maven-release-plugin`. 


## The Software Deployment Process <a id='ssSoftwareDep'/>

In future, when compile time warnings occur, these must be eliminated,
at last for the release to come.

For the build, plugins `maven-pmd-plugin`, `maven-checkstyle-plugin` and
`spotbugs-maven-plugin`
shall be configured.
The rulesets are centralized in this project
and given by the following table.
Note that when a new version of this quality management project is released,
other projects 

| plugin                  | ruleset |
| ----------------------- | ------- |
|        maven-pmd-plugin | [myPmdRuleset.xml](./src/main/resources/eu/simuline/qMngmnt/pmd/myPmdRuleset.xml) |
| maven-checkstyle-plugin | [myChkStyleRuleset.xml](./src/main/resources/eu/simuline/qMngmnt/checkstyle/myChkStyleRuleset.xml) |
|   spotbugs-maven-plugin | [spotbugs-include.xml](./src/main/resources/eu/simuline/qMngmnt/spotbugs/spotbugs-include.xml) |

In future for code coverage we shall use `jacoco`.
Evaluate https://checkerframework.org/ also.
For an example see https://github.com/glts/safer-spring-petclinic/wiki. 

For tests we use `maven-surefire-plugin` and `maven-failsafe-plugin`.


Api-documentation is mandatory.
To create html-documentation we use `maven-javadoc-plugin`.
In future before release, javadoc goal shall not fail and there shall be no warnings. 

## The Site Deployment Process<a id='ssSiteDep'/>

One major part of site deployment is documentation.
We use `docbkx-maven-plugin` and `latex-maven-plugin`.
In future we plan a `texinfo` plugin to create pdf and html from the same sources using mathjax.

In future, there shall be a uniform form for latex-documents
and the according includes defining the style shall be collected in this project.

At the moment, only bibliographies are standardized with the following rules:
- Public references coming from external, i.e. not provided by any own project
  are collected in [litPublic.bib](src/main/resources/eu/simuline/qMngmnt/latex/litPublic.bib).
- Publicly accessible pdf-documents shall be collected in this project also in future.
  Note that public references may target documents which are not publicly accessible,
  e.g. payed norms.
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
- On the title page also a reference to the project specific bibliography `litProjName.bib` must be given
  indicating how this document can be referred to.
- On the titlepage there shall be a link on the project site it belongs to.
  In the long run, the site shall offer all its documents for view or download.
  One shall consider also delivering pdf's in jar-files. 
- Any document (we shall call the *referrer*) must refer to other documents (called here *referee*)
  by either using the
  - internal bibliography `litProjName.bib` of its project `Name`,
  - a project specific bibliography `litProjDep.bib`
    from a project `Dep` the project `Name` depends on (in a maven sense),
  - public bibliography `litPublic.bib` provided by this quality management project
    (in which case `Name` depends on this qm project)
  - confidential bibliography `litPrivate.bib` provided by the project `eu.simuline:ConfDocs`.
- The project specific bibliography `litProjName.bib` of its project `Name`
  contains references for all documents provided by this project by the above rule.
  It shall provide no more references than those.
  In addition for each entry in a comment the relative path to the tex-source
  of the according reference shall be given.
- The project specific bibliography `litProjName.bib` of its project `Name`
  shall be placed on the root of the tex-sources.
  In the same directory there shall be a uniform `readmeBibtex.md` 
  indicating to the user, that before compiling latex one has to `mvn process-sources`
  to populate the enclosing directory with further bib files required
  and that like.

## Miscellaneous <a id='ssMisc'/>

## To Be Done <a id='ssTBD'/>

In the long run, the directory layout shall be the following tree, optional directories in brackets:

- src
  - [assembly]
  - changes
  - main
  - site
  - test

At the moment not even this project conforms with this.
TBD: add also the files, not directories only.

Version control is done mainly in `git` but there are still some reminiscenses to `svn`,
e.g. in the pom's.