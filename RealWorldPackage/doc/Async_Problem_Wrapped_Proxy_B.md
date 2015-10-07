---
.left-column[
  ### The Async Problem (C)
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Make the Proxy Available to Meteor

... continuing.

The rest of our application needs to know about ```PetStore```, so we declare it in ```package.js```.

So this line ...
```javascript
  api.export('Logger');
```

... must become ...
```javascript
  api.export(['Logger', 'PetStore']);
```
**Note that their names are in an array.**

Continues ...


<!-- B -->]
