---
last_update: 2016-02-09
 .left-column[
  ### The Async Problem (E)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Unit Testing the Synchronous Method

... continuing.

Let's unit test our ```PetStore``` proxy by appending this to ```${PKG_NAME}-tests.js```
```javascript
/∗∗
 ∗ Can we retrieve a pet by its ID number?
 ∗ @name obtainPetById
 ∗ @memberof Tinytest
 ∗ @function
 ∗ @param  test {Tinytest} Pet #petNum is : expected
 ∗ @return {None}
 ∗/
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
