---
.left-column[
  ### Configure git for GitHub
.footnote[.red.bold[] [Back to TOC](/)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Configure git for use with GitHub.

In this step we set up the local git tool kit to communicate correctly with GitHub.

Steps performed :
- identify user name
- identify user email
- use simple push

        git config --global user.name "${YOUR_EMAIL}"
        git config --global user.email "${YOUR_NAME}"
        git config --global push.default simple

<!-- -->]
