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
