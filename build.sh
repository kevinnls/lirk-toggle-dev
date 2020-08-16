#!/usr/bin/env bash

# badges
good="   \e[1;32m+\e[0m"
bad="   \e[1;31m-\e[0m"
# checks
srcd="./src"
buildd="./mbuild"
gitd="${build}/.git"
modulefiles=(
    "package.json"
    "README.md"
    "${srcd}/LirkToggle.js"
    "${srcd}/LirkToggle.css"
)


yn_eval(){
case $y_n in
    y)
        ;;
    n)
        exit 1
        ;;
esac
}

clear
echo -e "\e[1;33mstarting custom build script\e[0m"
echo -e "\e[32mrunning checks...\e[0m"

fails=0

if [ ! -f "./package.json" ]; then
    echo -e "$bad \e[31mpackage.json\e[0m"
    fails=$((++fails))
else 
    echo -e "$good \e[32mpackage.json\e[0m"
fi

if [ ! -d "$srcd" ]; then
    echo -e "$bad \e[31msrc dir\e[0m"
    fails=$((++fails))
else 
    echo -e "$good \e[32msrc dir\e[0m"
fi

if [ ! -d "$buildd" ]; then
    mkdir "$buildd" -p
    echo -e "$good \e[32mbuild dir\e[0m"
else
    echo -e "$good \e[32mbuild dir\e[0m"
fi

if [ ! -d "${buildd}/.git" ]; then
    git init $buildd > /dev/null
    echo -e "    $good \e[32mis a git repo\e[0m"
else
    echo -e "    $good \e[32mis a git repo\e[0m"
fi

(cd "${buildd}";
if [ -n $(git remote) ]; then
    git remote get-url "$(git remote)"
fi
) | read giturl
echo $giturl
if [ $fails -ne 0 ]; then
    echo -e "\e[31msome checks have failed. build cannot complete\e[0m"
    exit 1
fi
    
#echo -e "\e[1;34mthis is to remind you to run tests\e[0m"
#echo -e "if you haven't run them, you should do that now"
#read -p "proceed with build? [y/n] " y_n

#for f in "$modulefiles"; 
#do if [ ! -f "$srcdir/$f"]; 
