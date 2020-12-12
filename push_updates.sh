#!/bin/bash
GH_USER=$(cat /tmp/GH_USER)
GH_REPO=$(cat /tmp/GH_REPO)

git clone https://github.com/"$GH_USER"/"$GH_REPO".git /tmp/"$GH_REPO"
if [ "$(md5sum /tmp/package_versions.txt)" = "$(md5sum /tmp/"$GH_REPO"/package_versions.txt)" ]; then
  echo "false" >/tmp/do_update
else
  echo "true" >/tmp/do_update
  cd /tmp/"$GH_REPO"/ || exit 1
  rm /tmp/"$GH_REPO"/package_versions.txt
  cp /tmp/package_versions.txt /tmp/"$GH_REPO"/package_versions.txt
  git config --global user.email "alexanderhyde@icloud.com"
  git config --global user.name "hydazz"
  git add package_versions.txt
  git commit -m 'Bot Updating Package Versions'
fi
exit 0
