#!/bin/bash
#! /bin/bash
#
#  WHAT IS THIS:
# 
#  - This script is generating the graphs we care about, based on the values we have in our RRD
#  - It is storing the graphs in a custom folder, from where we will pick them up later and email them
#
#  SCRIPT DEPENDENCIES: rrdtool
#
#  SCRIPT VARIABLES:
RRD_LOCATION="/home/user/database_api.rrd"
GRAPHS_LOCATION="/home/user/elrond-monitor/GRAPHS"


################# Graph 22 - Rating #################

rrdtool graph $GRAPHS_LOCATION/22_temp_rating.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Temp Rating" \
--vertical-label "Rating" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_TEMPRATING=$RRD_LOCATION:N1_TEMPRATING:AVERAGE \
DEF:N2_TEMPRATING=$RRD_LOCATION:N2_TEMPRATING:AVERAGE \
DEF:N3_TEMPRATING=$RRD_LOCATION:N3_TEMPRATING:AVERAGE \
LINE3:N1_TEMPRATING#ff0000:"Node1 Rating" \
GPRINT:N1_TEMPRATING:LAST:"Current\:%8.0lf"  \
GPRINT:N1_TEMPRATING:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_TEMPRATING:MAX:"Maximum\:%8.0lf\n" \
LINE3:N2_TEMPRATING#0000ff:"Node2 Rating" \
GPRINT:N2_TEMPRATING:LAST:"Current\:%8.0lf"  \
GPRINT:N2_TEMPRATING:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N2_TEMPRATING:MAX:"Maximum\:%8.0lf\n" 



################# Graph 23 - Round Validator and Leader Successes #################

rrdtool graph $GRAPHS_LOCATION/23_round_successes.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Round Validator and Leader Successes" \
--vertical-label "Nr of Successful Contributions" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_LDR_SUCCESS=$RRD_LOCATION:N1_LDR_SUCCESS:AVERAGE \
DEF:N1_VALID_SUCCESS=$RRD_LOCATION:N1_VALID_SUCCESS:AVERAGE \
DEF:N2_LDR_SUCCESS=$RRD_LOCATION:N2_LDR_SUCCESS:AVERAGE \
DEF:N2_VALID_SUCCESS=$RRD_LOCATION:N2_VALID_SUCCESS:AVERAGE \
LINE3:N1_LDR_SUCCESS#ff0000:"Node1 Leader Success   " \
GPRINT:N1_LDR_SUCCESS:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_LDR_SUCCESS#0000ff:"Node2 Leader Success   " \
GPRINT:N2_LDR_SUCCESS:LAST:"Current\:%8.0lf\n"  \
COMMENT:" \n" \
LINE3:N1_VALID_SUCCESS#666600:"Node1 Validator Success" \
GPRINT:N1_VALID_SUCCESS:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_VALID_SUCCESS#cc33cc:"Node2 Validator Success" \
GPRINT:N2_VALID_SUCCESS:LAST:"Current\:%8.0lf\n"  



################# Graph 24 - Round Validator and Leader Failures #################

rrdtool graph $GRAPHS_LOCATION/24_round_failures.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Round Validator and Leader Failures" \
--vertical-label "Nr of Failed Contributions" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_LDR_FAIL=$RRD_LOCATION:N1_LDR_FAIL:AVERAGE \
DEF:N1_VALID_FAIL=$RRD_LOCATION:N1_VALID_FAIL:AVERAGE \
DEF:N2_LDR_FAIL=$RRD_LOCATION:N2_LDR_FAIL:AVERAGE \
DEF:N2_VALID_FAIL=$RRD_LOCATION:N2_VALID_FAIL:AVERAGE \
LINE3:N1_LDR_FAIL#ff0000:"Node1 Leader Failures   " \
GPRINT:N1_LDR_FAIL:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_LDR_FAIL#0000ff:"Node2 Leader Failures   " \
GPRINT:N2_LDR_FAIL:LAST:"Current\:%8.0lf\n"  \
COMMENT:" \n" \
LINE3:N1_VALID_FAIL#666600:"Node1 Validator Failures" \
GPRINT:N1_VALID_FAIL:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_VALID_FAIL#cc33cc:"Node2 Validator Failures" \
GPRINT:N2_VALID_FAIL:LAST:"Current\:%8.0lf\n"  



################# Graph 25 - Round Ignored Signatures #################

rrdtool graph $GRAPHS_LOCATION/25_ignored_signatures.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Round Ignored Signatures" \
--vertical-label "Nr. of Signatures" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_VALID_IGNR_SIGN=$RRD_LOCATION:N1_VALID_IGNR_SIGN:AVERAGE \
DEF:N2_VALID_IGNR_SIGN=$RRD_LOCATION:N2_VALID_IGNR_SIGN:AVERAGE \
LINE3:N1_VALID_IGNR_SIGN#ff0000:"Node1 Validator Ignored Signatures" \
GPRINT:N1_VALID_IGNR_SIGN:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_VALID_IGNR_SIGN#0000ff:"Node2 Validator Ignored Signatures" \
GPRINT:N2_VALID_IGNR_SIGN:LAST:"Current\:%8.0lf\n"  



################# Graph 26 - Total Leader Successes #################

rrdtool graph $GRAPHS_LOCATION/26_total_leader_successes.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Total Leader Successes" \
--vertical-label "Nr of Successful Contributions" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_TOTAL_LDR_SUCC=$RRD_LOCATION:N1_TOTAL_LDR_SUCC:AVERAGE \
DEF:N2_TOTAL_LDR_SUCC=$RRD_LOCATION:N2_TOTAL_LDR_SUCC:AVERAGE \
LINE3:N1_TOTAL_LDR_SUCC#ff0000:"Node1 Total Leader Success" \
GPRINT:N1_TOTAL_LDR_SUCC:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_TOTAL_LDR_SUCC#0000ff:"Node2 Total Leader Success" \
GPRINT:N2_TOTAL_LDR_SUCC:LAST:"Current\:%8.0lf\n"  



################# Graph 27 - Total Validator Successes #################

rrdtool graph $GRAPHS_LOCATION/27_total_validator_successes.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Total Validator Successes" \
--vertical-label "Nr of Successful Contributions" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_TOTAL_VALID_SUCC=$RRD_LOCATION:N1_TOTAL_VALID_SUCC:AVERAGE \
DEF:N2_TOTAL_VALID_SUCC=$RRD_LOCATION:N2_TOTAL_VALID_SUCC:AVERAGE \
LINE3:N1_TOTAL_VALID_SUCC#666600:"Node1 Total Validator Successes" \
GPRINT:N1_TOTAL_VALID_SUCC:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_TOTAL_VALID_SUCC#cc33cc:"Node2 Total Validator Successes" \
GPRINT:N2_TOTAL_VALID_SUCC:LAST:"Current\:%8.0lf\n"  



################# Graph 28 - Total Leader Failures #################

rrdtool graph $GRAPHS_LOCATION/28_total_leader_failures.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Total Leader Failures" \
--vertical-label "Nr of Failures" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_TOTAL_LDR_FAIL=$RRD_LOCATION:N1_TOTAL_LDR_FAIL:AVERAGE \
DEF:N2_TOTAL_LDR_FAIL=$RRD_LOCATION:N2_TOTAL_LDR_FAIL:AVERAGE \
LINE3:N1_TOTAL_LDR_FAIL#ff0000:"Node1 Total Leader Failures" \
GPRINT:N1_TOTAL_LDR_FAIL:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_TOTAL_LDR_FAIL#0000ff:"Node2 Total Leader Failures" \
GPRINT:N2_TOTAL_LDR_FAIL:LAST:"Current\:%8.0lf\n"  



################# Graph 29 - Total Validator Failures #################

rrdtool graph $GRAPHS_LOCATION/29_total_validator_failures.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Total Validator Failures" \
--vertical-label "Nr of Failures" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_TTL_VALID_FAIL=$RRD_LOCATION:N1_TTL_VALID_FAIL:AVERAGE \
DEF:N2_TTL_VALID_FAIL=$RRD_LOCATION:N2_TTL_VALID_FAIL:AVERAGE \
LINE3:N1_TTL_VALID_FAIL#666600:"Node1 Total Validator Failures" \
GPRINT:N1_TTL_VALID_FAIL:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_TTL_VALID_FAIL#cc33cc:"Node2 Total Validator Failures" \
GPRINT:N2_TTL_VALID_FAIL:LAST:"Current\:%8.0lf\n"  



################# Graph 30 - Total Validator Ignored Signatures #################

rrdtool graph $GRAPHS_LOCATION/30_total_valid_ignored_signatures.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Total Validator Ignored Signatures" \
--vertical-label "Nr of Signatures" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N1_TTL_VLD_IGN_SIGN=$RRD_LOCATION:N1_TTL_VLD_IGN_SIGN:AVERAGE \
DEF:N2_TTL_VLD_IGN_SIGN=$RRD_LOCATION:N2_TTL_VLD_IGN_SIGN:AVERAGE \
LINE3:N1_TTL_VLD_IGN_SIGN#666600:"Node1 Total Validator Ignored Signatures" \
GPRINT:N1_TTL_VLD_IGN_SIGN:LAST:"Current\:%8.0lf\n"  \
LINE3:N2_TTL_VLD_IGN_SIGN#cc33cc:"Node2 Total Validator Ignored Signatures" \
GPRINT:N2_TTL_VLD_IGN_SIGN:LAST:"Current\:%8.0lf\n"  