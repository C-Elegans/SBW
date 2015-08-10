#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage ./genIcons source.svg target"
    exit 1
fi
inkscape -z -C -w 180 -h 180 -e $2@3x.png $1
inkscape -z -C -w 120 -h 120 -e $2@2x.png $1
inkscape -z -C -w 152 -h 152 -e $2-mini@2x.png $1
inkscape -z -C -w 72 -h 72 -e $2@1x.png $1
