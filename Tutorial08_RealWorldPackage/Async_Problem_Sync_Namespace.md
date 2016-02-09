---
last_update: 2016-01-02
 .left-column[
  ### The Async Problem (D)
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
