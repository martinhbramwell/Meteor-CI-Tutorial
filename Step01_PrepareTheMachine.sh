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

DOCS="./PrepareTheMachine/doc"

# sudo tee /etc/apt/apt.conf.d/02proxy > /dev/null <<APTPRXY
# Acquire::http::Proxy { "http://192.168.122.1:3142"; };
# Acquire::http::Proxy { deb.nodesource.com DIRECT; };
# APTPRXY

# sudo sed -i -e 's/XubTahr-updateMe/meteor_ci/g' /etc/hosts
# sudo sed -i -e 's/XubTahr-updateMe/meteor_ci/g' /etc/hostname

source ./explain.sh

highlight ${DOCS}/Introduction.md
echo ""
echo "To view the documentation fragments in you browser do the following"
echo " - execute : ./concatenateTheSlides.sh"
echo " - execute : python -m SimpleHTTPServer 8080"
echo " - launch your browser and open : http://localhost:8080/"
echo ""
read -p "Hit <enter> ::  " -n 1 -r REPLY


AUTORUN="";
explain ${DOCS}/Java_7_is_required_by_Nightwatch.md
if [ $? -eq 0 ]; then
  echo -e # -- Get PPAs for Oracle Java 7 and update APT --
  add-apt-repository -y ppa:webupd8team/java
  apt-get update

  echo -e # -- Install Oracle Java 7 --
  echo -debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  apt-get -y install oracle-java7-installer
fi

explain ${DOCS}/This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md
if [ $? -eq 0 ]; then
  echo -e # -- Get PPAs for Sublime Text editor --
  add-apt-repository -y ppa:webupd8team/sublime-text-3
  apt-get update
  echo -e # -- Install Sublime Text editor --
  apt-get install -y sublime-text-installer
fi

explain ${DOCS}/Install_other_tools.md
if [ $? -eq 0 ]; then
  apt-get install -y build-essential libssl-dev  # for selenium webdriver
  apt-get install -y libappindicator1            # for chrome
  apt-get install -y curl                        # for Meteor
  apt-get install -y tree                        # for demo convenience
  apt-get install -y git ssh                     # for version control
fi

explain ${DOCS}/Install_NodeJS.md
if [ $? -eq 0 ]; then
  pushd /tmp
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  apt-get install -y nodejs
  apt-get -y autoremove
  popd
fi


explain ${DOCS}/Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md
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

explain ${DOCS}/Install_eslint_and_configure_SublimeLinter.md
if [ $? -eq 0 ]; then
  npm install -gy eslint
  npm install -gy eslint-plugin-react
  npm install -gy babel-eslint
fi

highlight ${DOCS}/Configure_Sublime_A.md
read -p "Hit <enter> ::  " -n 1 -r REPLY

highlight ${DOCS}/Configure_Sublime_B.md

echo "Done.";
exit 0;

