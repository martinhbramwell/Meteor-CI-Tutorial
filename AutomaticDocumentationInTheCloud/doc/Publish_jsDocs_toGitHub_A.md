---
name: PublishJsDocsToGitHub_A
.left-column[
  ### 'GitHub Pages' Web Site
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Your jsDoc Documents as a GitHub Pages Website
<a href="https://help.github.com/articles/what-are-github-pages/" target="_blank">The user guide for "GitHub Pages"</a>, shows how GitHub can publish <a href="https://help.github.com/articles/creating-project-pages-manually/" target="_blank">a special branch of your repository</a> as a web site.

In the next step we run a script that automates :
 - checking out the 'gh-pages' branch
 - decompressing a zipped copy of our docs
 - committing the 'gh-pages' branch & pushes to GitHub
 - returning to the current branch
 
For safety sake, the script includes a number of checks and validations :
 - the directory must contain the specified repository
 - the current branch must be fully committed and pushed to GitHub
 - there is a valid zip file of a docs directory

Finally, if no 'gh-pages' branch exists, it will create one.

Continued . . .

<!-- B -->]
