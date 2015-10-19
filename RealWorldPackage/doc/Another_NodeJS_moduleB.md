---
.left-column[
  ### Another NodeJS Module (B)
  
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part B)

... continuing.

<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js' target='_blank'>Download</a> **or** paste into the empty file, ```'${PKG_NAME}.js'```, the following code :

```javascript
const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
const swagger = new Client({
  url: swaggerSpecURL,
    swagger.pet.getPetById(
      { petId: 6133627028 }, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
```
Run ```tail -f /var/log/meteor/ci4meteor.log | bunyan```, to inspect the log file!

Continues ...


<!-- Code for this begins at line #29 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part08_RealWorldPackage.sh#L29" target="_blank">Code for this step.</a>] ]
]
