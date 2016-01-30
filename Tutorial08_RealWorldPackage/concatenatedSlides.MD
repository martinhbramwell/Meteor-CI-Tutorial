layout: false
last_update: 2016-01-02
 .left-column[
  ### PART H Introduction

.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

## A Real World Package

'Tutorial07_ProductionLogging.sh' introduced how to ```require``` a NodeJS module into Meteor but it was a simple case.

Although Meteor is built on NodeJS, there's a fundamental divergence of design philosophy.  NodeJS achieves very efficient processing of requests using "non-blocking", **asynchronous** callbacks.  Meanwhile, Meteor achieves a very efficient development platform with event-driven **synchronous** programming, by hiding the complexity of asynchronous coding within synchronous wrappers.

An understanding of synchronous wrappers of NodeJS modules opens the doors to the whole NodeJS ecosystem for use in Meteor development.

Get started now by running ...
```terminal
./Tutorial08_RealWorldPackage.sh
```



<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Another NodeJS Module (A)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part A)


Edit the file ```'package.js'```, adding a reference to ```swagger-client``` : 

```javascript
Npm.depends({
  'bunyan': '1.5.1',
  'swagger-client': '2.1.5',                     //  ADD! <--
});
```

<a href='http://petstore.swagger.io/#!/pet/getPetById' target='_blank'>Swagger Client</a> gives instant connectivity to remote REST APIs, based solely on  <a href='http://petstore.swagger.io/v2/swagger.json' target='_blank'>a machine readable API specification :  ```'swagger.json'```</a>.

We are going to develop and test a Swagger client package.

The first task is to prepare for testing.  End-to-end (a.k.a Functional, Acceptance) testing requires consistent test data, even when the tested functionality involves connection to third party systems.  

Continues ...


<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Another NodeJS Module (B)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part B)

... continuing.

Ideally, we should test against our own Swagger compliant REST API, but for simplicity sake we'll exploit Swagger's free on-line test/demo service.

Swagger wipes all anonymous user data on their public server every 24 hours.  To ensure consistent results we use a script <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/tree/master/fragments/reloadSwaggerPetStore.sh" target="_blank">reloadSwaggerPetStore.sh</a> to write a few records to an out of the way location.  This will meet our continuous integration needs, so long as the service has tolerable uptime.

##### Example Commands
```terminal
wget https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/reloadSwaggerPetStore.sh
chmod a+x reloadSwaggerPetStore.sh
```
Continues ...


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial08_RealWorldPackage/RealWorldPackage_functions.sh#L2" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Another NodeJS Module (C)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part C)

... continuing.

<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js' target='_blank'>Obtain a new</a> ```'${PKG_NAME}.js'``` file, that's improved like this :

```javascript
const Client = Npm.require('swagger-client');
const TestPet = 6133627027;
const swagger = new Client({
  url: 'http://petstore.swagger.io/v2/swagger.json',
  success: function getPet() {
    for (idx = TestPet; idx < TestPet + 4; idx++) {
      swagger.pet.getPetById(
        { petId: idx}, {responseContentType: 'application/json'},
        function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
        :
```
After Meteor starts up, inspect the log file with :

```
tail -f /var/log/meteor/ci4meteor.log | bunyan -o short
```

Continues ...


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial08_RealWorldPackage/RealWorldPackage_functions.sh#L17" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### The Async Problem (A)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Examining the code of ```'${PKG_NAME}.js'``` we see :
```javascript
for (idx = TestPet; idx < TestPet + 4; idx++) {
  swagger.pet.getPetById(
    { petId: idx}, {responseContentType: 'application/json'},
    function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
  );
}
```
The parameter ```'pet'``` passed by ```getPetById``` to the ```log``` callback function is completely inaccessible.  It's buried two levels deep inside nested, asynchronous callback functions.

*How are we supposed to get at it?*


Continues ...


<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### The Async Problem (B)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Synchronous Wrapper for Asynchronous Service

... continuing.

We need two <a href='http://docs.meteor.com/#/full/meteor_wrapasync' target='_blank'>wrapper functions</a> that wait until the contained asynch functions return their values.

To fix the first of the two, replace ```new Client()``` with :
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
```PetStore``` is now a proxy for the remote server.

Continues ...


<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Export to Meteor
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
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
---
last_update: 2016-01-02
 .left-column[
  ### The Async Problem (D)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Namespace for Sync Versions of Async Methods

... continuing.

So far, we have made access to PetStore synchronous, however, its methods are still asynchronous.  To get at each one of them, we need to add this code to ```${PKG_NAME}.js```
```javascript
PetStore.sync = {};
PetStore.sync.getPetById = Meteor.wrapAsync(
  function wrpr(args, headers, callback) {
    PetStore.pet.getPetById( args, headers
    , function suxs( theResult ) {  callback(null, theResult);  }
    , function errs( theError ) {
      Logger.error('For Id #' + args.petId + ' : ' + theError.statusText);
      callback(null, theError);
    });
  });
```
It inserts a ```sync``` namespace to PetStore, to which we can add sync versions of the async functions as we need them.

Continues ...
<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### The Async Problem (E)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
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
const expected = 'Your fluffy little wolverine.';
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
last_update: 2016-01-02
 .left-column[
  ### Calling Package Methods
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial08_RealWorldPackage/RealWorldPackage_functions.sh#L61" target="_blank">Code for this step.</a>] ]
]
---
last_update: 2016-01-02
 .left-column[
  ### Make Package Method Callable
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Package Dependencies

... continuing.

The new files ```usage_example.html``` and ```usage_example.js``` :
 - must implement client-side functionality and they
 - must do it from within a template

Simply specifying ```['client']``` in ```api.addFiles()``` answers the first issue, but two errors arise from the second one.

We need to declare a dependency on ```templating``` to solve the error, "No plugin known to handle file 'usage_example.html'" and we need to declare a dependency on the package, ```session``` to solve the client-side 'ReferenceError' seen on Session, Template and Meteor.  Update the ```Package.onUse()``` section with :
```javascript
Package.onUse(function onUse(api) {
  api.use(['ecmascript', 'templating', 'session']);
```



Continues ...


<!-- B -->]
---
last_update: 2016-01-02
 .left-column[
  ### Make Package Method Callable
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
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
last_update: 2016-01-18
 .left-column[
  ### Control Example Visibility
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
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
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial08_RealWorldPackage/RealWorldPackage_functions.sh#L99" target="_blank">Code for this step.</a>] ]

<div id="usage" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('usage'); return true;"
       href="javascript:HideContent('usage')"><h2>Pet Store Package : Usage Example</h2>
  <button id="nextPet">See Next Pet</button>
  <p id="petNote">Pet #6133627029 is "At last, a 'stay small' family crocodile.".</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('usage'); return true;"
    href="javascript:ReverseContentDisplay('usage')">
    <i>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Hover Note</i>
</a>

]
---
last_update: 2016-01-07
 .left-column[
    ### End Of Part #H
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Go to the next section . . . 

Now we'll finalize all the previous work by bringing the online documentation up-to-date and providing end-to-end testing of our package, such that interested users can get quickly started using it.   [Part #I - Package Self Test](./?part=I)



<!-- B -->]
