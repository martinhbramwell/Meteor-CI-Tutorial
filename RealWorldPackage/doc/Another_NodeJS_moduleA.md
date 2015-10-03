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
        :
  api.addFiles('${PKG_NAME}.js', ['server']);    //  EDIT! <--
        :
});

Package.onTest(function(api) {
        :
  api.addFiles(                                  //  EDIT! <--
    ['logger.js', '${PKG_NAME}.js', '${PKG_NAME}-tests.js'],
    ['server']
  );
        :
});

Npm.depends({
  'bunyan': '1.5.2',
  'swagger-client': '2.1.5',                     //  ADD! <--
});
```
Continues ...


<!-- B -->]
