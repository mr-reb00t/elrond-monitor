#! /bin/bash

#  WHAT IS THIS:
#  - this script creates a RRD database pre-populated with data sources where we will record Elrond API information for one or more Elrond nodes
#  - since this information is sourced from the Elrond API, this offers a global view of our node's contribution to the Elrond Network
#  - the script takes a single argument, which is the full system path of the RRD database
#
#  SCRIPT DEPENDENCIES: rrdtool    <- Install package before running this script
#
#  EXAMPLE: ./create_rrd_db.sh /home/user/database_api.rrd

# Example of a Round-Robin DB meant to store data for a single node
# rrdtool create $1 \
# --step 300 \
# DS:N0_TEMPRATING:GAUGE:600:0:U \
# DS:N0_LDR_SUCCESS:GAUGE:600:0:U \
# DS:N0_LDR_FAIL:GAUGE:600:0:U \
# DS:N0_VALID_SUCCESS:GAUGE:600:0:U \
# DS:N0_VALID_FAIL:GAUGE:600:0:U \
# DS:N0_VALID_IGNR_SIGN:GAUGE:600:0:U \
# DS:N0_TOTAL_LDR_SUCC:GAUGE:600:0:U \
# DS:N0_TOTAL_LDR_FAIL:GAUGE:600:0:U \
# DS:N0_TOTAL_VALID_SUCC:GAUGE:600:0:U \
# DS:N0_TTL_VALID_FAIL:GAUGE:600:0:U \
# DS:N0_TTL_VLD_IGN_SIGN:GAUGE:600:0:U \
# RRA:AVERAGE:0.5:1:2880 \
# RRA:AVERAGE:0.5:15:2880 \
# RRA:AVERAGE:0.5:60:2880


#Example of a Round-Robin DB meant to store data for two nodes
rrdtool create $1 \
--step 300 \
DS:N1_TEMPRATING:GAUGE:600:0:U \
DS:N1_LDR_SUCCESS:GAUGE:600:0:U \
DS:N1_LDR_FAIL:GAUGE:600:0:U \
DS:N1_VALID_SUCCESS:GAUGE:600:0:U \
DS:N1_VALID_FAIL:GAUGE:600:0:U \
DS:N1_VALID_IGNR_SIGN:GAUGE:600:0:U \
DS:N1_TOTAL_LDR_SUCC:GAUGE:600:0:U \
DS:N1_TOTAL_LDR_FAIL:GAUGE:600:0:U \
DS:N1_TOTAL_VALID_SUCC:GAUGE:600:0:U \
DS:N1_TTL_VALID_FAIL:GAUGE:600:0:U \
DS:N1_TTL_VLD_IGN_SIGN:GAUGE:600:0:U \
DS:N2_TEMPRATING:GAUGE:600:0:U \
DS:N2_LDR_SUCCESS:GAUGE:600:0:U \
DS:N2_LDR_FAIL:GAUGE:600:0:U \
DS:N2_VALID_SUCCESS:GAUGE:600:0:U \
DS:N2_VALID_FAIL:GAUGE:600:0:U \
DS:N2_VALID_IGNR_SIGN:GAUGE:600:0:U \
DS:N2_TOTAL_LDR_SUCC:GAUGE:600:0:U \
DS:N2_TOTAL_LDR_FAIL:GAUGE:600:0:U \
DS:N2_TOTAL_VALID_SUCC:GAUGE:600:0:U \
DS:N2_TTL_VALID_FAIL:GAUGE:600:0:U \
DS:N2_TTL_VLD_IGN_SIGN:GAUGE:600:0:U \
RRA:AVERAGE:0.5:1:2880 \
RRA:AVERAGE:0.5:15:2880 \
RRA:AVERAGE:0.5:60:2880
