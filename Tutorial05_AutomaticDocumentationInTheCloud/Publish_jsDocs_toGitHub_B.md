---
name: PublishJsDocsToGitHub_B
last_update: 2016-02-09
 .left-column[
  ### 'GitHub Pages' Web Site
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [
Table of Contents](./toc.html)
<br />
<br />&nbsp; &nbsp;Last update
<br />&nbsp; &nbsp; {{ last_update  }}
]
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Your jsDoc Documents as a GitHub Pages Website

Shortly after this step completes, you would expect to find your documentation on the web. You won't find it; instead you'll get a 404 error.  GitHub has <a href="https://help.github.com/articles/troubleshooting-github-pages-build-failures/#deploy-key-used-for-push" target="_blank">a rule</a> about ```gh-pages``` and deploy keys.  The fix is to edit a file online in the repo (eg, README.md) and save it.  However. **first** you must verify your user email address!  After that, (as an implicit commit/push by a verified user) the site will appear at :  <a href="https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/" target="_blank">https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/</a>.

##### Example Commands
```terminal
zip -qr /tmp/${PKG_NAME}_docs.zip ∗
git checkout gh-pages
unzip -o /tmp/${PKG_NAME}_docs.zip
git add docs/∗
git commit -am "Preliminary package documentation."
git push
./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} .tmp_docs.zip
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L59" target="_blank">Code for this step.</a>] ]
]

