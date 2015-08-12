#!/bin/bash

#  genImageSVG.sh
#  Small Blue World
#
#  Created by Michael Nolan on 8/12/15.
#  Copyright © 2015 Michael Nolan. All rights reserved.
if [ "$#" -ne 3 ]; then
    echo "Usage ./genIcons source.svg target.png size"
    exit 1
fi
inkscape -z -C -w $3 -h $3 -e $2 $1
git add $2