echo "Prepared message : "
git stash
echo "Stashed"
git checkout gh-pages
echo "On branch gh-pages"
git checkout master -- index.html
echo "Pulled index.html"
git checkout master -- Prep4MeteorCI_A/index.html
git checkout master -- Prep4MeteorCI_A/concatenatedSlides.MD
git checkout master -- Prep4MeteorCI_B/index.html
git checkout master -- Prep4MeteorCI_B/concatenatedSlides.MD
echo "Pulled all"
git commit -am $(cat $1)
echo "Committed"
git push
echo "Pushed"
git checkout master
echo "- - - back on branch master - - -"
git stash apply
echo "Reverted stash"
