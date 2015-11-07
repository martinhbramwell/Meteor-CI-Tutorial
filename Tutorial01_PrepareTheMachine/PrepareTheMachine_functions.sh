
function verifyFreeSpace() {
  MINFREESPACE=1500000
  FREESPACE=$(df / | grep dev | awk '{print $4}')
  if [[  ${FREESPACE} -lt ${MINFREESPACE} ]]; then
    echo You have only ${FREESPACE} bytes free.  You should have ${MINFREESPACE};
    exit 1;
  fi;
}

function verifyRootUser() {
  if [[ $EUID -ne 0 ]]; then
     echo -e "\n   This script must be run with 'sudo' (run as root). "
     exit 1
  fi
}

function installToolsForTheseScripts() {
  # Make sure we atart off with the right version of awk.
  sudo apt-get -y install git;
  sudo apt-get -y install gawk;
  sudo update-alternatives --set awk /usr/bin/gawk;

  # These scripts also need "Pygmentize" to colorize text
  # and "jq" to parse JSON
  sudo apt-get -y install python-pygments jq;

}

function Java_7_is_required_by_Nightwatch_A() {
  echo -e # -- Get PPAs for Oracle Java 7 and update APT --
  sudo add-apt-repository -y ppa:webupd8team/java;
}

function Java_7_is_required_by_Nightwatch_B() {
  echo -e # -- Install Oracle Java 7 --
  echo -debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  sudo apt-get -y install oracle-java7-installer
}

function Install_other_tools() {
  sudo apt-get install -y build-essential libssl-dev  # for selenium webdriver
  sudo apt-get install -y libappindicator1            # for chrome
  sudo apt-get install -y curl                        # for Meteor
  sudo apt-get install -y git ssh                     # for version control
  sudo apt-get install -y tree  python-pip            # for demo convenience
}

function Install_NodeJS() {
  pushd /tmp >/dev/null;
  # This script calls apt-get update
  curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
  sudo apt-get install -y nodejs
  sudo apt-get -y autoremove
  popd >/dev/null;
}

function Install_Selenium_Webdriver_In_NodeJS() {

  mkdir -p ~/.npm
  mkdir -p ~/node_modules
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/node_modules
  npm install -y --prefix $HOME selenium-webdriver

}

function Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome() {
  pushd /tmp  >/dev/null;

  # Install 'chromedriver'
  export CHROMEDRIVER_VERSION=$(wget -N -qO - http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
  echo -e "Will install Chrome Driver version : ${CHROMEDRIVER_VERSION} for a ${CPU_WIDTH} width CPU";
  DRV_FILE="chromedriver_linux${CPU_WIDTH}.zip"  
  wget -N -O ${DRV_FILE} http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/${DRV_FILE};
  sudo unzip -o ${DRV_FILE} -d /usr/local/bin
  sudo chmod a+rx /usr/local/bin/chromedriver

  ARCH_NAME="amd64";
  if [[ ${CPU_WIDTH} -ne 64  ]]; then ARCH_NAME="i386"; fi;
  DEB_FILE="google-chrome-stable_current_${ARCH_NAME}.deb";
  # Install 'chrome'
  wget -N -O ${DEB_FILE} https://dl.google.com/linux/direct/${DEB_FILE}
  sudo dpkg -i ${DEB_FILE}

  popd  >/dev/null;

}

function Install_Bunyan_Globally() {

  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
  sudo npm install -y --global --prefix /usr bunyan

  LOG_DIR="/var/log/meteor"
  sudo mkdir -p ${LOG_DIR}
  sudo chown ${SUDOUSER}:${SUDOUSER} ${LOG_DIR}
  sudo chmod ug+rwx ${LOG_DIR}

}

function This_tutorial_expects_to_use_the_Sublime_Text_3_editor_A() {
  echo -e # -- Get PPAs for Sublime Text editor --
  sudo add-apt-repository -y ppa:webupd8team/sublime-text-3;
}

function This_tutorial_expects_to_use_the_Sublime_Text_3_editor_B() {
  echo -e # -- Install Sublime Text editor --
  sudo apt-get install -y sublime-text-installer
  echo -e # -- Install HTML parser for obtaining installer for ST3 Package Control --
  pip install beautifulsoup4 requests
}

function Install_eslint() {
  npm install -y eslint
  npm install -y eslint-plugin-react
  npm install -y babel-eslint
}

function Install_jsdoc() {
  npm install -y jsdoc;
}

function Configure_Sublime_A() {
  export ST3URL="https://packagecontrol.io/installation#st3";
  echo "If there is no networking error, then the following text will be the snippet obtained from  : ${ST3URL}";
  python -c "import requests;from bs4 import BeautifulSoup;print '>>>\n';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
}

function EnforceOwnershipAndPermissions() {
  export BIN_DIR=/usr/local/bin
  chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
  mkdir -p ${BIN_DIR}
  sudo touch ${BIN_DIR}/meteor
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ${BIN_DIR}
  sudo chmod -R a+w ${BIN_DIR}
}

