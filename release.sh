#!/usr/bin/env sh  #用来表示它是一个 shell 脚本
set -e #告诉脚本如果执行结果不为 true 则退出
echo "请输入的版本号<Enter release version>:"
read VERSION  #表示从标准输入读取值，并赋值给 $VERSION 变量
read -p "你确定你的版本号为$VERSION?<Releasing are you sure is $VERSION?> (y/n)" -n 1 -r
echo  #输出空值表示跳到一个新行，# 在 shell 脚本中表示注释

#表示 shell 脚本中的流程控制语句，判断 $REPLY 是不是大小写的 y，如果满足，则走到后面的 then 逻辑
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Releasing $VERSION ..."

  git add -A  #表示把代码所有变化提交到暂存区
  git commit -m "[build] $VERSION"  #表示提交代码，提交注释是 [build] $VERSION
  npm version $VERSION --message "[release] $VERSION"
  # git remote add origin https://gitee.com/KimGuBa/kim-axios.git
  git push -u origin master #是修改 package.json 中的 version 字段到 $VERSION，并且提交一条修改记录，提交注释是 [release] $VERSION

  # publish
  npm publish
fi