#!/bin/bash
#

export IMAGE_NAME="paimpozhil/docker-x2go-xubuntu";
export CONTAINER_NAME="the_x2go_xub";
export CONTAINER_PORT=2222;
export PWRD="nosecret";  #  a diposable password for tutorial only
#

##
if true; then
  echo -e "
           Installing sshpass to simplify these steps
           ==========================================
    ";
  sudo apt-get install sshpass;

  echo -e "
           Obtaining Xubuntu with X2Go
           ===========================
    ";
  export ALREADY_PULLED=$(docker images | grep -c ${IMAGE_NAME});
  if [[ ${ALREADY_PULLED} -lt 1 ]]; then
    echo "pulling";
    docker pull ${IMAGE_NAME};
  fi;
  #
fi;
  echo -e "
           Starting Xubuntu with X2Go on port 2222
           ===========================================
    ";
  export ALREADY_RUNNING=$( docker ps -a | grep -c ${CONTAINER_NAME});
  if [[ ${ALREADY_RUNNING} -lt 1 ]]; then
    echo "running";
    docker run --name ${CONTAINER_NAME} -p ${CONTAINER_PORT}:22 -t -d ${IMAGE_NAME};
  fi;
  #
  echo -e "
           Viewing container (${CONTAINER_NAME}) startup report
           ===============================================
    ";

  sleep 2;
#fi;
#
docker logs ${CONTAINER_NAME} > stdout.log 2>stderr.log;
export SSHPASS=$(cat stdout.log  | grep "root password" | cut -d "'" -f2);
docker ps -a;

ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R [localhost]:${CONTAINER_PORT};

echo -e "
   The next step prepares a user for you inside the virtual machine.
   Use the password . . . 
        ${SSHPASS}
   . . . when prompted. 
   ";
#
sshpass -e ssh -o StrictHostKeyChecking=no -p 2222 root@localhost pwd
#
export LOC_LANG=$(locale | grep LANG= | cut -d "=" -f2);
export LOC_LNGE=$(locale | grep LANGUAGE= | cut -d "=" -f2 | cut -d ":" -f1);


echo -e "
  Creating VM preparation scripts
  ===============================
";
cat << EOF_LCL > locale-tweak.sh
export LANG=${LOC_LANG};
export LANGUAGE=${LOC_LNGE};
export LC_CTYPE=${LOC_LANG};
export LC_NUMERIC=${LOC_LANG};
export LC_TIME=${LOC_LANG};
export LC_COLLATE=${LOC_LANG};
export LC_MONETARY=${LOC_LANG};
export LC_MESSAGES=${LOC_LANG};
export LC_PAPER=${LOC_LANG};
export LC_NAME=${LOC_LANG};
export LC_ADDRESS=${LOC_LANG};
export LC_TELEPHONE=${LOC_LANG};
export LC_MEASUREMENT=${LOC_LANG};
export LC_IDENTIFICATION=${LOC_LANG};
export LC_ALL=;
EOF_LCL
#


cat << EOF_PRP > preparevm.sh
  #!/bin/bash
  #
  echo -e "
           Fixing locales from host setting
           ================================
    ";
  locale-gen ${LOC_LNGE} ${LOC_LANG};
  dpkg-reconfigure locales;
  echo -e "export LANG=${LOC_LANG};\nexport LANGUAGE=${LOC_LNGE}" >> /etc/environment
  #
  echo -e "
           Updating and upgrading VM
           =========================
    ";
  apt-get -y update;
  apt-get -y upgrade;
  apt-get -y dist-upgrade;
  apt-get -y clean;
  apt-get -y autoremove;
  #
  echo -e "
           Installing required tools
           =========================
    ";
  apt-get install -y nano;
  apt-get install -y lshw;
  apt-get install -y gettext;
  apt-get install -y gedit;
  apt-get install -y gnome-terminal;
  apt-get -y clean;
  apt-get -y autoremove;
  #
  echo -e "
           Creating our user account
           =========================
    ";
  adduser --disabled-password --gecos "" ${USER};
  echo    "${USER}  ALL=(ALL:ALL) ALL" | sudo tee --append /etc/sudoers
  echo "${USER}:${PWRD}" | sudo chpasswd;
  mkdir -p /home/${USER}/.ssh;
  chown -R ${USER}:${USER} /home/${USER}/.ssh;
  #
EOF_PRP
echo -e "
  Created VM preparation script
  ==============================
";


echo -e "
         Pushing preparatory scripts to VM
         ================================
  ";
chmod u+x preparevm.sh;
sshpass -e scp -P ${CONTAINER_PORT} preparevm.sh root@localhost:/tmp;
sshpass -e scp -P ${CONTAINER_PORT} locale-tweak.sh root@localhost:/etc/profile.d/;

#
echo -e "
         Executing preparatory script
         ============================
  ";
sshpass -e ssh -p ${CONTAINER_PORT} root@localhost /tmp/preparevm.sh;
echo -e "
         Pushing public key to VM
         ========================
  ";
sshpass -e scp -P ${CONTAINER_PORT} ${HOME}/.ssh/id_rsa.pub root@localhost:/home/${USER}/.ssh/authorized_keys;
sshpass -e ssh -p ${CONTAINER_PORT} root@localhost chown -R ${USER}:${USER} /home/${USER}/.ssh/authorized_keys;
echo -e "
         Making SSH PKI connection to VM as ${USER}
         ==========================================
  ";
ssh -p ${CONTAINER_PORT} ${USER}@localhost;


echo -e "
         Ready to use as '${USER}' with password '${SSHPASS}'
         ============
  ";


