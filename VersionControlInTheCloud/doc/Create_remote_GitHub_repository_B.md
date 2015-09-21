---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

... continuing.

This procedure will be more understandable if you watch the video series mentioned on the [Table of Contents](./) page. The steps are :

1. Log in to [GitHub](https://github.com/) as ```${PACKAGE_DEVELOPER}```
1. **Either** create the ```${GITHUB_ORGANIZATION_NAME}``` organization, if it *does not exist* **or** switch to operate in that role if it *does exist*.
1. Create a project with the exact name ```${PROJECT_NAME}```. Don't set any other values. We'll do that automatically.
1. Select ```Settings``` *(project page bottom-right)* then ```DeployKeys``` *(settings page bottom-left)*, then ```Add deploy key```
1. copy the contents of ```~/.ssh/id_rsa.pub``` to the ```key``` field
1. give the key a name in the ```Title``` field
1. Log in to [CircleCI](https://circleci.com/) and set it to monitor project ```${PROJECT_NAME}``` for rebuilding.



<!-- B -->]
