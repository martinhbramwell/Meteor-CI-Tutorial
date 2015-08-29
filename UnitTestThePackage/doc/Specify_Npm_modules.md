---
.left-column[
  ### Specify Npm modules
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### We have to specify every Npm requirement explicitly.

The Npm package preloads NodeJS modules specified in a package.js file. 

Add this block ...

```
Npm.depends({
  "bunyan": "1.4.0",
});
```

at the bottom of the file ```'package.js'```

```javascript
Package.onTest(function(api) {
  api.use('tinytest');
  api.use('yours:skeleton');
  api.addFiles('skeleton-tests.js');
});

Npm.depends({                 //  ADD! <--
  "bunyan": "1.4.0",
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->]
