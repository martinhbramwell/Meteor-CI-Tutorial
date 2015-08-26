---
.left-column[
  ### Another NodeJS Module (B)
.footnote[.red.bold[] [Back to TOC](..)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part B)

... continuing.

Open the empty file ```'skeleton.js'``` and paste into it

```javascript
const Client = Npm.require("swagger-client");
const swaggerSpecURL = "http://petstore.swagger.io/v2/swagger.json";

const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 7}, {responseContentType: "application/json"},
      function log(pet) { Logger.info("Pet #" + pet.obj.id, " -- " + pet.obj.name);  }
    );
  },
});
```
[Swagger](http://petstore.swagger.io/#!/pet/getPetById) give you instant connectivity to remote REST APIs, based solely on a machine readable specification: ```'swagger.json'```. Have a look at the logs, now.

Continues ...


<!-- -->]
