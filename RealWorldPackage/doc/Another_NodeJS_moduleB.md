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
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 6133627028}, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
```
Have a look at the log file! <a href='http://petstore.swagger.io/#!/pet/getPetById' target='_blank'>Swagger</a> gives instant connectivity to remote REST APIs, based solely on a machine readable specification: ```'swagger.json'```.

Continues ...


<!-- Code for this begins at line #26 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part08_RealWorldPackage.sh#L26" target="_blank">Code for this step.</a>] ]
]
