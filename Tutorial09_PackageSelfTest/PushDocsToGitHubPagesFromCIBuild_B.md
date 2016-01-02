---
last_update: 2015-12-18
 .left-column[
  ### Helper File - Commit gh-pages Branch (Part B)
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Pushing Docs To GitHub Pages From CI Build (Part B)

Finally, we can commit all these changes and push them out to GitHub.  When we do that, GitHub will hook CircleCI into performing a new build.  We should see :

 - The build completed successfully at https://circleci.com/gh/${GITHUB_ORGANIZATION_NAME}/${PROJECT_NAME}
 - <a href="https://martinhbramwell.github.io/Meteor-CI-Tutorial/fragments/loader.gif" target="_blank">CircleCI Artifacts tab</a> links to successful results for :
   - Linting in "eslintReport.txt"
   - Nightwatch test results in "result.json"
 - Latest documentation at our GitHub Pages web site.

##### Example Commands

```ruby
git add ./tools/perform_ci_tasks.sh;
git commit -am "Added code maintenance tasks";
#
git add ./packages/perform_per_package_ci_tasks.sh;
git add circle.yml;
git commit -am "Added code maintenance package iterator and augmented circle.yml";
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial09_PackageSelfTest/PackageSelfTest_functions.sh#L213" target="_blank">Code for this step.</a>]  ]
]
