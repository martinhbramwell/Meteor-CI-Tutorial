---
.left-column[
  ### NPM module
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add an NPM module to your package.

Meteor supports 'npm' modules with the package NPM. 

Edit ```'${PKG_NAME}-tests.js'``` again adding :

```const Bunyan = require('bunyan');```

```javascript
/**
 * Tinytest unit tests
 * @namespace Tinytest
 */
const Bunyan = require('bunyan');  //  ADD! <--
```

... save, start up Meteor and observe the command line logs and the browser console. The NodeJS command on its own, **will not work**. We need the Npm package, so instead try this :

```const Bunyan = Npm.require('bunyan');```



<!-- B -->]
