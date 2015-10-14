#!/bin/bash
set -e
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

SUDOUSER=$(who am i | awk '{print $1}')

DOCS="./PrepareTheMachine/doc"

# sudo tee /etc/apt/apt.conf.d/02proxy > /dev/null <<APTPRXY
# Acquire::http::Proxy { "http://192.168.122.1:3142"; };
# Acquire::http::Proxy { deb.nodesource.com DIRECT; };
# APTPRXY

# sudo sed -i -e 's/XubTahr-updateMe/meteor_ci/g' /etc/hosts
# sudo sed -i -e 's/XubTahr-updateMe/meteor_ci/g' /etc/hostname

# On VM host if necessary
#   qemu-img resize /var/lib/libvirt/images/xxxxx.img +1G

#  wget -O Meteor-CI-Tutorial.zip https://github.com/martinhbramwell/Meteor-CI-Tutorial/archive/master.zip
#  unzip Meteor-CI-Tutorial.zip
#  mv Meteor-CI-Tutorial-master/ Meteor-CI-Tutorial
#  cd Meteor-CI-Tutorial


source ./explain.sh
source ./util.sh

highlight ${DOCS}/Introduction.md # explain
echo ""
echo "To view this embedded documentation as a browser slideshow choose one of the following options:"
echo " A) Open your browser to http://martinhbramwell.github.io/Meteor-CI-Tutorial/"
echo " B) If you have Python in your machine (you have '$(python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";)') you can do :"
echo " - execute : ./concatenateTheSlides.sh n"
echo " - then execute : python -m SimpleHTTPServer 8080"
echo " - then launch your browser and open : http://localhost:8080/"
echo " C) If you already know Meteor, you can just stuff a copy of this directory in the 'public' directory of a Meteor app."
echo ""
read -p "Hit <enter> ::  " -n 1 -r REPLY


RUN_RULE="";
explain ${DOCS}/Java_7_is_required_by_Nightwatch.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  echo -e # -- Get PPAs for Oracle Java 7 and update APT --
  add-apt-repository -y ppa:webupd8team/java
  apt-get update

  echo -e # -- Install Oracle Java 7 --
  echo -debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  apt-get -y install oracle-java7-installer
fi




explain ${DOCS}/Install_other_tools.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  apt-get install -y build-essential libssl-dev  # for selenium webdriver
  apt-get install -y libappindicator1            # for chrome
  apt-get install -y curl                        # for Meteor
  apt-get install -y git ssh                     # for version control
  apt-get install -y tree  python-pip            # for demo convenience
fi



explain ${DOCS}/Install_NodeJS.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  pushd /tmp
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  apt-get install -y nodejs
  apt-get -y autoremove
  popd
fi




explain ${DOCS}/Install_Selenium_Webdriver_In_NodeJS.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  mkdir -p ~/.npm
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
  npm install -y --prefix $HOME selenium-webdriver

fi




explain ${DOCS}/Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
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



explain ${DOCS}/Install_Bunyan_Globally.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then

  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
  sudo npm install -y --global --prefix /usr bunyan

  LOG_DIR="/var/log/meteor"
  sudo mkdir -p ${LOG_DIR}
  sudo chown ${SUDOUSER}:${SUDOUSER} ${LOG_DIR}
  sudo chmod ug+rwx ${LOG_DIR}

fi




explain ${DOCS}/This_tutorial_expects_to_use_the_Sublime_Text_3_editor.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  echo -e # -- Get PPAs for Sublime Text editor --
  add-apt-repository -y ppa:webupd8team/sublime-text-3
  apt-get update
  echo -e # -- Install Sublime Text editor --
  apt-get install -y sublime-text-installer
  echo -e # -- Install HTML parser for obtaining installer for ST3 Package Control --
  pip install beautifulsoup4 requests
fi

explain ${DOCS}/Install_eslint.md MORE_ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  npm install -gy eslint
  npm install -gy eslint-plugin-react
  npm install -gy babel-eslint
fi


explain ${DOCS}/Install_jsdoc.md ACTION # CODE_BLOCK
if [ "${RUN_RULE}" != "n" ]; then
  npm install -g jsdoc
fi


export ST3URL="https://packagecontrol.io/installation#st3";
highlight ${DOCS}/Configure_Sublime_A.md # CODE_BLOCK explain
echo "";
echo "If there is no networking error, then the following text will be the snippet obtained from  : ${ST3URL}";
python -c "import requests;from bs4 import BeautifulSoup;print '>>>\n';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
echo "";
read -p "Hit <enter> ::  " -n 1 -r REPLY


highlight ${DOCS}/Configure_Sublime_B.md # explain


export BIN_DIR=/usr/local/bin
chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
mkdir -p ${BIN_DIR}
touch ${BIN_DIR}/meteor
chown -R ${SUDOUSER}:${SUDOUSER} ${BIN_DIR}
chmod -R a+w ${BIN_DIR}

## FLAG FOR INCLUSION IN SLIDES - ${DOCS}/Fin.md explain

echo -e "\n\n\nDone! You have finished with 'Part01_PrepareTheMachine.sh'."
echo -e "\n\n  Now you can execute ::  './Part02_VersionControlInTheCloud.sh'?"


echo -e "\n\n";

exit 0;

