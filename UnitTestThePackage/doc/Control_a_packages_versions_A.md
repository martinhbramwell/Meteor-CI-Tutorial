---
.left-column[
  ### Create Meteor Packages
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Controlling Versions of your Meteor package.

Another consequence of keeping packages outside your project directory is the need for a separate version control repository for each one.

The resulting modularity is benefical and the multiplication of git commands can be mitigated by using <a href="https://git-scm.com/book/en/v2/Git-Tools-Submodules" target="_blank">git submodules</a> *("Submodules allow you to keep a Git repository as a subdirectory of another Git repository.")*. Regardless of whether we go that way we must repeat the earlier steps to create [remote](#CreateRemoteGitHubRepository) and [local](#CreateLocalGitHubRepository) repositories, this time for ```${PKG_NAME}```.


#####Commands
```terminal
cd ~/${PARENT_DIR}/${PROJECT_NAME}/packages
ln -s ${PACKAGE_DIRS}/${YOUR_NAME}/${PKG_NAME} ${PKG_NAME}
```
For editing purposes your package now appears to be part of your project.
<!-- Code for this begins at line #278-->
<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Part02_UnitTestThePackage.sh#L356" target="_blank">Code for this step.</a>] ]
]
