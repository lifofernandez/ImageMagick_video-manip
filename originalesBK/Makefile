SRCS=${wildcard *.jpeg}
SIZES=$(subst .jpeg,.jpeg.size,${SRCS})
CLIPS=$(subst .jpeg,.mp4,${SRCS})
SlideDuration=1
FPS=25

all: video.mp4

video.mp4: slideshow.mp4 audio.aac
 ${SH} ffmpeg -i slideshow.mp4 -i l.mp3 -shortest -strict -2 $@


slideshow.mp4: ${CLIPS}
 ${SH} for f in `echo $^`; do echo "file '$$f'" >> filelist.txt; done;
 ${SH} ffmpeg -y -f concat -i filelist.txt -codec copy $@
 ${RM} filelist.txt

%.mp4: %.jpeg video.size background.jpeg
 ${SH} ffmpeg -y -loop 1 -i background.jpeg -i $< -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -r $(FPS) -vframes $(shell echo $(FPS)*$(SlideDuration) | bc) -an $@

video.size: ${SIZES}
 ${SH} echo $(shell cat *.size | cut -f 1 -d 'x' | sort -un | tail -1)x$(shell cat *.size | cut -f 2 -d 'x' | sort -un | tail -1) > $@

%.jpeg.size: %.jpeg
 ${SH} mogrify -auto-orient $<
 ${SH} identify $< | cut -f 3 -d ' ' > $@

background.jpeg: video.size
 ${SH} convert -size $(shell cat $<) xc:black $@

clean: 
 ${RM} *.mp4 *.size background.jpeg *.aac
