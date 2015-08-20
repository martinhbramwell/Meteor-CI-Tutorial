---
.left-column[
  ### The Async Problem (A)
]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Examining the code ```'skeleton.js'``` we see :
```javascript
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 8},
      {responseContentType: "application/json"},
      function log(pet) {
        Logger.info("(Async) Pet #" + pet.obj.id, " -- " + pet.obj.name);
      }
    );
  },
});
```
The parameter ```'pet'``` passed by ```getPetById``` to the ```log``` callback function is completely inaccesible.  It is buried inside two asynchronous calls.

_How do we get it?__


Continues ...


<!-- -->]
