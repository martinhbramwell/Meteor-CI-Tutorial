---
.left-column[
  ### The Async Problem (B)
  <br />
  <br />
  <div class="manual_input_reqd">
  <img src="./fragments/typer.gif" />
  Manual input required here.
  </div>
  <br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Synchronous Wrapper for Asynchronous Service

... continuing.

We need two <a href='http://docs.meteor.com/#/full/meteor_wrapasync' target='_blank'>wrapper functions</a> that wait for the asynchronous calls to return their values.

For the first of the two, replace ```new Client()``` with :
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
