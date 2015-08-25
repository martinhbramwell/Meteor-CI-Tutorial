echo "Prepared message : "
cat $1
MSG=$(cat $1)
echo ${MSG}
exit
git stash
git checkout gh-pages
git checkout master -- index.html
git checkout master -- Prep4MeteorCI_A/index.html
git checkout master -- Prep4MeteorCI_A/concatenatedSlides.MD
git checkout master -- Prep4MeteorCI_B/index.html
git checkout master -- Prep4MeteorCI_B/concatenatedSlides.MD
git commit -am $($1)
git push
git checkout master
git stash apply
