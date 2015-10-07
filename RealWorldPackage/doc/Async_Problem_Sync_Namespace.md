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
