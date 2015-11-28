---
.left-column[
  ### Sublime ESLint
  <br /><br /><div class='input_type_indicator'><img src='./fragments/typer.png' /><br />Manual input is required here.</div><br />
.footnote[.red.bold[] [Table of Contents](./)] 
<!-- H -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

#### Correct the indicated code-quality defects

In Sublime Text, make sure you're editing the same project as you opened in the previous slide, then :
1. begin editing the files ```./${PROJECT_NAME}.js``` and ```./packages/${PKG_NAME}/${PKG_NAME}-tests.js```
2. the former has ESLint deficiencies indicated, while the latter does not.
3. open ```./.eslintrc``` and save it as ```./packages/${PKG_NAME}/.eslintrc```
4. close and reopen ```./packages/${PKG_NAME}/${PKG_NAME}-tests.js``` and deficiency flags will appear
5. click on line '3' and notice the status bar has a warning ```func-names``` and an error ```space-before-function-paren```
6. add ```checkSanity``` after the key word ```function``` to correct both defects

```javascript
Tinytest.add('example', function checkSanity(test) {
  test.equal(true, true);
});
```

<!-- B -->
 
<div id="needineach" class="popup_div">
    <a class="subtle_a" onmouseover="HideContent('needineach'); return true;"
       href="javascript:HideContent('needineach')">
        <p>By default, the linter in Sublime Text ignores files reached by symbolic links. Consequently, you'll need an .eslintrc file in each package.</p>
    </a>
</div>
<a
    class="hover_text"
    onmouseover="ReverseContentDisplay('needineach'); return true;"
    href="javascript:ReverseContentDisplay('needineach')">
    *¡HOVER NOTE!*
</a>


]
