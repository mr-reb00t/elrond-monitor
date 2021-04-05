#! /bin/bash
#
#  WHAT IS THIS:
# 
#  - This script is grabbing the complete validator listing from the main Elrond API gateway and extracting information relevant for the current Node
#  - Its aim is to create a snapshot of a node's health status, as seen by the Elrond network
#  - The snapshot is saved in a Round-Robin Db (RRD), because of low footprint, (lack of) management requirements, stateless nature and risk of memory leaks
#  - The script was built to be executed every ~ 300s or more, to avoid stressing the API gateway
#  - It's also written as simple as possible, so it can be understood & troubleshot fast when required 
#
#  SCRIPT DEPENDENCIES: rrdtool    <- Install package before running this script
#
#  SCRIPT VARIABLES:
RRD_LOCATION="/home/user/database_api.rrd"
ELROND_NODE_1_BLS="<BLS_key_1>"
ELROND_NODE_2_BLS="<BLS_key_2>"

# Because CRON has limited environment variables, to avoid runtime errorrs we will import the full system PATH as well as the SHELL whenever we involve this script
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/bin
SHELL=/bin/bash


################ ELROND NODE OPERATIONAL STATS ################
#
# DESCRIPTION: Performing an API call to the Elrond API gateway and parsing the output to extract info relevant for our node(s).

ELROND_NODE_1_BLS=$(curl -sSL http://localhost:8080/node/status | jq -r .data.metrics.erd_public_key_block_sign )
ELROND_API_STATS_OUTPUT=$(curl -sSL https://api.elrond.com/validator/statistics )

N1_TEMPRATING=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".tempRating' | head -c5)
N1_LDR_SUCCESS=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".numLeaderSuccess')
N1_LDR_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".numLeaderFailure')
N1_VALID_SUCCESS="$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".numValidatorSuccess' )"
N1_VALID_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".numValidatorFailure')
N1_VALID_IGNR_SIGN=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".numValidatorIgnoredSignatures')
N1_TOTAL_LDR_SUCC=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".totalNumLeaderSuccess')
N1_TOTAL_LDR_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".totalNumLeaderFailure')
N1_TOTAL_VALID_SUCC=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".totalNumValidatorSuccess')
N1_TTL_VALID_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".totalNumValidatorFailure')
N1_TTL_VLD_IGN_SIGN=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_1_BLS'".totalNumValidatorIgnoredSignatures')

N2_TEMPRATING=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_2_BLS'".tempRating' | head -c5)
N2_LDR_SUCCESS=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_2_BLS'".numLeaderSuccess')
N2_LDR_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_2_BLS'".numLeaderFailure')
N2_VALID_SUCCESS="$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_2_BLS'".numValidatorSuccess' )"
N2_VALID_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_2_BLS'".numValidatorFailure')
N2_VALID_IGNR_SIGN=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_2_BLS'".numValidatorIgnoredSignatures')
N2_TOTAL_LDR_SUCC=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumLeaderSuccess')
N2_TOTAL_LDR_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumLeaderFailure')
N2_TOTAL_VALID_SUCC=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumValidatorSuccess')
N2_TTL_VALID_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumValidatorFailure')
N2_TTL_VLD_IGN_SIGN=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumValidatorIgnoredSignatures')

N3_TEMPRATING=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".tempRating' | head -c5)
N3_LDR_SUCCESS=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".numLeaderSuccess')
N3_LDR_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".numLeaderFailure')
N3_VALID_SUCCESS="$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".numValidatorSuccess' )"
N3_VALID_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".numValidatorFailure')
N3_VALID_IGNR_SIGN=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".numValidatorIgnoredSignatures')
N3_TOTAL_LDR_SUCC=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumLeaderSuccess')
N3_TOTAL_LDR_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumLeaderFailure')
N3_TOTAL_VALID_SUCC=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumValidatorSuccess')
N3_TTL_VALID_FAIL=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumValidatorFailure')
N3_TTL_VLD_IGN_SIGN=$(echo $ELROND_API_STATS_OUTPUT | jq '.data.statistics."'$ELROND_NODE_3_BLS'".totalNumValidatorIgnoredSignatures')

################ ROUND-ROBIN DATABASE UPDATE ################
#
# DESCRIPTION: Here we are feeding all data points collected by the script during the current run into a RRD, as a snapshot.
#
# SYNTAX EXAMPLE: rrdtool update /home/user/DATABASE.rrd [-t datasource1:datasource2] N:$VAR1:$VAR2

rrdtool update $RRD_LOCATION N:$N1_TEMPRATING:$N1_LDR_SUCCESS:$N1_LDR_FAIL:$N1_VALID_SUCCESS:$N1_VALID_FAIL:$N1_VALID_IGNR_SIGN:$N1_TOTAL_LDR_SUCC:$N1_TOTAL_LDR_FAIL:$N1_TOTAL_VALID_SUCC:$N1_TTL_VALID_FAIL:$N1_TTL_VLD_IGN_SIGN:$N2_TEMPRATING:$N2_LDR_SUCCESS:$N2_LDR_FAIL:$N2_VALID_SUCCESS:$N2_VALID_FAIL:$N2_VALID_IGNR_SIGN:$N2_TOTAL_LDR_SUCC:$N2_TOTAL_LDR_FAIL:$N2_TOTAL_VALID_SUCC:$N2_TTL_VALID_FAIL:$N2_TTL_VLD_IGN_SIGN:$N3_TEMPRATING:$N3_LDR_SUCCESS:$N3_LDR_FAIL:$N3_VALID_SUCCESS:$N3_VALID_FAIL:$N3_VALID_IGNR_SIGN:$N3_TOTAL_LDR_SUCC:$N3_TOTAL_LDR_FAIL:$N3_TOTAL_VALID_SUCC:$N3_TTL_VALID_FAIL:$N3_TTL_VLD_IGN_SIGN