#!/bin/bash
#

MINFREESPACE=1500000
FREESPACE=$(df / | grep dev | awk '{print $4}')
if [[  ${FREESPACE} -lt ${MINFREESPACE} ]]; then
  echo You have only ${FREESPACE} bytes free.  You should have ${MINFREESPACE};
  exit
fi;

if [[ $EUID -ne 0 ]]; then
   echo -e "This script must be run with 'sudo' (run as root). " 
   exit 1
fi



# sudo tee /etc/apt/apt.conf.d/02proxy > /dev/null <<APTPRXY
# Acquire::http::Proxy { "http://192.168.122.1:3142"; };
# Acquire::http::Proxy { deb.nodesource.com DIRECT; };
# APTPRXY

# sudo sed -i -e 's/XubTahr-updateMe/meteor_ci/g' /etc/hosts
# sudo sed -i -e 's/XubTahr-updateMe/meteor_ci/g' /etc/hostname

source ./explain.sh

echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e ""
echo -e "############################################################################"
echo -e "#"
echo -e "#   These scripts prepare the way for you to get started easily with"
echo -e "#   Meteor package development, testing, documenting, code style"
echo -e "#   linting and continuous integration"
echo -e "#"
echo -e "#   They are designed for a small (10GB) Xubuntu 14.04 virtual machine."
echo -e "#   They have not been tested in any other environment since the idea is"
echo -e "#   to provide clear proven instructions that can be adapted easily to"
echo -e "#   other circumstances."
echo -e "#"
echo -e "#   The scripts are 'idempotent' -- you can run them repeatedly without"
echo -e "#   adverse consequences."
echo -e "#"
echo -e "#   The first script 'Prep4MeteorCI_A.sh' sets up all necessary preconditions"
echo -e "#   for the second script.  The second one 'Prep4MeteorCI_B.sh' takes you "
echo -e "#   through the entir process of preparing a Meteor project and package with "
echo -e "#   all the previously mentioned application development support tools.."
echo -e "#"
echo -e "############################################################################"
read -p "Hit <enter> ::  " -n 1 -r REPLY

AUTORUN="";
explain "#  Java 7 is required by Nightwatch.
\n#
\n#  This command group gets the Oracle Java PPA and installs it.
\n#  Normally the script should prompt you to accept the license.
\n#  By proceeding with this step you accept the license agreement, implicitly."
if [ $? -eq 0 ]; then
  echo -e # -- Get PPAs for Oracle Java 7 and update APT --
  add-apt-repository -y ppa:webupd8team/sublime-text-3
  apt-get update

  echo -e # -- Install Oracle Java 7 -- 
  echo -debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  apt-get -y install oracle-java7-installer 
fi

explain "#  This tutorial expects to use the Sublime Text 3 editor.
\n#
\n#  The next command group gets the Sublime Text 3 PPA and installs it.
\n#  If you just want to quickly follow the tutorial then do execute
\n#  this group of commands."
if [ $? -eq 0 ]; then
  echo -e # -- Get PPAs for Sublime Text editor --
  add-apt-repository -y ppa:webupd8team/java
  echo -e # -- Install Sublime Text editor --
  apt-get install -y sublime-text-installer
fi

explain "#  Install other tools.
\n#  
\n#  This sequence installs the following dependencies, if they're not
\n#  already present :
\n#     -  '\e[1;34mbuild-essential\e[0m' and '\e[1;34mlibssl-dev\e[0m' for selenium webdriver
\n#     -  '\e[1;34mlibappindicator1\e[0m'           for chrome
\n#     -  '\e[1;34mcurl\e[0m'                       for Meteor
\n#     -  '\e[1;34mtree\e[0m'                       for demo convenience
\n#     -  '\e[1;34mgit\e[0m' and '\e[1;34mssh\e[0m' for version control
\n#  ."
if [ $? -eq 0 ]; then
  apt-get install -y build-essential libssl-dev  # for selenium webdriver
  apt-get install -y libappindicator1            # for chrome
  apt-get install -y curl                        # for Meteor
  apt-get install -y tree                        # for demo convenience
  apt-get install -y git ssh                     # for version control
fi

explain "#  Install Node.js.
\n#
\n#  Nightwatch is a NodeJS utility, so you have to install NodeJS wherever 
\n#  you might want do Nightwatch testing."
if [ $? -eq 0 ]; then
  pushd /tmp
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  apt-get install -y nodejs
  apt-get -y autoremove
  popd
fi


explain "#  Install Google Chrome and the Selenium Web Driver for Chrome.
\n#
\n#  Nightwatch leverages Selenium, which has drivers for the major browsers.
\n#  The Chrome driver is the most convenient."
if [ $? -eq 0 ]; then
  pushd /tmp

  # Install 'chromedriver'
  export CHROMEDRIVER_VERSION=$(wget -qO - http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
  echo -e "Will install Chrome Driver version : ${CHROMEDRIVER_VERSION}"
  wget http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
  unzip -o chromedriver_linux64.zip -d /usr/local/bin
  chmod a+rx /usr/local/bin/chromedriver 

  # Install 'chrome'
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb 

  popd
fi

explain "#  Install “eslint” and configure Sublime Text 3.
\n#
\n#  ECMA Script linter detects code style contraventions, and traps many
\n#  hard to debug errors before they happen."
if [ $? -eq 0 ]; then
  npm install -gy eslint
  npm install -gy eslint-plugin-react
  npm install -gy babel-eslint
fi

echo -e ""
echo -e ""
echo -e ""
echo -e "######################################################################"
echo -e "#"
echo -e "#  Now :"
echo -e "#  Find Sublime Text in 'Accesories', add it to the panel and start it up."
echo -e "#  Go to View >> Show Console"
echo -e "#  Paste into the console the following :"
echo -e "
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
"
echo -e "#  Go to Preferences >> Package Control"
echo -e "#  In Package Control type : install package"
echo -e "#  Install these two packages :"
echo -e "#   - '\e[1;34mMarkDownEditing\e[0m'"
echo -e "#   - '\e[1;34mSideBarEnhancements\e[0m'"
echo -e "#  In Preferences >> Color Scheme >> Color Scheme - Default, pick 'IDLE' "
echo -e "#"
echo -e "######################################################################"

echo "Done.";
exit 0;

