---
last_update: 2016-02-05
 .left-column[
  ### Calling Package Methods
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Gaining Access to Package Functionality

Unit tests confirm our package works, but how do we actually use it from an application?

In the main directory, ```${PKG_NAME}```, of our package we'll create  a template file, 
<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html' target='_blank'>usage_example.html</a>, and a template helper file, <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js' target='_blank'>'usage_example.js'</a>.

We must register them in the ```onUse``` of our ```package.js``` file.
```javascript
         :
  api.addFiles(['logger.js', '${PKG_NAME}.js'], ['server']);
  api.addFiles(['usage_example.html', 'usage_example.js' ], ['client']); // ADD <--
```
##### Example Commands
```terminal
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js
```

Start ```meteor``` now (not ```meteor test-packages```).  Continues ...


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial08_RealWorldPackage/RealWorldPackage_functions.sh#L65" target="_blank">Code for this step.</a>] ]
]
