#!/bin/bash

#  genImageSVG.sh
#  Small Blue World
#
#  Created by Michael Nolan on 8/12/15.
#  Copyright © 2015 Michael Nolan. All rights reserved.
if [ "$#" -eq 3 ]; then
	inkscape -z -C -w $3 -h $3 -e $2 $1
	git add $2
elif [ "$#" -eq 4 ]; then
	inkscape -z -C -w $3 -h $4 -e $2 $1
	git add $2
else
	echo "Usage ./genImageSVG source.svg target.png size"
	echo "Usage ./genImageSVG source.svg target.png width height"
	exit 1
fi
