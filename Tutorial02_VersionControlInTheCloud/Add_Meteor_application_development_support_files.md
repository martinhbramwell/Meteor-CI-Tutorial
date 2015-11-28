---
.left-column[
  ### Meteor App Metadata
  <br /><br /><div class='input_type_indicator'><img src='./fragments/loader.png' /><br />No manual input required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Add Meteor application metadata files

In this step we create some of the project meta data files :
 -  LICENSE
 -  README.md
 -  .gitignore
 -  .eslintrc
 -  public/favicon-32x32.png

The .eslintrc file is borrowed from the project <a href='https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc' target='_blank'>warehouseman:meteor-swagger-client</a>

##### Example Commands
```terminal
wget -N https://raw.githubusercontent.com/warehouseman/meteor-swagger-client/master/.eslintrc
wget -O ./public/favicon-32x32.png https://raw.githubusercontent.com/martinhbramwell/Meteor-CI-Tutorial/master/fragments/favicon-32x32.png
sed -i "/<head>/c<head>\
    \\n  <link rel=\"shortcut icon\" href=\"/favicon-32x32.png\" type=\"image/x-icon\" />" ${PROJECT_NAME}.html
```

<!-- B -->
.center[.footnote[.red.bold[] <a href="https://github.com/martinhbramwell/Meteor-CI-Tutorial/blob/master/Tutorial02_VersionControlInTheCloud/VersionControlInTheCloud_functions.sh#L118" target="_blank">Code for this step.</a>] ]
]
