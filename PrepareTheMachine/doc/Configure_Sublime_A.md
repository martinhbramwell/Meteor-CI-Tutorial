---
.left-column[
  ### Prepare Sublime Text (Step #1)
.footnote[.red.bold[] [Back to TOC](./)] 
<!-- -->]
.right-column[
~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ - o 0 o - ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

### (Optional) Preparation of Sublime Text 
#### First step - add '[Package Control](https://packagecontrol.io/)'

We need [Sublime Text 3](http://www.sublimetext.com/3) configured as follows :

 - Find Sublime Text in 'Start >> Development', add it to the panel and start it up.
 - Go to View >> Show Console
 - Paste the following installer for [Package Control](https://packagecontrol.io/) into ST3's console :

.small[
```terminal
# - - - snip - - - 
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
# - - - snip - - - 

```
]


<!-- -->]
