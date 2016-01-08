
function verifyRootUser() {
  if [[ $EUID -ne 0 ]]; then
     echo -e "\n   This script must be run with 'sudo' (run as root). ";
     exit 1;
  fi;
}


function installToolsForTheseScripts() {

  INST=();

  pushd ${HOME} >/dev/null;
    sudo apt-get -y update;
  popd >/dev/null;

  X="gawk"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="git"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="python-pygments"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="gettext"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;
  X="jq"; if aptNotYetInstalled "${X}"; then INST=("${INST[@]}" "${X}"); else echo "${X} is installed"; fi;

  echo "${#INST[@]} packages not installed.";
  if [[ ${#INST[@]} -lt 1 ]]; then return 0; fi;

  printf  "
          The first step requires installing some missing tools that
        make these explanations more readable.  These are :  ";
  echo "";
  for var in "${INST[@]}";
  do
    echo "          - ${var}";
  done;
  echo "";

  read -p "  'q' or <enter> ::  " -n 1 -r USER_ANSWER;


  CHOICE=$(echo ${USER_ANSWER:0:1} | tr '[:upper:]' '[:lower:]');
  RUN_RULE=${CHOICE};
  if [ "X${CHOICE}X" == "XqX" ]; then echo ""; exit 0; fi;

  # Make sure we atart off with the right version of awk.
  X="git"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  if aptNotYetInstalled gawk; then
    sudo apt-get -y install gawk;
    sudo update-alternatives --set awk /usr/bin/gawk;
  fi;

  # These scripts also need "Pygmentize" to colorize text
  # and "jq" to parse JSON
  X="python-pygments"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="jq"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

}


function Ready_for_Android_Studio() {

  NOTREADY=false;

  X="lib32ncurses5"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="lib32ncurses5-dev"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="lib32stdc++6"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="lib32z1"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  echo -e "\nChecking GUI type is KDE or gnome . . .";
  GUI=$(ps -A | grep -v "kdev" | egrep "gnome|kde");
  set +e;
  KDE=$(echo "${GUI}" | egrep -c "kde");
  GNOME=$(echo "${GUI}" | egrep -c "gnome");
  GUICNT=$(echo "${GUI}" | egrep -c "gnome|kde");
  set -e;
  if [[ ${GUICNT} -lt 1 ]]; then
    echo "

          * * * WARNING * * *

    You don't seem to be running KDE or GNOME as needed for Android Studio.
    See the 'Android Studio' System Requirements :
       http://developer.android.com/sdk/index.html#Requirements
    ";
    NOTREADY=true;
  else

    if [[ ${GNOME} -gt 1 ]]; then echo "It's GNOME."; fi;
    if [[ ${KDE} -gt 1 ]]; then echo "It's KDE. "; fi;

  fi;

  echo -e "\nChecking screen resolution > 1280 . . .";
  XDIMS=$(xdpyinfo  | grep dimensions | sed "s/^\s*.*:\s*//" | sed "s/\s.*//");
  XWIDTH=$(echo ${XDIMS} | sed "s/x.*//");
  if [[ ${XWIDTH} -lt 1280 ]]; then
    echo "

          * * * WARNING * * *

    You don't seem to have enough screen resolution '${XDIMS}'' for Android Studio.
    See the 'Android Studio' System Requirements :
       http://developer.android.com/sdk/index.html#Requirements
    ";
    NOTREADY=true;
  else
    echo "It's ${XDIMS}";
  fi;

  echo -e "\nChecking gclib version > 2.15 . . .";
  GCLIBVER=$(ldd --version | egrep ldd);
  GCLIBVER=${GCLIBVER##*\) };
  #   (Ubuntu EGLIBC 2.19-0ubuntu6.6) 2.19
  if [[ "${GCLIBVER}" < "2.15" ]]; then
    echo "

          * * * WARNING * * *

    It seems you are using an old (${GCLIBVER}) version of gclib
    See the 'Android Studio' System Requirements :
       http://developer.android.com/sdk/index.html#Requirements
    ";
    NOTREADY=true;
  else
    echo "It's ${GCLIBVER}";
  fi;

  if ${NOTREADY}; then echo "Please revise your installation.  Quitting . . . "; exit 1; fi;
}

function Java_7_is_required_by_Nightwatch_A() {

  echo -e "# -- Get PPAs for Oracle Java 7 and update APT --";
  PPA="webupd8team/java";
  if aptNotYetInSources ${PPA}; then
    echo "go";
    sudo add-apt-repository -y ppa:${PPA};
    pushd /tmp  >/dev/null; sudo apt-get update; popd >/dev/null;
  else
    echo "Found '${PPA}' among apt sources already.";
  fi;

}


function Java_7_is_required_by_Nightwatch_B() {

  echo -e # -- Install Oracle Java 7 --
  if ! java -version; then
    echo "java is not installed.";
	  echo -debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections;
	  echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections;
	  sudo apt-get -y install oracle-java7-installer;
  fi;

}

function Install_other_tools() {

  X="build-essential";             # for selenium webdriver
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="libssl-dev";                  # for selenium webdriver
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="libappindicator1";            # for chrome
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="curl";                        # for Meteor
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="ssh";                         # for version control
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="tree";                        # for demo convenience
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="expect";                        # for demo convenience
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;

  X="python-pip";                  # for demo convenience
  if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  fi;


}

function Install_NodeJS() {

  # for Nightwatch testing
  if aptNotYetInstalled "nodejs"; then
    pushd /tmp >/dev/null;
      # This script calls apt-get update
      curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
      sudo apt-get -y install "nodejs";
      sudo apt-get -y autoremove
    popd >/dev/null;
  fi;

}

function Install_Selenium_Webdriver_In_NodeJS() {

  mkdir -p ~/.npm;
  mkdir -p ~/node_modules;
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm;
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ~/node_modules;

  X="selenium-webdriver";
  WHERE="--prefix $HOME";
  if ! npmNotYetInstalled ${X} "${WHERE}"; then
    npm install -y ${WHERE} ${X};
    else
    echo "Node package '${X}' is already installed.";
  fi;

  rm -fr ~/etc;

}

function Install_Google_Chrome_and_the_Selenium_Web_Driver_for_Chrome() {
  pushd /tmp  >/dev/null;

    X="/usr/local/bin/chromedriver";
    if [[ -x ${X} ]];
    then
        echo "Chromedriver is already installed."
    else

      # Install 'chromedriver'
      export CHROMEDRIVER_VERSION=$(wget -N -qO - http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
      echo -e "Will install Chrome Driver version : ${CHROMEDRIVER_VERSION} for a ${CPU_WIDTH}-bit width CPU";
      DRV_FILE="chromedriver_linux${CPU_WIDTH}.zip";
      wget -O ${DRV_FILE} http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/${DRV_FILE};
      sudo unzip -o ${DRV_FILE} -d /usr/local/bin;
      sudo chmod a+rx ${X};

    fi;

    X="google-chrome-stable";            # Google Chrome browser
    if aptNotYetInstalled "${X}"; then

      ARCH_NAME="amd64";
      if [[ ${CPU_WIDTH} -ne 64  ]]; then ARCH_NAME="i386"; fi;
      DEB_FILE="google-chrome-stable_current_${ARCH_NAME}.deb";
      # Install 'chrome'
      wget -O ${DEB_FILE} https://dl.google.com/linux/direct/${DEB_FILE};
      sudo dpkg -i ${DEB_FILE};
    else
        echo "${X} is already installed.";
    fi;

  popd  >/dev/null;

}



function Install_Bunyan_Globally() {

  NPM_DIR="${HOME}/.npm";
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ${NPM_DIR};

  X="bunyan";
  WHERE=" --global --prefix /usr";
  if ! npmNotYetInstalled "${X}" "${WHERE}"; then

    pushd ${HOME}  >/dev/null;

      sudo npm install -y ${WHERE} ${X};

    popd  >/dev/null;

  else
    echo "Node package '${X}' is already installed.";
  fi;

  export LOG_DIR="/var/log/meteor";
  sudo mkdir -p ${LOG_DIR};
  sudo chown -R ${USER}:${USER} ${LOG_DIR};
  sudo chmod -R ug+rwx ${LOG_DIR};
  touch ${LOG_DIR}/ci4meteor.log;

}


function This_tutorial_expects_to_use_the_Sublime_Text_3_editor_A() {

  echo -e # -- Get PPAs for Sublime Text editor --
  PPA="webupd8team/sublime-text-3";
  if aptNotYetInSources ${PPA}; then
    echo "go";
    sudo add-apt-repository -y ppa:${PPA};
    pushd /tmp  >/dev/null; sudo apt-get update; popd >/dev/null;
  else
    echo "Found '${PPA}' among apt sources already.";
  fi;

}

function This_tutorial_expects_to_use_the_Sublime_Text_3_editor_B() {

  echo -e # -- Install Sublime Text editor  --
  X="sublime-text-installer"; if aptNotYetInstalled "${X}"; then
    sudo apt-get -y install "${X}";
  else
    echo "${X} is already installed";
  fi;

  echo -e # -- Install HTML parser for obtaining installer for ST3 Package Control --
  X="beautifulsoup4";
  if python -c "from bs4 import BeautifulSoup" 2>/dev/null; then
    echo "${X} is already installed";
  else
    sudo pip install "${X}";
  fi;

  echo -e # -- Install HTML requester for obtaining installer for ST3 Package Control  --
  X="requests"; if python -c "import ${X}[security]" 2>/dev/null; then
    echo "${X} is already installed";
  else
    sudo pip install "${X}";
  fi;

}

function Install_eslint() {

  WHERE=" --global --prefix /usr";
  pushd ${HOME}  >/dev/null;

    X="eslint";
    if ! npmNotYetInstalled "${X}" "${WHERE}"; then
      sudo npm install -y ${WHERE} ${X};
    else
      echo "Node package '${X}' is already installed.";
    fi;

    X="eslint-plugin-react";
    if ! npmNotYetInstalled "${X}" "${WHERE}"; then
      sudo npm install -y ${WHERE} ${X};
    else
      echo "Node package '${X}' is already installed.";
    fi;

    X="babel-eslint";
    if ! npmNotYetInstalled "${X}" "${WHERE}"; then
      sudo npm install -y ${WHERE} ${X};
    else
      echo "Node package '${X}' is already installed.";
    fi;

  popd  >/dev/null;

}

function Install_jsdoc() {

  WHERE=" --global --prefix /usr";
  pushd ${HOME}  >/dev/null;

    X="jsdoc";
    if ! npmNotYetInstalled "${X}" "${WHERE}"; then
      sudo npm install -y ${WHERE} ${X};
    else
      echo "Node package '${X}' is already installed.";
    fi;

  popd  >/dev/null;

}

function Configure_Sublime_A() {
  export ST3URL="https://packagecontrol.io/installation#st3";
  echo "If there is no networking error, then the following text will be the snippet obtained from  : ${ST3URL}";
  python -c "import requests;from bs4 import BeautifulSoup;print '>>>\n';print BeautifulSoup(requests.get('${ST3URL}').content, 'html.parser').findAll('p', class_='code st3')[0].code.contents[0].lstrip();print '<<<';"
}

function EnforceOwnershipAndPermissions() {

  export BIN_DIR=/usr/local/bin;
  mkdir -p ~/.npm;
  chown -R ${SUDOUSER}:${SUDOUSER} ~/.npm;
  mkdir -p ${BIN_DIR};
  sudo touch ${BIN_DIR}/meteor;
  sudo chown -R ${SUDOUSER}:${SUDOUSER} ${BIN_DIR};
  sudo chmod -R a+w ${BIN_DIR};
  sudo rm -fr /tmp/circleci_artifacts.json;
  sudo rm -fr /tmp/circleci_dk_spec.json;
  sudo rm -fr /tmp/build;
  sudo rm -fr /tmp/plugins.txt;
  sudo rm -fr /tmp/*_docs.zip;
  sudo rm -fr /tmp/meteor*;
  sudo rm -fr /tmp/git;
  sudo rm -fr /tmp/adb*;
  sudo rm -fr /tmp/chromedriver*;
  sudo rm -fr /tmp/google-chrome*;

}

