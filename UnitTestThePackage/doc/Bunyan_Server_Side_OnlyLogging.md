---
.left-column[
  ### Server Only
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Bunyan is for Server Side Logging Only

You will have noticed in the browser that the client tests have disappeared.  The browser console shows 'Npm' is not defined.  NodeJS modules need extra packaging to run on the client.  We don't need that here.

We'll be testing server side only.  Let's make it explicit.

Edit the ```api.addFiles``` line in ```'package.js'```to look like this :

```javascript
Package.onTest(function(api) {
  api.use('tinytest');
  api.use('yours:skeleton');
  api.addFiles(['skeleton-tests.js'], ['server']);  //  EDIT! <--
});

Npm.depends({
  "bunyan": "1.4.0",
});
```

   ... save, and observe the command line logs and the browser console.

<!-- B -->]
