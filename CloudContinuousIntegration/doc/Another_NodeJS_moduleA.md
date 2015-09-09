---
.left-column[
  ### Another NodeJS Module (A)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Let's Add a More Interesting Module (Part A)


Edit the file ```'package.js'``` to look like this

```javascript
Package.onUse(function(api) {
  api.versionsFrom('1.1.0.3');
  api.addFiles('yourpackage.js', ['server']);    //  EDIT! <--
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('yourself:yourpackage');
  api.addFiles(                               //  EDIT! <--
    ["logger.js", 'yourpackage.js', 'yourpackage-tests.js'],
    ['server']
  );
  api.export("Logger"); // Order matters.  Export **after** adding
});});

Npm.depends({
  "bunyan": "1.4.0",
  "swagger-client": "2.1.1",
});
```
Continues ...


<!-- B -->]
