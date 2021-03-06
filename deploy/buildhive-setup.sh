#!/bin/bash

#
# Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
#
# Version: 1.0
# Author: TCSASSEMBLER
#

curl -s -o use-node https://repository-cloudbees.forge.cloudbees.com/distributions/ci-addons/node/use-node
NODE_VERSION=0.10.21 . ./use-node
npm install

# setup Heroku credentials
cp deploy/netrc ~/.netrc
chmod 0600 ~/.netrc

# setup SSH credentials to upload to heroku
cp deploy/id_rsa* ~/.ssh/
chmod 0600 ~/.ssh/id_rsa

# install Heroku toolbelt
chmod +x ./deploy/*sh
./deploy/install-heroku.sh

# deploy source to Heroku
#./deploy/heroku.sh all
. deploy/ci.sh

# start the server for testing
npm start

# sleep 2m to let the service start
sleep 2m

# start the test
npm test


# run Dredd test, the test is based on dredd.md
# ./deploy/dredd.sh
