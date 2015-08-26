---
.left-column[
  ### Test a Meteor Package
.footnote[.red.bold[] [Back to TOC](..)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create a package and TinyTest it.

Meteor makes this very easy. Two commands and we have a unit tested package.

- meteor create --package yours:skeleton
- meteor test-packages

Meteor will start up as a background process in TinyTest mode.

In a browser, open the URL [localhost:3000](http://localhost:3000/) to confirm that it is working.

Notice the files newly added under the package directory.  These will also have to be pushed to GitHub.


<!-- -->]
