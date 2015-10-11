---
.left-column[
  ### Export to Meteor
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

#### Make the Proxy Available to Meteor

... continuing.

The rest of our application needs to know about ```PetStore```, so we need to alter ```package.js```.

The 'api.export()' methods in both sections, (```onUse``` & ```onTest```), will need to look like this :
```javascript
  api.export(['Logger', 'PetStore']);  //  Note : the names are in an array.
```
Also, in the ```onTest``` section, be sure to 'add' the following files :
```javascript
  api.addFiles(['logger.js', 'ourpackage.js', 'ourpackage-tests.js'], ['server']);
```


Continues ...


<!-- B -->]
