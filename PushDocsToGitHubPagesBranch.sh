#!/bin/bash
#

shopt -s extglob;

GITHUBPAGES="gh-pages"
function PushDocsToGitHubPagesBranch() {

	if git rev-parse --verify ${GITHUBPAGES} >/dev/null 2>&1; then

    echo -e "Found existing '${GITHUBPAGES}' branch.";

	else
		echo "Creating local ${GITHUBPAGES} branch";
		# git branch ${GITHUBPAGES}
		# git push --set-upstream origin ${GITHUBPAGES}
		git checkout --orphan ${GITHUBPAGES}
		echo "Clean out all but '$1' and hidden files";
#		rm -fr !($1) 2> /dev/null
		rm -fr *
		ls -la
		echo "Committing locally"
		git commit -am "Cleaned out"
		echo "Pushing to new remote repository"
		git push --set-upstream origin ${GITHUBPAGES}
		echo "Switching back to work on local master"
		git checkout master
	fi;

	MSG=$(git log -1 --pretty=%B)

	git checkout ${GITHUBPAGES}
	echo -e "Working on branch : '${GITHUBPAGES}'"

#  ls -la

	unzip -o $1 >/dev/null
	echo -e "Extracted files from : $1"
	rm $1

#  ls -la

	git add .

	git commit -am "${MSG}"
	echo -e "Committed '$1' files with recent master commit message :\n'${MSG}'."

	git push
	echo "Pushed"

	git checkout master
	echo "- - - back on branch master - - -"

	# if [[ "${STASH_CREATED}" != "No local changes to save" ]];
	# then
	# 	git stash apply;
	# 	echo "Reverted stash"
	# else
	# 	echo "No stash to restore";
	# fi;

}

pushd ~/projects/packages/yourself/yourpackage/docs >/dev/null;
rm -f ../.tmp_docs.zip
zip -qr ../.tmp_docs.zip *
popd >/dev/null;

VALID=true;
if grep "$1" $2/.git/config  >/dev/null 2>&1; then 
#   	echo "* * * The directory ($2) appears to contain valid git repo : '$1' * * *";

	pushd $2 >/dev/null;
	IFS_BK=${IFS}; 
	IFS=' ' read -a UNCOMMITED_CHANGES <<< $(git diff --shortstat);
	IFS=${IFS_BK};
	if [[ ${UNCOMMITED_CHANGES[0]} -gt 0 ]]; then
		echo -e "\n\n * * * Git Error : There are uncommitted changes.  Cannot proceed * * * \n";
		git diff --stat
		git branch
		pwd
		popd >/dev/null;
  	exit 1;
	elif [[  $(git log origin/master..master | grep -c commit) -gt 0  ]]; then
		echo -e "\n\n * * * Git Error : Recent commits have not been pushed.  Cannot proceed * * * \n";
		popd >/dev/null;
  	exit 1;
  elif unzip -l $3  >/dev/null 2>&1; then

		echo "The zip file ($3) seems to have files!"
		PushDocsToGitHubPagesBranch $3

	else
		echo -e "\n\n * * * $3  doesn't apppear to be a valid zip file * * * \n";
		VALID=false;
	fi;

	popd >/dev/null;

else
   	echo -e "\n\n * * * The directory ($2) DOES NOT appear to contain a valid git repo for : '$1' * * * \n";
	VALID=false;
fi;

if [[ "$VALID" != "true" ]]; then

	echo -e "Usage $0 gitRepoName gitRepoPath gitHubPagesHtmlZipFile"
	echo -e "This script : 
	- steps into the directory git_repo_path
	- stashes changes in current branch if any
	- creates a ${GITHUBPAGES} branch if none exists
	- checks out the ${GITHUBPAGES} branch
	- decompresses gitHubPagesHtmlZipFile
	- commits to ${GITHUBPAGES} branch
	- pushes to remote
	- returns to current branch
	- recovers stashed artifacts, if any.
	"
	echo 
fi;

