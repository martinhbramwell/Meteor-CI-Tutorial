layout: false
.left-column[
  ### PART H Introduction

.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## A Real World Package

'Part07_ProductionLogging.sh' introduced how to ```require``` a NodeJS module into Meteor but it was a simple case.

Although Meteor is built on NodeJS, there's a fundamental divergence of design philosophy.  NodeJS achieves very efficient processing of requests using "non-blocking", **asynchronous** callbacks.  Meanwhile, Meteor achieves a very efficient development platform with event-driven **synchronous** programming, by hiding the complexity of asynchronous coding within synchronous wrappers.

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
      { petId: 6133627028}, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
```
The parameter ```'pet'``` passed by ```getPetById``` to the ```log``` callback function is completely inaccesible.  It's buried two levels deep inside nested, asynchronous callback functions.

*How are we supposed to get at it?*


Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (B)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Synchronous Wrapper for Asynchronous Service

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

#### Make the Proxy Available to Meteor

... continuing.

The rest of our application needs to know about ```PetStore```, so we declare it in ```package.js```.

So this line ...
```javascript
  api.export('Logger');
```

... must become ...
```javascript
  api.export(['Logger', 'PetStore']);
```
**Note that their names are in an array.**

Continues ...


<!-- B -->]
---
.left-column[
  ### The Async Problem (D)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Namespace for Sync Versions of Async Methods

... continuing.

So far, we have made access to PetStore synchronous, but still, its methods are async.  To get at them, we add this code to ```${PKG_NAME}.js```
```ruby
PetStore.sync = {};
PetStore.sync.getPetById = Meteor.wrapAsync(
  function wrpr(args, headers, callback) {
    PetStore.pet.getPetById( args, headers
    , function suxs( theResult ) {  callback(null, theResult);  }
    , function errs( theError ) {
      Logger.info('For Id #' + args.petId + ' : ' + theError.statusText);
      callback(null, theError);
    });
  });
```
It inserts a ```sync``` namespace to PetStore, to which we can add sync versions of the async functions as we need them.

Continues ...
<!-- B -->]
---
.left-column[
  ### The Async Problem (E)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Unit Testing the Synchronous Method

... continuing.

Let's unit test our ```PetStore``` proxy by appending this to ```${PKG_NAME}-tests.js```
```javascript
/**
 * Can we retrieve a pet by its ID number?
 * @name obtainPetById
 * @memberof Tinytest
 * @function
 * @param  test {Tinytest} Pet #petNum is : expected
 * @return {None}
 */
const petNum = 6133627028;
const expected = 'Your fluffy little wolverine';
Tinytest.add('Pet #' + petNum + ' is : ' + expected, function obtainPetById(test) {
  var aPet = PetStore.sync.getPetById(
    { petId: petNum}, {responseContentType: 'application/json'}
  );
  test.equal(aPet.obj.name, expected);
});
```

Continues ...
<!-- B -->]
---
.left-column[
  ### Calling Package Methods
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Gaining Access to Package Functionality

Unit tests confirm our package works, but how do we actually use it from an application?

In the main directory, ```${PKG_NAME}```, of our package we'll create  a template file, 
<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html' target='_blank'>usage_example.html</a>, and a template helper file, <a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js' target='_blank'>'usage_example.js'</a>.

We must register them in our ```package.js``` file.
```ruby
         :
api.addFiles('ourpackage.js', ['server']);
api.addFiles(['usage_example.html', 'usage_example.js' ], ['client']); // ADD <--
```
##### Commands
```terminal
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.html
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/usage_example.js
```

Continues ...


<!-- Code for this begins at line #59 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part08_RealWorldPackage.sh#L59" target="_blank">Code for this step.</a>] ]
]
---
.left-column[
  ### Make Package Method Callable
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Opening Access to Package Functionality

... continuing.

The template helper, ```usage_example.js```, contains the instruction ```Meteor.call('getPetById', Sessio... etc.```

It doesn't work, because we need to properly expose ```getPetById``` as a method of our package.  Append the following to the bottom of ```${PKG_NAME}.js``` :
```javascript
Meteor.methods({
  getPetById: function getPetById(petNum) {
    var aPetVO = PetStore.sync.getPetById(
      { petId: petNum},
      {responseContentType: 'application/json'}
    );
    return aPetVO.status === 404
    ? {name: JSON.parse(aPetVO.data).message}
    : aPetVO.obj;
  },
});
```



Continues ...


<!-- B -->]
---
.left-column[
  ### Control Example Visibility
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Usage Example Should be Disabled by Default

... continuing.

If now, you start up Meteor again, and open the main page (localhost:3000) in a browser, there should be a new section with a button to click through a couple of imaginary pets.  See the *Hover Note* below.

Of course, left like that, our package will impose itself on the main page of  every Meteor application to which it's added.  Fortunately, it is easy to disable -- just comment out the declaration in ```package.js``` :
```javascript
       :
  // api.addFiles(['usage_example.html', 'usage_example.js' ], ['client']);
});
```

Continues ...

<!-- B -->
<div id="usage" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('usage'); return true;"
       href="javascript:HideContent('usage')"><h1>Pet Store Package : Usage Example</h1>
  <button id="nextPet">See Next Pet</button>
  <p id="petNote">Pet #6133627029 is "At last, a 'stay small' family crocodile.".</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('usage'); return true;"
    href="javascript:ReverseContentDisplay('usage')">
    <i>Hover Note</i>
</a>
]
---
.left-column[
    ### End Of Part #H
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

Now we'll finalize all the previous work by bringing the online documentation up-to-date and providing end-to-end testing of our package, such that interested users can get quickly started using it.   [Part #I - Package Self Test](./?part=H)




<!-- B -->]
