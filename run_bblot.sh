#!/bin/bash

# 获取当前小时
current_hour=$(date +%H)
echo $current_hour
chmod +x ./singtools

# download all_node.db.gz from google drive
./singtools drive download -o all_node.db.gz -c cred.json
./singtools bblot -d all_node.db.gz -c config.yml
./singtools drive update -c cred.json -l all_node.db.gz -n all_node.db.gz

rm -rf all_node.db.gz
rm cred.json
git config --local user.name "GitHub Actions"
git config --local user.email "actions@github.com"
git add .
git commit -m "Update at $(date +'%Y-%m-%d %H:%M:%S')"
git push origin main

