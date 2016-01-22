#!/usr/bin/env bash

WORKING_DIRECTORY="$2"

DATABASE_HOST="localhost"
DATABASE_USER="homestead"
DATABASE_PASS="secret"

DATABASE_NAME="$4"

ADMIN_USER="$5"
ADMIN_PASS="$6"

TAO_URL="http://$1"
TAO_NS="http://$1/tao.rdf"
TAO_EXTS="$7"

[[ $8 = 5 ]] && PHP="php5" || PHP="php"

echo $WORKING_DIRECTORY

if [ ! -f "$WORKING_DIRECTORY/tao/manifest.php" ]; then
    echo "Please run me in the root of a TAO dist"
    exit 1
fi

version=`cat $WORKING_DIRECTORY/tao/includes/constants.php | grep "'TAO_VERSION'" | sed -r "s/define\('TAO_VERSION',.?'(.*)+'\);/\1/g"`

echo "I am going to install TAO ${version} with extensions: $TAO_EXTS"

$PHP $WORKING_DIRECTORY/tao/scripts/taoInstall.php \
    --db_user "${DATABASE_USER}" \
    --db_pass "${DATABASE_PASS}" \
    --db_host "${DATABASE_HOST}" \
    --db_driver pdo_mysql \
    --user_login "${ADMIN_USER}" \
    --user_pass "${ADMIN_PASS}" \
    --module_url "${TAO_URL}" \
    --db_name "${DATABASE_NAME}" \
    --module_namespace "${TAO_NS}" \
    -e "${TAO_EXTS}"

sleep 1
