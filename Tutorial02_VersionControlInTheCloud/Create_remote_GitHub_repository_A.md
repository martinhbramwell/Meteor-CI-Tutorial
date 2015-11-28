---
name: CreateRemoteGitHubRepository
.left-column[
  ### GitHub Repo
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Create the **remote** GitHub repository.

In this step we create a repository in GitHub project source hosting.  

The most direct approach to creating a GitHub repo is simply to do it in your own name and manage it using the account owner's (your!) SSH keys.

However, if you take a long-term view, it's much more flexible and resilient to assume a large team from day one. While it's fractionally more difficult, it beats the hell out of having to refactor some day because you have too many committers with keys on your personal account.

We'll create an organization distinct from ourselves (```${GITHUB_ORGANIZATION_NAME}```), and add our own SSH public key as a ```"Deploy key"``` for each repo we create.

Continued . . . 
<!-- B -->]
