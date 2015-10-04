#!/bin/bash
echo "  -- Ready to install TinyTest runner dependencies."
#
export LOCAL_NODEJS=${HOME}
export LOCAL_NODEJS_MODULES=${LOCAL_NODEJS}/node_modules
export LOCAL_NPM=${LOCAL_NODEJS}/.npm
mkdir -p ${LOCAL_NODEJS_MODULES}
#

MDL="selenium-webdriver"
if [ -d ${LOCAL_NODEJS_MODULES}/${MDL}/ ]; then
  echo "Node module '${MDL}' is already available.";
else
  if [ -w ~/.npm/glob/5.0.14/ ] ; then
    echo "Installing '${MDL}' in directory -- ${LOCAL_NODEJS_MODULES}.";
    npm install -y --prefix ${LOCAL_NODEJS} ${MDL};
  else
    echo "No permissions to do this."
    echo "Please get ...
       npm install -y --prefix ${LOCAL_NODEJS} ${MDL}; 
            ... to work properly.   For example try ...
       sudo chown -R ${USER}:${USER} ~/.npm"
    exit 1;
  fi;
fi;
echo "Dependencies loaded."
