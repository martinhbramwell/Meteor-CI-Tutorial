---
.left-column[
  ### Another NodeJS Module (B)
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

#### Let's Add a More Interesting Module (Part B)

... continuing.

<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js' target='_blank'>Download</a> **or** paste into the empty file, ```'${PKG_NAME}.js'```, the following code :

```javascript
const Client = Npm.require('swagger-client');
const swagger = new Client({
  url: 'http://petstore.swagger.io/v2/swagger.json',
  success: function getPet() {
    for (idx = 1; idx <= 10; idx++) { 
      swagger.pet.getPetById(
        { petId: idx}, {responseContentType: 'application/json'},
        function log(pet) { Logger.info('Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
      );
    }
  },
});
```
Run ```tail -f /var/log/meteor/ci4meteor.log | bunyan```, to inspect the log file!

Continues ...


<!-- Code for this begins at line #26 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part08_RealWorldPackage.sh#L26" target="_blank">Code for this step.</a>] ]
]
