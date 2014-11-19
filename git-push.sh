#! /bin/bash

function writeEnvironment() {
cat << ENVIRONMENT

/****************************
 * ENVIRONMENT = PRODUCTION *
 ****************************/

// version
var util_version = "`date`"

// Server URL
var util_server_url = "http://tweetssentiment.herokuapp.com";

ENVIRONMENT
}

echo "****************************************************"
echo "* PUSH CHANGES TO GIT PAGES POINTING TO PRODUCTION *"
echo "****************************************************"

writeEnvironment > js/util/environment.js && \
more js/util/environment.js && \
node app.js && \
git diff | grep +++

read -p "You want to continue? [y|*N*]: " OPTION

if [ "$OPTION" == "y" ]; then

    read -p "Write the commit message: " MESSAGE

    git add . && \
    git commit -m "$MESSAGE" && \
    git push
fi
