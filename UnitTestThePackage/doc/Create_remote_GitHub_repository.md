---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

In this step we create a repository in GitHub project source hosting.

The steps are :

 - Log in to [GitHub](https://github.com/) as ```${PACKAGE_DEVELOPER}```
 - Switch to the ```${GITHUB_ORGANIZATION_NAME}``` organization, (if different from ```${PACKAGE_DEVELOPER}```)
 - Create a project with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
 - Log in to [CircleCI](https://circleci.com/) and set it to monitor project ```${PROJECT_NAME}``` for rebuilding.

Some steps are more understandable if you watch the video series mentioned on the [Table of Contents](./) page.



<!-- B -->]
