---
.left-column[
  ### Sublime ESLint
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Reconfigure the '.eslintrc' file

In Sublime Text :
1. go to the menu ```File >> Open Folder```
2. find our project ```~/projects/${PROJECT_NAME}``` and open it
3. begin editing the file ```.eslintc```
4. search for ```/rules/quotes```
5. change 'double' to 'single'.

```JSON
    'quotes': [
      2, 'double', 'avoid-escape'    // http://eslint.org/docs/rules/quotes
    ],
```
<!-- B -->]
