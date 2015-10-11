---
.left-column[
  ### Another NodeJS Module (A)
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

#### Let's Add a More Interesting Module (Part A)


Edit the file ```'package.js'```, adding a reference to ```swagger-client``` : 

```javascript
Npm.depends({
  'bunyan': '1.5.1',
  'swagger-client': '2.1.5',                     //  ADD! <--
});
```

<a href='http://petstore.swagger.io/#!/pet/getPetById' target='_blank'>Swagger Client</a> gives instant connectivity to remote REST APIs, based solely on  <a href='http://petstore.swagger.io/v2/swagger.json' target='_blank'>a machine readable API specification :  ```'swagger.json'```</a>

Continues ...


<!-- B -->]
