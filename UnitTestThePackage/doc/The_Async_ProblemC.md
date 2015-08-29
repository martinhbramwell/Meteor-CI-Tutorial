---
.left-column[
  ### The Async Problem (A)
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Meteor is Incompatible With NodeJS  (Part A)

Continuing ...

PetStore needs to be known to the rest of the application, so we declare it in ```package.js```.

So this line ...
```javascript
  api.export("Logger");
```

... becomes ...
```javascript
  api.export(["Logger", "PetStore"]);
```
Note that their names are in an array.

Continues ...


<!-- B -->]
