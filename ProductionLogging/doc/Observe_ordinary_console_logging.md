---
.left-column[
  ### Console.log is bad!
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Observe ordinary console logging.

Run the command ```meteor test-packages```. In a browser open [localhost:3000](http://localhost:3000/)

To the file ```packages/${PKG_NAME}/${PKG_NAME}-tests.js``` add the following
```javascript
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
    test.equal(true, true);
    console.log('ººº Yoo Hoo ººº');              //  ADD! <--
});
```
then save it and observe the command line logs and the browser console.  Here we see one of the advantages of TinyTest in the browser: quickly seeing TDD results in a tight loop.

However, *esLint* rightfully flags ```console.log()``` as **a bad thing!**  Writing out text is the only feature it shares with serious logging tools.

<!-- B -->]
