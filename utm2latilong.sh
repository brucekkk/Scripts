#!/bin/csh 
#this sctipt is used for utm convert to lati/long, you should change the utm zone and the file path.
setenv LC_ALL C
setenv LC_CTYPE C
setenv LC_COLLATE C
setenv LC_TIME C
setenv LC_NUMERIC C
setenv LC_MONETARY C
setenv LANG C
#set path = ( /usr/local/bin $path ) #ONLY FOR LANDINIAN DEFAULT. SWITCH TO GMT EXCUTABLES TO VERSION 5 BIN DIRICTORY
gmt defaults -D > .gmtdefaults
gmt defaults -D > .gmtdefaults4
gmt set PROJ_LENGTH_UNIT inch
#gmtset DOTS_PR_INCH 600
gmt set PS_MEDIA a4
gmt set FORMAT_FLOAT_OUT %.12lg   # define float decimeter to high value.
gmt set PS_PAGE_ORIENTATION PORTRAIT
gmt set PS_SCALE_X 1
gmt set PS_SCALE_Y 1
gmt set FORMAT_DATE_MAP "o dd" FORMAT_CLOCK_MAP hh:mm FONT_ANNOT_PRIMARY +9
gmt set TIME_INTERVAL_FRACTION 0.01
gmt set FONT_ANNOT_PRIMARY 6
gmt set MAP_ANNOT_OFFSET_PRIMARY 0.1c
gmt set MAP_ANNOT_OFFSET_SECONDARY 0.1c
gmt set MAP_TICK_LENGTH 0.1C 
gmt set MAP_FRAME_PEN 0.7p 
gmt set FONT_LABEL 6
gmt set FONT_TITLE  8
gmt set MAP_TITLE_OFFSET 0.2c
gmt set MAP_LABEL_OFFSET 0.1c
gmt set FONT_LABEL 6
#gmtset BASEMAP_AXES WESn   ANNOT_OFFSET_PRIMARY

##############  UTM to GEOGRAPHICAL coordiante ####################################
set ZONE = 19 #change the utm zone here.
set MERIDIAN = `echo $ZONE | awk '{print int((('$ZONE'*6)-180)-3)}'`
set UTM_REGION = `echo $MERIDIAN| awk '{printf("%i/%i/%i/%i\n", $1-3,$1+3,-90,0)}' `
echo MERIDIAN $MERIDIAN 
echo UTM_REGION $UTM_REGION
echo 
set input_txt = MGL1610MC04_geometry_grd_rot_crooked.axon_MC04cmp_xy_m.txt #change your path here
awk '{if(NR>1) printf("%.12lg %.12lg %d \n",$2,$3,$1)}' $input_txt | \
gmt mapproject -V -I -Ju$ZONE/1:1 -R$UTM_REGION -C0/0 -F | \
awk '{printf("%d %.12lg %.12lg \n",$3,$1,$2)}' > MGL1610MC04_geometry_grd_rot_crooked.axon_MC04cmp_xy_m.txt.latlong
