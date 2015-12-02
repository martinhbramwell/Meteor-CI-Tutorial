---
.left-column[
  ### Helper File - Commit gh-pages Branch (Part A)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Push Docs To GitHub Pages From CI Build (Part A)

Now that our build script has sufficient privileges, we can enable the call to ```commitDocsToGitHubPages```, which is commented out at the bottom of the file ```./tools/perform_ci_tasks.sh``` :

```ruby
checkCodeStyle;
generateDocs;
# commitDocsToGitHubPages;    # <--  uncomment
```

We'll also update our ```circle.yml``` script, adding the call to ```perform_per_package_ci_tasks.sh```, as follows :

```ruby
test:
  override:
    # Perform per package CI Tasks
    - ${HOME}/${CIRCLE_PROJECT_REPONAME}/packages/perform_per_package_ci_tasks.sh
```


<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L165" target="_blank">Code for this step.</a>] ]
]
