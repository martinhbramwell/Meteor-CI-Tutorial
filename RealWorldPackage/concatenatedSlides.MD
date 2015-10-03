layout: false
.left-column[
  ### PART H Introduction

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
 ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## A Real World Package

'Part07_ProductionLogging.sh' introduced how to ```require``` a NodeJS module into Meteor.

Meteor is built on NodeJS but there's a fundamental divergence of design philosophy.  NodeJS achieves very efficient processing of requests using "non-blocking", asynchronous callbacks.  Meanwhile, Meteor achieves a very efficient development platform with event-driven synchronous programming, by hiding the complexity of asynchronous coding within synchronous wrappers.

An understanding of synchronous wrappers of NodeJS modules opens the doors to the whole NodeJS ecosystem for use in Meteor development.

Get started now by running ...
```terminal
./Part08_RealWorldPackage.sh
```



<!-- B -->]
---
.left-column[
  ### Another NodeJS Module (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part A)


Edit the file ```'package.js'``` to look like this

```javascript
Package.onUse(function(api) {
        :
  api.addFiles('${PKG_NAME}.js', ['server']);    //  EDIT! <--
        :
});

Package.onTest(function(api) {
        :
  api.addFiles(                                  //  EDIT! <--
    ['logger.js', '${PKG_NAME}.js', '${PKG_NAME}-tests.js'],
    ['server']
  );
        :
});

Npm.depends({
  'bunyan': '1.5.1',
  'swagger-client': '2.1.5',                     //  ADD! <--
});
```
Continues ...


<!-- B -->]
---
.left-column[
  ### Another NodeJS Module (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part B)

... continuing.

Open the empty file ```'${PKG_NAME}.js'``` and paste into it

```javascript
const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';

const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 7}, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
```
<a href='http://petstore.swagger.io/#!/pet/getPetById' target='_blank'>Swagger</a> give you instant connectivity to remote REST APIs, based solely on a machine readable specification: ```'swagger.json'```. Have a look at the logs, now.

Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Examining the code ```'${PKG_NAME}.js'``` we see :
```javascript
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 8},
      {responseContentType: 'application/json'},
      function log(pet) {
        Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);
      }
    );
  },
});
```
The parameter ```'pet'``` passed by ```getPetById``` to the ```log``` callback function is completely inaccesible.  It is buried inside two asynchronous calls.

_How do we get it?__


Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part B)

... continuing.

We need two wrapper functions that wait for the asynchronous calls to return their values.

Replace ```new Client()``` block with :
```javascript
const getSwaggerProxy = Meteor.wrapAsync(
  function wrpr(swaggerSpec, callback) {
    var prxySwagger = new Client({
      url: swaggerSpec,
      success: function suxs() { callback(null, prxySwagger); },
      error: function errs() { callback(null, prxySwagger); },
    });
  }
);
PetStore = getSwaggerProxy(swaggerSpecURL);
```
PetStore is now a proxy for the remote server.

Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (C)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part C)

... continuing.

PetStore needs to be known to the rest of the application, so we declare it in ```package.js```.

So this line ...
```javascript
  api.export('Logger');
```

... becomes ...
```javascript
  api.export(['Logger', 'PetStore']);
```
Note that their names are in an array.


<!-- B -->]
---
.left-column[
    ### End Of Part #F
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Fin

Thank you!



<!-- B -->]
