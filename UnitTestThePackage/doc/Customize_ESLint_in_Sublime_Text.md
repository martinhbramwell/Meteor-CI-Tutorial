---
.left-column[
  ### Sublime ESLint
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Customize the '.eslintrc' file

In Sublime Text :
1. go to the menu ```File >> Open Folder```
2. find and open our project ```~/projects/${PROJECT_NAME}```
3. begin editing the file ```.eslintrc```
4. search for ```/rules/quotes```
5. change 'double' to 'single'
```JSON
    'quotes': [
      2, 'single', 'avoid-escape'    // http://eslint.org/docs/rules/quotes
    ],
```
6. save the file :  ```File >> Save```

You have reconfigured the ESLint rule ```'quotes'```.  The complete list of configurable rules is available from <a target="blank" href="http://eslint.org/docs/rules/">eslint.org rules documentation</a>
<!-- B -->]
