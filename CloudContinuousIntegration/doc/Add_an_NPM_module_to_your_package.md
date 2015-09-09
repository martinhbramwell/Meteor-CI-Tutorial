---
.left-column[
  ### NPM module
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add an NPM module to your package.

Meteor supports 'npm' modules with the package NPM. 

Edit ```'yourpackage-tests.js'``` again adding :

```const Bunyan = require('bunyan');```

```javascript
const Bunyan = require('bunyan');  //  ADD! <--
// Write your tests here!
// Here is an example.
Tinytest.add("example", function sanity(test) {
    console.log("ººº Yoo Hoo ººº");
    test.equal(true, true);
});
```

... save, and observe the command line logs and the browser console. The NodeJS command on its own, **will not work**.  We need the Npm package, so instead try this :

```const Bunyan = Npm.require('bunyan');```



<!-- B -->]
