---
.left-column[
  ### Refactor Bunyan (B)
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Refactor Bunyan Instantiation (Part B)

... continuing.

In ```package.js``` change this ...
```javascript
api.use('yours:skeleton');
api.addFiles(['skeleton-tests.js'], ['server']);
```
... to look like this ...
```javascript
api.use('yours:skeleton');
api.export("Logger");           //  ADD! <--
api.addFiles(                   //  EDIT! <--
  ["logger.js", 'skeleton-tests.js'],
  ['server']
);   //  EDIT! <--
```
In a new terminal window run
```terminal
tail -f /var/log/meteor/ci4meteor.log  | bunyan
```

<!-- -->]
