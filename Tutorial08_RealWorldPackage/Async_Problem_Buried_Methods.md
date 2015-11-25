---
.left-column[
  ### The Async Problem (A)
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
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
