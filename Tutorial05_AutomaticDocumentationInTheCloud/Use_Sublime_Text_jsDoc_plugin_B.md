---
last_update: 2016-01-02
 .left-column[
  ### jsDoc for ST3
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Use the Sublime Text package "DocBlockr"

. . . continued.

To have DocBlockr help finish the annotations for ```'Check inequality'``` type ```/∗∗``` followed by ```<enter>```. It will attempt to create appropriate tags.  You can ```<tab>``` and ```<shift-tab>``` back and forth between incomplete fields.

TinyTest's structure is atypical -- so the suggestions are less useful than usual.

```javascript
/∗∗
 ∗ [sanityCheckNEQ description]
 ∗ @param  {[type]} test) { test.notEqual(true, false);} [description]
 ∗ @return {[type]} [description]
 ∗/
```

Simply copy from the 'Check Equality' test and adapt.  The use of the tags ```@namespace``` and ```@memberof Tinytest``` is just one of jsDoc's many workaround tricks for special cases.

Continues . . .
<!-- B -->
]
