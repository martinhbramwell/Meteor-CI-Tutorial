---
.left-column[
  ### jsDoc for ST3
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

A partially documented ```${PKG_NAME}-tests.js``` is available at [*martinhbramwell:Meteor-CI-Tutorial* -- ```/fragments/${PKG_NAME}-tests.js```](https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/${PKG_NAME}-tests.js) 

Let DocBlockr help finish the annotations for the ```'Check inequality'``` test, as explained in DocBlockr's [usage instructions](https://github.com/spadgos/sublime-jsdocs#usage).  Type ```/**``` followed by ```<enter>``` and DocBlockr will attempt to create appropriate tags.  You can ```<tab>``` and ```<shift-tab>``` back and forth between incomplete fields.

##### Commands
```terminal
WORKED=${PKG_NAME}-tests.js
GH_RAW=https://raw.githubusercontent.com
PRJ=martinhbramwell/Meteor-CI-Tutorial/master
wget -O ${WORKED} ${GH_RAW}/${PRJ}/fragments/${WORKED}
```

Continues . . .
<!-- Code for this begins at line #485-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L508" target="_blank">Code for this step.</a>] ]
]
