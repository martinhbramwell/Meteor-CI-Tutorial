---
.left-column[
  ### Console.log is bad!
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Observe ordinary console logging.

Here we see one of the advantages of TinyTest in the browser: quickly seeing TDD results in a tight loop.

Run the command

```terminal
meteor test-packages
```
then in the browser open [localhost:3000](http://localhost:3000/)

To the file ```packages/skeleton/skeleton-tests.js``` add the following
```javascript
// Write your tests here!
// Here is an example.
Tinytest.add("example", function sanity(test) {
    console.log("ººº Yoo Hoo ººº"); //  ADD! <--
    test.equal(true, true);
});
```
then save it and observe the command line logs and the browser console


<!-- B -->]
