#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 name slug"
    exit 1
fi

PLUGIN_NAME="$1"
PLUGIN_SLUG="$2"
PLUGIN_CLASS="${PLUGIN_NAME// /_}"
PLUGIN_OPTION="${PLUGIN_SLUG//-/_}"

PLUGIN=${PWD}/${PLUGIN_SLUG}
ASSETS=${PWD}/${PLUGIN_SLUG}/assets
INCLUDES=${PWD}/${PLUGIN_SLUG}/includes/iworks

#
# SASS
#
mkdir -p ${ASSETS}/sass/frontend/
#
# script
#
mkdir -p ${ASSETS}/scripts/frontend
mkdir -p ${ASSETS}/scripts/admin
#
# includes
#
mkdir -p ${INCLUDES}

echo "class iWorks_PLUGIN_CLASS{\n}" > ${INCLUDES}/class-${PLUGIN_CLASS}.php
echo "class iWorks_PLUGIN_CLASS_Administrator{\n}" > ${INCLUDES}/class-${PLUGIN_CLASS}-administrator.php

#
# https://github.com/iworks/_s_to_wp_theme/archive/refs/heads/master.zip
#
PLUGIN_REPO=wp-plugin-boilerplate-main

wget https://github.com/iworks/${PLUGIN_REPO}/archive/refs/heads/master.zip

unzip -o master.zip
cp -r ${PLUGIN_REPO}/* ${PLUGIN}
#
# clean up
#

mv plugin.php ${PLUGIN_SLUG}.php
rm -rf master.zip
rm -rf ${PLUGIN_REPO}
rm -rf ${PLUGIN_SLUG}.zip
rm -rf ${PLUGIN_SLUG}/bin

cd ${PLUGIN}

perl -pi -e 's/PLUGIN_SLUG/${PLUGIN_SLUG}/g' $(grep -rl PLUGIN_SLUG)
perl -pi -e 's/PLUGIN_NAME/${PLUGIN_NAME}/g' $(grep -rl PLUGIN_NAME)
perl -pi -e 's/PLUGIN_CLASS/${PLUGIN_CLASS}/g' $(grep -rl PLUGIN_CLASS)
perl -pi -e 's/PLUGIN_OPTION/${PLUGIN_OPTION}/g' $(grep -rl PLUGIN_OPTION)


