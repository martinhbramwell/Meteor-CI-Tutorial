---
.left-column[
  ### jsDoc for ST3
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

. . . continued.

To have DocBlockr help finish the annotations for the ```'Check inequality'``` type ```/**``` followed by ```<enter>```. It will attempt to create appropriate tags.  You can ```<tab>``` and ```<shift-tab>``` back and forth between incomplete fields.

However TinyTest's structure is unusual so DocBlockr's suggestions aren't much use.

```javascript
/**
 * [sanityCheckNEQ description]
 * @param  {[type]} test) { test.notEqual(true, false);} [description]
 * @return {[type]} [description]
 */
```

Simply copy from the 'Check Equality' test and adapt.  The use of the tags ```@namespace``` and ```@memberof Tinytest``` is just one of jsDoc's many workaround tricks for special cases.
<!-- Code for this begins at line #485-->
<!-- B -->
]
