#!/bin/bash
ps=lines-add-cmp.ps
R=-73/-69/-21.5/-18.5
J=M16c
grd=output.grd
gmt set MAP_FRAME_WIDTH 2p
gmt set MAP_FRAME_PEN 0.5p
gmt set FONT_ANNOT_PRIMARY 8p
gmt set FONT_LABEL 8p
gmt set MAP_TICK_LENGTH 0.1c
gmt set PS_PAGE_ORIENTATION landscape
gmt set PS_SCALE_X 1.5
gmt set PS_SCALE_Y 1.5

# image the bathymetry
#gmt grdcut /Volumes/Materials/GEBCO_2019/GEBCO_2019.nc -R$R -G$grd
gmt grdimage $grd -R$R -J$J -Ba1f1 -BNWes -Cglobe -I -Xf1.5c -Yf0.5c -K  > $ps



#ignore the cmp num of MC04
awk '{print $2,$3}' MGL1610MC04_geometry_grd_rot_crooked.axon_MC04cmp_xy_m.txt.latlong > 04_output.latlong 
# prepare the annotation of MC04
awk 'NR%2000==1{print $2,$3,$1}' MGL1610MC04_geometry_grd_rot_crooked.axon_MC04cmp_xy_m.txt.latlong > 04_cdp_annotation_2000_list.txt
# prepare the dots of MC04
awk 'NR%2000==1{print $2,$3}' MGL1610MC04_geometry_grd_rot_crooked.axon_MC04cmp_xy_m.txt.latlong > 04_cdp_coord_2000_list.txt

#########04###############
#plot all the cmp latlong
gmt psxy 04_output.latlong -R -J -W0.02c,black -O -K >> $ps
#write MC04
echo -71.76445467 -19.6015545 MC04 | gmt pstext -J -R -Ba2f1 -D-0.4/0.1 -F+f10p,red=~0.5p,red -K -O >> $ps #the first line of output.latlong
gmt pstext 04_cdp_annotation_2000_list.txt -R -J -F+a-6+f7p,Helvetica -D0.5c/0c -O -K >> $ps
gmt psxy 04_cdp_coord_2000_list.txt -R -J -W0.05c,red -Sc-0.05c -O -K >> $ps
