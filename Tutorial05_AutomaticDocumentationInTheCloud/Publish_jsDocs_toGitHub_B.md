---
name: PublishJsDocsToGitHub_B
.left-column[
  ### 'GitHub Pages' Web Site
  <br /><br /><div class="input_type_indicator"><img src="./fragments/loader.gif" /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Your jsDoc Documents as a GitHub Pages Website

A few minutes after this step completes, you'll find your documentation on the web at :

<a href="https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/" target="_blank">https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/</a>.

##### Example Commands
```terminal
zip -qr ../.tmp_docs.zip *
git add docs/*
git commit -am "Preliminary package documentation."
git push
./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} .tmp_docs.zip
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/modularize/Tutorial05_AutomaticDocumentationInTheCloud/AutomaticDocumentationInTheCloud_functions.sh#L47" target="_blank">Code for this step.</a>] ]
]

