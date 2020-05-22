#!/bin/bash
# magick -delay 100 originales/*  -loop 1 -background black -gravity center -extent 1500x1500 images.gif
# magick -delay 100 originales/* -resize 1200x1200 -loop 1 -background white -gravity center -extent 1200x1200 images.gif
pdftoppm -jpeg slide.pdf slide
ffmpeg -i audio.mp3 -framerate 1/3 -pattern_type glob -i  '*.jpg'  out.avi
