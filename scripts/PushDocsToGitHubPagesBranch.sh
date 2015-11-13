#!/bin/bash
#

shopt -s extglob;

GITHUBPAGES="gh-pages"
function PushDocsToGitHubPagesBranch() {

echo " 1 = $1";
echo " 2 = $2";

	if git rev-parse --verify ${GITHUBPAGES} >/dev/null 2>&1; then

		echo -e "Found existing '${GITHUBPAGES}' branch.";

	else
		echo "Creating local ${GITHUBPAGES} branch";

		touch .gitignore;
		if [[ $(cat .gitignore | grep -c "$1") -lt 1 ]]; then echo "$1" | cat >> .gitignore; fi;
		git add .gitignore

		git checkout --orphan ${GITHUBPAGES}
		echo "Clean out all but '$1' and hidden files";
#		rm -fr !($1) 2> /dev/null
		rm -fr *
		ls -la
		echo "Committing locally"
		git commit -am "Cleaned out"
		echo "Pushing to new remote repository : $2"
		git push --set-upstream $2 ${GITHUBPAGES}
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
	echo "Deleted the file '$1'"

#  ls -la

	git add .

	git commit -am "${MSG}"
	echo -e "Committed '$1' files with recent master commit message :\n'${MSG}'."

	git push
	echo "Push errors : $?"

	git checkout master
	echo "- - - back on branch master - - -"


}

# FIXME -development only -->
# TEMP_ZIP="/tmp/yourpackage_docs.zip"
# pushd ~/projects/packages/yourself/yourpackage/docs >/dev/null;
# rm -f ${TEMP_ZIP}
# zip -qr ${TEMP_ZIP} *
# popd >/dev/null;
#                        <--

REPO=${1};
GDIR=${2};
ZIPPD=${3};
REMOTE=${4};

# In git managed directory 'pkg00', attempting to publish the decompressed contents of
#      '/home/dude/project_isle/prj00/packages/pkg00' to the
#          'gh-pages' branch of the './scripts/PushDocsToGitHubPagesBranch.sh' repo at remote 'pkg00_origin'.

echo -e "In git managed directory '${GDIR}', attempting to publish the decompressed contents of
     '${ZIPPD}' to the
         'gh-pages' branch of the '${REPO}' repo at remote '${REMOTE}'."

VALID=true;
if grep "${REPO}" ${GDIR}/.git/config  >/dev/null 2>&1; then

   	echo "* * * The directory (${GDIR}) appears to contain valid git repo : '${REPO}' * * *";

	pushd ${GDIR} >/dev/null;
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
	elif [[  $(git log ${REMOTE}/master..master | grep -c commit) -gt 0  ]]; then
		echo -e "\n\n * * * Git Error : Recent commits have not been pushed.  Cannot proceed * * * \n";
		popd >/dev/null;
  	exit 1;
  elif [[ $(unzip -l ${ZIPPD} | grep -c index.html) -gt 0 ]]; then

		echo "The zip file (${ZIPPD}) seems to have files!";
		PushDocsToGitHubPagesBranch ${ZIPPD} ${REMOTE}

	else
		echo -e "\n\n * * * ${ZIPPD}  doesn't apppear to be a valid zip file * * * \n";
		VALID=false;
	fi;

	popd >/dev/null;

else
   	echo -e "\n\n * * * The directory (${GDIR}) DOES NOT appear to contain a valid git repo for : '${REPO}' * * * \n";
	VALID=false;
fi;

if [[ "$VALID" != "true" ]]; then

	echo -e "Usage $0 gitRepoName gitRepoPath gitHubPagesHtmlZipFile"
	echo -e "This script :
	- steps into the directory \${gitRepoPath}
	- quits if current branch needs commiting or pushing
	- quits if \${gitRepoName} cannot be found in \${gitRepoPath}
	- creates a ${GITHUBPAGES} branch if none exists
	- checks out the ${GITHUBPAGES} branch
	- decompresses \${gitHubPagesHtmlZipFile}
	- commits to ${GITHUBPAGES} branch
	- pushes to remote
	- returns to current branch
	"
	echo
fi;

