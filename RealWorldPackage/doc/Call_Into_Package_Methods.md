---
.left-column[
  ### Calling Package Methods
  <br />
  <br />
  <div class="manual_input_reqd">
  <img src="./fragments/typer.gif" />
  Manual input required here.
  </div>
  <br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Gaining Access to Package Functionality

Unit tests confirm our package works, but how do we actually use it from an application?

In the main directory, ```${PKG_NAME}```, of our package we'll create  a template file, 
<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html' target='_blank'>usage_example.html</a>, and a template helper file, <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js' target='_blank'>'usage_example.js'</a>.

We must register them in our ```package.js``` file.
```javascript
         :
api.addFiles(['logger.js', 'ourpackage.js'], ['server']);
api.addFiles(['usage_example.html', 'usage_example.js' ], ['client']); // ADD <--
```
##### Commands
```terminal
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js
```

Continues ...


<!-- Code for this begins at line #60 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part08_RealWorldPackage.sh#L60" target="_blank">Code for this step.</a>] ]
]
