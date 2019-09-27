#!/bin/bash
# blur.sh -i IN_FOLDER -o OUT_FOLDER 
convert img1.jpeg img2.jpeg -morph 10 \
	-layers TrimBounds -set dispose previous -coalesce \
	-background black -alpha remove \
	-set delay '%[fx:(t>0&&t<n-1)?10:60]' \
	-duplicate 1,-2-1  -loop 0  morph_resizes.gif



