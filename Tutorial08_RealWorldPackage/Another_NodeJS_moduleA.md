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
