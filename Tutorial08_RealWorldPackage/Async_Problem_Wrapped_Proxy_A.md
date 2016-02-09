---
last_update: 2016-02-09
 .left-column[
  ### The Async Problem (B)
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
