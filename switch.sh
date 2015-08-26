#!/bin/bash
#
echo "Returning to master"
git checkout master
echo "- - - back on branch master - - -"
git stash apply
echo "Reverted stash"
