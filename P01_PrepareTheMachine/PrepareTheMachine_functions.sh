
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
     echo -e "This script must be run with 'sudo' (run as root). "
     exit 1
  fi
}

function installToolsForTheseScripts() {
  # Make sure we atart off with the right version of awk.
  apt-get -y install gawk;
  update-alternatives --set awk /usr/bin/gawk;

  # These scripts also need "Pygmentize"
  apt-get -y install python-pygments;

}

function Java_7_is_required_by_Nightwatch_A() {
  echo -e # -- Get PPAs for Oracle Java 7 and update APT --
  add-apt-repository -y ppa:webupd8team/java;
}

function Java_7_is_required_by_Nightwatch_B() {
  echo -e # -- Install Oracle Java 7 --
  echo -debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
  apt-get -y install oracle-java7-installer
}

function Install_other_tools() {
  apt-get install -y build-essential libssl-dev  # for selenium webdriver
  apt-get install -y libappindicator1            # for chrome
  apt-get install -y curl                        # for Meteor
  apt-get install -y git ssh                     # for version control
  apt-get install -y tree  python-pip            # for demo convenience
}

function Install_NodeJS() {
  pushd /tmp >/dev/null;
  # This script calls apt-get update
  curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
  apt-get install -y nodejs
  apt-get -y autoremove
  popd >/dev/null;
}

function Install_Selenium_Webdriver_In_NodeJS() {

  mkdir -p ~/.npm
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm
  npm install -y --prefix $HOME selenium-webdriver

}

function Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome() {
  pushd /tmp  >/dev/null;

  # Install 'chromedriver'
  export CHROMEDRIVER_VERSION=$(wget -qO - http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
  echo -e "Will install Chrome Driver version : ${CHROMEDRIVER_VERSION}"
  wget http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip
  unzip -o chromedriver_linux64.zip -d /usr/local/bin
  chmod a+rx /usr/local/bin/chromedriver

  # Install 'chrome'
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb

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
  add-apt-repository -y ppa:webupd8team/sublime-text-3;
}

function This_tutorial_expects_to_use_the_Sublime_Text_3_editor_B() {
  echo -e # -- Install Sublime Text editor --
  apt-get install -y sublime-text-installer
  echo -e # -- Install HTML parser for obtaining installer for ST3 Package Control --
  pip install beautifulsoup4 requests
}

function Install_eslint() {
  npm install -gy eslint
  npm install -gy eslint-plugin-react
  npm install -gy babel-eslint
}

function Install_jsdoc() {
  npm install -g jsdoc;
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
  touch ${BIN_DIR}/meteor
  chown -R ${SUDOUSER}:${SUDOUSER} ${BIN_DIR}
  chmod -R a+w ${BIN_DIR}
}

