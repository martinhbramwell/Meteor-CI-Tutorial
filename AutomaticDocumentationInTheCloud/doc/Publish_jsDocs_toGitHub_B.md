---
name: PublishJsDocsToGitHub
.left-column[
  ### 'GitHub Pages' Web Site
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
#### Your jsDoc Documents as a GitHub Pages Website

When this step completes you will find your documenatation on-line at the URL : 

<a href="https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/" target="_blank">https://${GITHUB_ORGANIZATION_NAME}.github.io/${PKG_NAME}/</a>.

##### Commands
```terminal
zip -qr ../.tmp_docs.zip *
git add docs/*
git commit -am "Preliminary package documentation."
git push
./PushDocsToGitHubPagesBranch.sh ${PKG_NAME} ~/${PARENT_DIR}/${PROJECT_NAME}/packages/${PKG_NAME} .tmp_docs.zip
```

<!-- Code for this begins at line #105 -->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part05_AutomaticDocumentationInTheCloud.sh#L105" target="_blank">Code for this step.</a>] ]
]
