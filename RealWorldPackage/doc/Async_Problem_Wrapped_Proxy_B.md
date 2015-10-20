---
.left-column[
  ### Export to Meteor
  <br /><br /><div class="input_type_indicator"><img src="./fragments/typer.gif" /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Make the Proxy Available to Meteor

... continuing.

The rest of our application needs to know about ```PetStore```, so we need to alter ```package.js```.

The 'api.export()' methods in both sections, (```onUse``` & ```onTest```), will need to look like this :
```javascript
  api.export(['Logger', 'PetStore']);  //  Note : the names are in an array.
```
Also, in the ```onTest``` section, be sure to 'add' the following files :
```javascript
  api.addFiles(['logger.js', '${PKG_NAME}.js', '${PKG_NAME}-tests.js'], ['server']);
```


Continues ...


<!-- B -->]
