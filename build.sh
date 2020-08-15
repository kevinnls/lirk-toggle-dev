#!/bin/sh

srcdir="./src"
builddir="./mbuild"
modulefiles=("LirkToggle.js","LirkToggle.css")

echo "this is to remind you to run tests"
echo "if you haven't run them, you should do that now"
read -p "proceed with build? [y/n] " y_n
case $y_n in
    y)
        break
        ;;
    n)
        exit 1
        ;;
esac

clear
echo "starting build..."
if [ ! -d "$srcdir" ]; then
    echo
    echo "there's no src dir. not sure what to do"
    echo "so exiting"
    exit 1
fi
if [ ! -d "$builddir" ]; then
    mkdir "$buildddir" -p
fi
echo checking files...
if [ ! -f "./package.json" ]; then
    echo "npm needs a package.json file"
    read -p "would you like to create one? [y/n] " y_n
        
for f in "$modulefiles"; 
do if [ ! -f "$srcdir/$f"]; 
