---
last_update: 2016-01-02
 .left-column[
  ### Another NodeJS Module (C)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part C)

... continuing.

<a href='https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/yourpackage.js' target='_blank'>Obtain a new</a> ```'${PKG_NAME}.js'``` file, that's improved like this :

```javascript
const Client = Npm.require('swagger-client');
const TestPet = 6133627027;
const swagger = new Client({
  url: 'http://petstore.swagger.io/v2/swagger.json',
  success: function getPet() {
    for (idx = TestPet; idx < TestPet + 4; idx++) {
      swagger.pet.getPetById(
        { petId: idx}, {responseContentType: 'application/json'},
        function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
        :
```
After Meteor starts up, inspect the log file with :

```
tail -f /var/log/meteor/ci4meteor.log | bunyan -o short
```

Continues ...


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial08_RealWorldPackage/RealWorldPackage_functions.sh#L17" target="_blank">Code for this step.</a>] ]
]
