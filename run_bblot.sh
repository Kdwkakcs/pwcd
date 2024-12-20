#!/bin/bash

# 获取当前小时
current_hour=$(date +%H)
echo $current_hour
chmod +x ./singtools
# 判断是否在0-1点之间
if [ "$current_hour" = "03" ]; then
    # 0-1点之间运行时添加-g参数
    ./singtools bblot -d all_node.db.gz -c config.yml -g
    
    git config --local user.name "GitHub Actions"
    git config --local user.email "actions@github.com"
    git add .
    
    # 清除所有历史提交
    git checkout --orphan latest_branch
    git add -A
    git commit -m "Update at $(date +'%Y-%m-%d %H:%M:%S')"
    git branch -D main
    git branch -m main
    git push -f origin main
else
    # 其他时间正常运行
    ./singtools bblot -d all_node.db.gz -c config.yml
    
    git config --local user.name "GitHub Actions"
    git config --local user.email "actions@github.com"
    git add .
    git commit -m "Update at $(date +'%Y-%m-%d %H:%M:%S')"
    git push origin main
fi
