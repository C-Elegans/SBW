#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage ./genIcons source.svg target"
    exit 1
fi
rm $2*.png
inkscape -z -C -w 180 -h 180 -e $2@3x.png $1
inkscape -z -C -w 120 -h 120 -e $2@2x.png $1
inkscape -z -C -w 152 -h 152 -e $2-mini@2x.png $1
inkscape -z -C -w 76 -h 76 -e $2@1x.png $1
inkscape -z -C -w 1024 -h 1024 -e $2-StoreIcon.png $1
inkscape -z -C -w 120 -h 120 -e $2-Spotlight@3x.png $1
inkscape -z -C -w 80 -h 80 -e $2-Spotlight@2x.png $1
inkscape -z -C -w 40 -h 40 -e $2-Spotlight@1x.png $1
inkscape -z -C -w 87 -h 87 -e $2-Settings@3x.png $1
inkscape -z -C -w 58 -h 58 -e $2-Settings@2x.png $1
inkscape -z -C -w 29 -h 29 -e $2-Settings@1x.png $1