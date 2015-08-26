#!/bin/bash
#
echo "Pushed"
git checkout master
echo "- - - back on branch master - - -"
git stash apply
echo "Reverted stash"
