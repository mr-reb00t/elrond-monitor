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
RRD_LOCATION="/home/user/database.rrd"
GRAPHS_LOCATION="/home/user/elrond-monitor/GRAPHS"


################# Graph 01 - Connected Peers #################

rrdtool graph $GRAPHS_LOCATION/01_connected_peers.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Connected Elrond Peer Nodes" \
--vertical-label "Number of peers" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_CONNECTED_PEERS=$RRD_LOCATION:N0_CONNECTED_PEERS:AVERAGE \
DEF:N1_CONNECTED_PEERS=$RRD_LOCATION:N1_CONNECTED_PEERS:AVERAGE \
LINE3:N0_CONNECTED_PEERS#ff0000:"Node0 Peers" \
GPRINT:N0_CONNECTED_PEERS:LAST:"Current\:%8.0lf"  \
GPRINT:N0_CONNECTED_PEERS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_CONNECTED_PEERS:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_CONNECTED_PEERS#0000ff:"Node1 Peers" \
GPRINT:N1_CONNECTED_PEERS:LAST:"Current\:%8.0lf"  \
GPRINT:N1_CONNECTED_PEERS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_CONNECTED_PEERS:MAX:"Maximum\:%8.0lf\n"



################# Graph 02 - Shard ID #################

rrdtool graph $GRAPHS_LOCATION/02_shard_id.png \
--imgformat PNG \
--start now-2w --end now \
--width 960 --height 300 \
--title "Elrond Node to Shard Assignation" \
--vertical-label "Shard ID" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_SHARD_ID=$RRD_LOCATION:N0_SHARD_ID:AVERAGE \
DEF:N1_SHARD_ID=$RRD_LOCATION:N1_SHARD_ID:AVERAGE \
LINE2:N0_SHARD_ID#ff0000:"Current Node0 Shard ID" \
GPRINT:N0_SHARD_ID:LAST:"%8.0lf\n"  \
LINE2:N1_SHARD_ID#0000ff:"Current Node1 Shard ID" \
GPRINT:N1_SHARD_ID:LAST:"%8.0lf\n"



################# Graph 03 - Elrond Network status seen by the Nodes on current host #################

rrdtool graph $GRAPHS_LOCATION/03_elrond_network_status.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Elrond Network status seen by the Nodes on current host" \
--vertical-label "Number of Nodes" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_ACTIVE_VALID=$RRD_LOCATION:N0_ACTIVE_VALID:AVERAGE \
DEF:N1_ACTIVE_VALID=$RRD_LOCATION:N1_ACTIVE_VALID:AVERAGE \
DEF:N0_ACTIVE_OBS=$RRD_LOCATION:N0_ACTIVE_OBS:AVERAGE \
DEF:N1_ACTIVE_OBS=$RRD_LOCATION:N1_ACTIVE_OBS:AVERAGE \
DEF:N0_ALL_NODES_SEEN=$RRD_LOCATION:N0_ALL_NODES_SEEN:AVERAGE \
DEF:N1_ALL_NODES_SEEN=$RRD_LOCATION:N1_ALL_NODES_SEEN:AVERAGE \
LINE3:N0_ACTIVE_VALID#ff0000:"Active Validators seen by Node0" \
GPRINT:N0_ACTIVE_VALID:LAST:"Current\:%8.0lf"  \
GPRINT:N0_ACTIVE_VALID:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_ACTIVE_VALID:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_ACTIVE_VALID#0000ff:"Active Validators seen by Node1" \
GPRINT:N1_ACTIVE_VALID:LAST:"Current\:%8.0lf"  \
GPRINT:N1_ACTIVE_VALID:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_ACTIVE_VALID:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:N0_ACTIVE_OBS#99cc33:"Active Observers seen by Node0 " \
GPRINT:N0_ACTIVE_OBS:LAST:"Current\:%8.0lf"  \
GPRINT:N0_ACTIVE_OBS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_ACTIVE_OBS:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_ACTIVE_OBS#003300:"Active Observers seen by Node0 " \
GPRINT:N1_ACTIVE_OBS:LAST:"Current\:%8.0lf"  \
GPRINT:N1_ACTIVE_OBS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_ACTIVE_OBS:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:N0_ALL_NODES_SEEN#0066cc:"Total Nodes seen by Node0      " \
GPRINT:N0_ALL_NODES_SEEN:LAST:"Current\:%8.0lf"  \
GPRINT:N0_ALL_NODES_SEEN:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_ALL_NODES_SEEN:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_ALL_NODES_SEEN#cc33cc:"Total Nodes seen by Node1      " \
GPRINT:N1_ALL_NODES_SEEN:LAST:"Current\:%8.0lf"  \
GPRINT:N1_ALL_NODES_SEEN:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_ALL_NODES_SEEN:MAX:"Maximum\:%8.0lf\n"



################# Graph 04 - Elrond Network participation by current Node #################

rrdtool graph $GRAPHS_LOCATION/04_elrond_network_participation.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Elrond Network participation by current Node" \
--vertical-label "Number of Times" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_CNT_CONSENSUS=$RRD_LOCATION:N0_CNT_CONSENSUS:AVERAGE \
DEF:N1_CNT_CONSENSUS=$RRD_LOCATION:N1_CNT_CONSENSUS:AVERAGE \
DEF:N0_COUNT_LEADER=$RRD_LOCATION:N0_COUNT_LEADER:AVERAGE \
DEF:N1_COUNT_LEADER=$RRD_LOCATION:N1_COUNT_LEADER:AVERAGE \
LINE3:N0_CNT_CONSENSUS#ff0000:"Nr Times part of Consensus by Node0" \
GPRINT:N0_CNT_CONSENSUS:LAST:"Current\:%8.0lf"  \
GPRINT:N0_CNT_CONSENSUS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_CNT_CONSENSUS:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_CNT_CONSENSUS#0000ff:"Nr Times part of Consensus by Node1" \
GPRINT:N1_CNT_CONSENSUS:LAST:"Current\:%8.0lf"  \
GPRINT:N1_CNT_CONSENSUS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_CNT_CONSENSUS:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:N0_COUNT_LEADER#99cc33:"Nr Times Round Leader by Node0     " \
GPRINT:N0_COUNT_LEADER:LAST:"Current\:%8.0lf"  \
GPRINT:N0_COUNT_LEADER:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_COUNT_LEADER:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_COUNT_LEADER#cc00ff:"Nr Times Round Leader by Node1     " \
GPRINT:N1_COUNT_LEADER:LAST:"Current\:%8.0lf"  \
GPRINT:N1_COUNT_LEADER:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_COUNT_LEADER:MAX:"Maximum\:%8.0lf\n"



################# Graph 05 - Processed Blocks by current Node #################

rrdtool graph $GRAPHS_LOCATION/05_processed_blocks.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Processed Blocks by current Node" \
--vertical-label "Nr of Blocks" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_CONS_ACPT_BLCKS=$RRD_LOCATION:N0_CONS_ACPT_BLCKS:AVERAGE \
DEF:N1_CONS_ACPT_BLCKS=$RRD_LOCATION:N1_CONS_ACPT_BLCKS:AVERAGE \
DEF:N0_ACCEPTED_BLOCKS=$RRD_LOCATION:N0_ACCEPTED_BLOCKS:AVERAGE \
DEF:N1_ACCEPTED_BLOCKS=$RRD_LOCATION:N1_ACCEPTED_BLOCKS:AVERAGE \
LINE3:N0_CONS_ACPT_BLCKS#ff0000:"Consensus Processed Blocks seen by Node0" \
GPRINT:N0_CONS_ACPT_BLCKS:LAST:"Current\:%8.0lf"  \
GPRINT:N0_CONS_ACPT_BLCKS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_CONS_ACPT_BLCKS:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_CONS_ACPT_BLCKS#0000ff:"Consensus Processed Blocks seen by Node1" \
GPRINT:N1_CONS_ACPT_BLCKS:LAST:"Current\:%8.0lf"  \
GPRINT:N1_CONS_ACPT_BLCKS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_CONS_ACPT_BLCKS:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:N0_ACCEPTED_BLOCKS#99cc33:"Accepted Blocks by Node0                  " \
GPRINT:N0_ACCEPTED_BLOCKS:LAST:"Current\:%8.0lf"  \
GPRINT:N0_ACCEPTED_BLOCKS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N0_ACCEPTED_BLOCKS:MAX:"Maximum\:%8.0lf\n" \
LINE3:N1_ACCEPTED_BLOCKS#cc00ff:"Accepted Blocks by Node1                  " \
GPRINT:N1_ACCEPTED_BLOCKS:LAST:"Current\:%8.0lf"  \
GPRINT:N1_ACCEPTED_BLOCKS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:N1_ACCEPTED_BLOCKS:MAX:"Maximum\:%8.0lf\n"



################# Graph 06 - Current Epoch #################

rrdtool graph $GRAPHS_LOCATION/06_current_epoch.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Current Epoch" \
--vertical-label "Epoch" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_EPOCH_NUMBER=$RRD_LOCATION:N0_EPOCH_NUMBER:AVERAGE \
DEF:N1_EPOCH_NUMBER=$RRD_LOCATION:N1_EPOCH_NUMBER:AVERAGE \
LINE3:N0_EPOCH_NUMBER#ff0000:"Current epoch seen by Node0" \
GPRINT:N0_EPOCH_NUMBER:LAST:"%8.0lf\n"  \
LINE3:N1_EPOCH_NUMBER#0000ff:"Current epoch seen by Node1" \
GPRINT:N1_EPOCH_NUMBER:LAST:"%8.0lf\n"  \



################# Graph 07 - Current Round #################

rrdtool graph $GRAPHS_LOCATION/07_current_round.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Current Round" \
--vertical-label "Round" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:N0_CURRENT_ROUND=$RRD_LOCATION:N0_CURRENT_ROUND:AVERAGE \
DEF:N1_CURRENT_ROUND=$RRD_LOCATION:N1_CURRENT_ROUND:AVERAGE \
DEF:N0_SYNCED_ROUND=$RRD_LOCATION:N0_SYNCED_ROUND:AVERAGE \
DEF:N1_SYNCED_ROUND=$RRD_LOCATION:N1_SYNCED_ROUND:AVERAGE \
LINE3:N0_CURRENT_ROUND#ff0000:"Current Round seen by Node0" \
GPRINT:N0_CURRENT_ROUND:LAST:"%8.0lf\n"  \
LINE3:N1_CURRENT_ROUND#0000ff:"Current Round seen by Node1" \
GPRINT:N1_CURRENT_ROUND:LAST:"%8.0lf\n"  \
COMMENT:" \n" \
LINE3:N0_SYNCED_ROUND#99cc33:"Synced Round seen by Node0 " \
GPRINT:N0_SYNCED_ROUND:LAST:"%8.0lf\n"  \
LINE3:N1_SYNCED_ROUND#cc00ff:"Synced Round seen by Node1 " \
GPRINT:N1_SYNCED_ROUND:LAST:"%8.0lf\n" 



################# Graph 08 - Elrond Node Process Memory Usage #################

rrdtool graph $GRAPHS_LOCATION/08_elrond_node_process_memory_usage.png \
--imgformat PNG \
--start now-2w --end now \
--width 960 --height 300 \
--title "Elrond Node Process Memory Usage" \
--vertical-label "Memory (MB)" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:PHY_MEM_USD_N0=$RRD_LOCATION:PHY_MEM_USD_N0:AVERAGE \
DEF:PHY_MEM_USD_N1=$RRD_LOCATION:PHY_MEM_USD_N1:AVERAGE \
DEF:VIRT_MEM_USD_N0=$RRD_LOCATION:VIRT_MEM_USD_N0:AVERAGE \
DEF:VIRT_MEM_USD_N1=$RRD_LOCATION:VIRT_MEM_USD_N1:AVERAGE \
LINE3:PHY_MEM_USD_N0#ff0000:"Physical Memory Used by Node0 Process" \
GPRINT:PHY_MEM_USD_N0:LAST:"Current\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_N0:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_N0:MAX:"Maximum\:%8.0lf MB\n" \
LINE3:PHY_MEM_USD_N1#0000ff:"Physical Memory Used by Node1 Process" \
GPRINT:PHY_MEM_USD_N1:LAST:"Current\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_N1:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_N1:MAX:"Maximum\:%8.0lf MB\n" \
COMMENT:" \n" \
LINE3:VIRT_MEM_USD_N0#99cc33:"Virtual Memory Used by Node0 Process " \
GPRINT:VIRT_MEM_USD_N0:LAST:"Current\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_N0:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_N0:MAX:"Maximum\:%8.0lf MB\n" \
LINE3:VIRT_MEM_USD_N1#cc00ff:"Virtual Memory Used by Node1 Process " \
GPRINT:VIRT_MEM_USD_N1:LAST:"Current\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_N1:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_N1:MAX:"Maximum\:%8.0lf MB\n"



################# Graph 09 - Arwen Process Memory Usage #################

rrdtool graph $GRAPHS_LOCATION/09_arwen_process_memory_usage.png \
--imgformat PNG \
--start now-2w --end now \
--width 960 --height 300 \
--title "Arwen Process Memory Usage" \
--vertical-label "Memory (MB)" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:PHY_MEM_USD_ARWN_0=$RRD_LOCATION:PHY_MEM_USD_ARWN_0:AVERAGE \
DEF:PHY_MEM_USD_ARWN_1=$RRD_LOCATION:PHY_MEM_USD_ARWN_1:AVERAGE \
DEF:VIRT_MEM_USD_ARWN_0=$RRD_LOCATION:VIRT_MEM_USD_ARWN_0:AVERAGE \
DEF:VIRT_MEM_USD_ARWN_1=$RRD_LOCATION:VIRT_MEM_USD_ARWN_1:AVERAGE \
LINE3:PHY_MEM_USD_ARWN_0#ff0000:"Physical Memory Used by Node0 Arwen" \
GPRINT:PHY_MEM_USD_ARWN_0:LAST:"Current\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_ARWN_0:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_ARWN_0:MAX:"Maximum\:%8.0lf MB\n" \
LINE3:PHY_MEM_USD_ARWN_1#0000ff:"Physical Memory Used by Node1 Arwen" \
GPRINT:PHY_MEM_USD_ARWN_1:LAST:"Current\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_ARWN_1:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:PHY_MEM_USD_ARWN_1:MAX:"Maximum\:%8.0lf MB\n" \
COMMENT:" \n" \
LINE3:VIRT_MEM_USD_ARWN_0#99cc33:"Virtual Memory Used by Node0 Arwen " \
GPRINT:VIRT_MEM_USD_ARWN_0:LAST:"Current\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_ARWN_0:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_ARWN_0:MAX:"Maximum\:%8.0lf MB\n" \
LINE3:VIRT_MEM_USD_ARWN_1#cc00ff:"Virtual Memory Used by Node1 Arwen " \
GPRINT:VIRT_MEM_USD_ARWN_1:LAST:"Current\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_ARWN_1:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:VIRT_MEM_USD_ARWN_1:MAX:"Maximum\:%8.0lf MB\n"



################# Graph 10 - Elrond Node DB Size #################

rrdtool graph $GRAPHS_LOCATION/10_elrond_node_db_size.png \
--imgformat PNG \
--start now-2w --end now \
--width 960 --height 300 \
--title "Elrond Node Database Size" \
--vertical-label "DB Size (MB)" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:DB_SIZE_NODE_0_MB=$RRD_LOCATION:DB_SIZE_NODE_0_MB:AVERAGE \
DEF:DB_SIZE_NODE_1_MB=$RRD_LOCATION:DB_SIZE_NODE_1_MB:AVERAGE \
LINE3:DB_SIZE_NODE_0_MB#ff0000:"DB size of Node0" \
GPRINT:DB_SIZE_NODE_0_MB:LAST:"%8.0lf MB\n"  \
LINE3:DB_SIZE_NODE_1_MB#0000ff:"DB size of Node1" \
GPRINT:DB_SIZE_NODE_1_MB:LAST:"%8.0lf MB\n"



################# Graph 11 - CPU Usage #################

rrdtool graph $GRAPHS_LOCATION/11_cpu_usage.png \
--imgformat PNG \
--start now-2w --end now \
--width 960 --height 300 \
--title "Server CPU Usage" \
--vertical-label "CPU Usage (percent)" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:CPU_USER_ALLCORES=$RRD_LOCATION:CPU_USER_ALLCORES:AVERAGE \
DEF:CPU_TOTAL_ALLCORES=$RRD_LOCATION:CPU_TOTAL_ALLCORES:AVERAGE \
LINE3:CPU_USER_ALLCORES#ff0000:"CPU Usage Elrond Apps (Node, Arwen etc.)" \
GPRINT:CPU_USER_ALLCORES:LAST:"%8.0lf %%\n"  \
LINE3:CPU_TOTAL_ALLCORES#0000ff:"CPU Usage total                         " \
GPRINT:CPU_TOTAL_ALLCORES:LAST:"%8.0lf %%\n"



################# Graph 12 - Physical Memory Usage #################

rrdtool graph $GRAPHS_LOCATION/12_physical_memory_usage.png \
--imgformat PNG \
--start now-2w --end now \
--width 960 --height 300 \
--title "Physical Memory Usage" \
--vertical-label "Used Memory (MB)" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:MEMORY_TOTAL_MB=$RRD_LOCATION:MEMORY_TOTAL_MB:AVERAGE \
DEF:MEMORY_USED_MB=$RRD_LOCATION:MEMORY_USED_MB:AVERAGE \
DEF:MEMORY_CACHED_MB=$RRD_LOCATION:MEMORY_CACHED_MB:AVERAGE \
DEF:SWAP_USED_MB=$RRD_LOCATION:SWAP_USED_MB:AVERAGE \
LINE3:MEMORY_TOTAL_MB#cccccc:"Total Memory on Host " \
GPRINT:MEMORY_TOTAL_MB:LAST:"%8.0lf MB\n"  \
COMMENT:" \n" \
LINE3:MEMORY_USED_MB#ff0000:"Used Physical Memory " \
GPRINT:MEMORY_USED_MB:LAST:"Current\:%8.0lf MB"  \
GPRINT:MEMORY_USED_MB:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:MEMORY_USED_MB:MAX:"Maximum\:%8.0lf MB\n" \
LINE3:MEMORY_CACHED_MB#33CC33:"Cached Virtual Memory" \
GPRINT:MEMORY_CACHED_MB:LAST:"Current\:%8.0lf MB"  \
GPRINT:MEMORY_CACHED_MB:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:MEMORY_CACHED_MB:MAX:"Maximum\:%8.0lf MB\n" \
LINE3:SWAP_USED_MB#0000ff:"Used Swap (on-disk)  " \
GPRINT:SWAP_USED_MB:LAST:"Current\:%8.0lf MB"  \
GPRINT:SWAP_USED_MB:AVERAGE:"Average\:%8.0lf MB"  \
GPRINT:SWAP_USED_MB:MAX:"Maximum\:%8.0lf MB\n"




################# Graph 13 - Megabits per Second #################

rrdtool graph $GRAPHS_LOCATION/13_mbps.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Traffic - Megabits per Second" \
--vertical-label "Mbps" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:EGRESS_MBPS=$RRD_LOCATION:EGRESS_MBPS:AVERAGE \
DEF:INGRESS_MBPS=$RRD_LOCATION:INGRESS_MBPS:AVERAGE \
LINE3:EGRESS_MBPS#ff0000:"Egress Mbps " \
GPRINT:EGRESS_MBPS:LAST:"Current\:%8.2lf"  \
GPRINT:EGRESS_MBPS:AVERAGE:"Average\:%8.2lf"  \
GPRINT:EGRESS_MBPS:MAX:"Maximum\:%8.2lf\n" \
LINE3:INGRESS_MBPS#33CC33:"Ingress Mbps" \
GPRINT:INGRESS_MBPS:LAST:"Current\:%8.2lf"  \
GPRINT:INGRESS_MBPS:AVERAGE:"Average\:%8.2lf"  \
GPRINT:INGRESS_MBPS:MAX:"Maximum\:%8.2lf\n"



################# Graph 14 - Packets per Second #################

rrdtool graph $GRAPHS_LOCATION/14_pps.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Traffic - Packets per Second" \
--vertical-label "PPS" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:EGRESS_PPS=$RRD_LOCATION:EGRESS_PPS:AVERAGE \
DEF:INGRESS_PPS=$RRD_LOCATION:INGRESS_PPS:AVERAGE \
LINE3:EGRESS_PPS#ff0000:"Egress PPS " \
GPRINT:EGRESS_PPS:LAST:"Current\:%8.0lf"  \
GPRINT:EGRESS_PPS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:EGRESS_PPS:MAX:"Maximum\:%8.0lf\n" \
LINE3:INGRESS_PPS#33CC33:"Ingress PPS" \
GPRINT:INGRESS_PPS:LAST:"Current\:%8.0lf"  \
GPRINT:INGRESS_PPS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:INGRESS_PPS:MAX:"Maximum\:%8.0lf\n"



################# Graph 15 - Temperature #################

rrdtool graph $GRAPHS_LOCATION/15_temperature.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "CPU and HDD Temperature" \
--vertical-label "Degrees Celsius" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:TEMP_CPUZONE_0=$RRD_LOCATION:TEMP_CPUZONE_0:AVERAGE \
DEF:TEMP_CPUZONE_1=$RRD_LOCATION:TEMP_CPUZONE_1:AVERAGE \
DEF:TEMP_CPUZONE_2=$RRD_LOCATION:TEMP_CPUZONE_2:AVERAGE \
DEF:TEMP_CPUZONE_3=$RRD_LOCATION:TEMP_CPUZONE_3:AVERAGE \
DEF:DISK_1_TEMP_C=$RRD_LOCATION:DISK_1_TEMP_C:AVERAGE \
DEF:DISK_2_TEMP_C=$RRD_LOCATION:DISK_2_TEMP_C:AVERAGE \
LINE3:TEMP_CPUZONE_0#ff0000:"CPU Zone 0" \
GPRINT:TEMP_CPUZONE_0:LAST:"Current\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_0:AVERAGE:"Average\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_0:MAX:"Maximum\:%8.1lfC\n" \
LINE3:TEMP_CPUZONE_1#0000ff:"CPU Zone 1" \
GPRINT:TEMP_CPUZONE_1:LAST:"Current\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_1:AVERAGE:"Average\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_1:MAX:"Maximum\:%8.1lfC\n" \
LINE3:TEMP_CPUZONE_2#3399ff:"CPU Zone 2" \
GPRINT:TEMP_CPUZONE_2:LAST:"Current\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_2:AVERAGE:"Average\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_2:MAX:"Maximum\:%8.1lfC\n" \
LINE3:TEMP_CPUZONE_3#00cc33:"CPU Zone 3" \
GPRINT:TEMP_CPUZONE_3:LAST:"Current\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_3:AVERAGE:"Average\:%8.1lfC"  \
GPRINT:TEMP_CPUZONE_3:MAX:"Maximum\:%8.1lfC\n" \
COMMENT:" \n" \
LINE3:DISK_1_TEMP_C#ff6600:"Disk 1    " \
GPRINT:DISK_1_TEMP_C:LAST:"Current\:%8.1lfC"  \
GPRINT:DISK_1_TEMP_C:AVERAGE:"Average\:%8.1lfC"  \
GPRINT:DISK_1_TEMP_C:MAX:"Maximum\:%8.1lfC\n" \
LINE3:DISK_2_TEMP_C#999999:"Disk 2    " \
GPRINT:DISK_2_TEMP_C:LAST:"Current\:%8.1lfC"  \
GPRINT:DISK_2_TEMP_C:AVERAGE:"Average\:%8.1lfC"  \
GPRINT:DISK_2_TEMP_C:MAX:"Maximum\:%8.1lfC\n"



################# Graph 16 - System Tasks #################

rrdtool graph $GRAPHS_LOCATION/16_system_tasks.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "System Tasks Monitoring" \
--vertical-label "Nr of Tasks" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:TASKS_ALL=$RRD_LOCATION:TASKS_ALL:AVERAGE \
DEF:TASKS_RUNNING=$RRD_LOCATION:TASKS_RUNNING:AVERAGE \
DEF:TASKS_SLEEPING=$RRD_LOCATION:TASKS_SLEEPING:AVERAGE \
DEF:TASKS_STOPPED=$RRD_LOCATION:TASKS_STOPPED:AVERAGE \
DEF:TASKS_ZOMBIE=$RRD_LOCATION:TASKS_ZOMBIE:AVERAGE \
LINE3:TASKS_ALL#ff0000:"All system tasks     " \
GPRINT:TASKS_ALL:LAST:"Current\:%8.0lf"  \
GPRINT:TASKS_ALL:AVERAGE:"Average\:%8.0lf"  \
GPRINT:TASKS_ALL:MAX:"Maximum\:%8.0lf\n" \
LINE3:TASKS_RUNNING#0000ff:"Running system tasks " \
GPRINT:TASKS_RUNNING:LAST:"Current\:%8.0lf"  \
GPRINT:TASKS_RUNNING:AVERAGE:"Average\:%8.0lf"  \
GPRINT:TASKS_RUNNING:MAX:"Maximum\:%8.0lf\n" \
LINE3:TASKS_SLEEPING#3399ff:"Sleeping system tasks" \
GPRINT:TASKS_SLEEPING:LAST:"Current\:%8.0lf"  \
GPRINT:TASKS_SLEEPING:AVERAGE:"Average\:%8.0lf"  \
GPRINT:TASKS_SLEEPING:MAX:"Maximum\:%8.0lf\n" \
LINE3:TASKS_STOPPED#00cc33:"Stopped system tasks " \
GPRINT:TASKS_STOPPED:LAST:"Current\:%8.0lf"  \
GPRINT:TASKS_STOPPED:AVERAGE:"Average\:%8.0lf"  \
GPRINT:TASKS_STOPPED:MAX:"Maximum\:%8.0lf\n" \
LINE3:TASKS_ZOMBIE#ff6600:"Zombie system tasks  " \
GPRINT:TASKS_ZOMBIE:LAST:"Current\:%8.0lf"  \
GPRINT:TASKS_ZOMBIE:AVERAGE:"Average\:%8.0lf"  \
GPRINT:TASKS_ZOMBIE:MAX:"Maximum\:%8.0lf\n"



################# Graph 17 - Available Disk Space on Root Partition #################

rrdtool graph $GRAPHS_LOCATION/17_available_disk_space.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Available Disk Space on Root Partition " \
--vertical-label "Percentage" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:SPACE_ROOT_PART_MB=$RRD_LOCATION:SPACE_ROOT_PART_MB:AVERAGE \
LINE3:SPACE_ROOT_PART_MB#ff0000:"Available Disk Space" \
GPRINT:SPACE_ROOT_PART_MB:LAST:"Current\:%8.2lf%%"  \
GPRINT:SPACE_ROOT_PART_MB:AVERAGE:"Average\:%8.2lf%%"  \
GPRINT:SPACE_ROOT_PART_MB:MAX:"Maximum\:%8.2lf%%\n" \



################# Graph 18 - Disk Operations per Second #################

rrdtool graph $GRAPHS_LOCATION/18_disk_ops.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Disk Operations per Second" \
--vertical-label "Ops per Second (OPS)" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:DISK_1_OPS_PER_SEC=$RRD_LOCATION:DISK_1_OPS_PER_SEC:AVERAGE \
DEF:DISK_2_OPS_PER_SEC=$RRD_LOCATION:DISK_2_OPS_PER_SEC:AVERAGE \
LINE3:DISK_1_OPS_PER_SEC#ff0000:"Disk 1 OPS" \
GPRINT:DISK_1_OPS_PER_SEC:LAST:"Current\:%8.1lf"  \
GPRINT:DISK_1_OPS_PER_SEC:AVERAGE:"Average\:%8.1lf"  \
GPRINT:DISK_1_OPS_PER_SEC:MAX:"Maximum\:%8.1lf\n" \
LINE3:DISK_2_OPS_PER_SEC#0000ff:"Disk 2 OPS" \
GPRINT:DISK_2_OPS_PER_SEC:LAST:"Current\:%8.1lf"  \
GPRINT:DISK_2_OPS_PER_SEC:AVERAGE:"Average\:%8.1lf"  \
GPRINT:DISK_2_OPS_PER_SEC:MAX:"Maximum\:%8.1lf\n"



################# Graph 19 - Disk Throughput #################

rrdtool graph $GRAPHS_LOCATION/19_disk_read_write_rate.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Disk Throughput" \
--vertical-label "KBps" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:DISK_1_READ_KBS=$RRD_LOCATION:DISK_1_READ_KBS:AVERAGE \
DEF:DISK_2_READ_KBS=$RRD_LOCATION:DISK_2_READ_KBS:AVERAGE \
DEF:DISK_1_WRITE_KBS=$RRD_LOCATION:DISK_1_WRITE_KBS:AVERAGE \
DEF:DISK_2_WRITE_KBS=$RRD_LOCATION:DISK_2_WRITE_KBS:AVERAGE \
LINE3:DISK_1_WRITE_KBS#ff0000:"Disk 1 Write KBps" \
GPRINT:DISK_1_WRITE_KBS:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_WRITE_KBS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_WRITE_KBS:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_WRITE_KBS#0000ff:"Disk 2 Write KBps" \
GPRINT:DISK_2_WRITE_KBS:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_WRITE_KBS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_WRITE_KBS:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_READ_KBS#ffcc00:"Disk 1 Read KBps " \
GPRINT:DISK_1_READ_KBS:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_READ_KBS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_READ_KBS:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_READ_KBS#006600:"Disk 2 Read KBps " \
GPRINT:DISK_2_READ_KBS:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_READ_KBS:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_READ_KBS:MAX:"Maximum\:%8.0lf\n"



################# Graph 20 - Disk Throughput Performance #################

rrdtool graph $GRAPHS_LOCATION/20_smart_throughput_perf.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Disk S.M.A.R.T. Throughput Performance" \
--vertical-label "N/A" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:DISK_1_THROUGHPUT=$RRD_LOCATION:DISK_1_THROUGHPUT:AVERAGE \
DEF:DISK_2_THROUGHPUT=$RRD_LOCATION:DISK_2_THROUGHPUT:AVERAGE \
LINE3:DISK_1_THROUGHPUT#ff0000:"Disk 1 Performance" \
GPRINT:DISK_1_THROUGHPUT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_THROUGHPUT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_THROUGHPUT:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_THROUGHPUT#0000ff:"Disk 2 Performance" \
GPRINT:DISK_2_THROUGHPUT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_THROUGHPUT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_THROUGHPUT:MAX:"Maximum\:%8.0lf\n"



################# Graph 21 - Disk Errors #################

rrdtool graph $GRAPHS_LOCATION/21_disk_errors.png \
--imgformat PNG \
--start now-2d --end now \
--width 960 --height 300 \
--title "Disk errors" \
--vertical-label "Nr. of Errors" \
--slope-mode -A \
--watermark "`date`" \
--color GRID#ffffff \
--color MGRID#ffffff \
--color BACK#ffffff \
--font TITLE:20 \
DEF:DISK_1_RD_ERR_RATE=$RRD_LOCATION:DISK_1_RD_ERR_RATE:AVERAGE \
DEF:DISK_2_RD_ERR_RATE=$RRD_LOCATION:DISK_2_RD_ERR_RATE:AVERAGE \
DEF:DISK_1_REALLOC_EVNT=$RRD_LOCATION:DISK_1_REALLOC_EVNT:AVERAGE \
DEF:DISK_2_REALLOC_EVNT=$RRD_LOCATION:DISK_2_REALLOC_EVNT:AVERAGE \
DEF:DISK_1_CUR_PEND_SCT=$RRD_LOCATION:DISK_1_CUR_PEND_SCT:AVERAGE \
DEF:DISK_2_CUR_PEND_SCT=$RRD_LOCATION:DISK_2_CUR_PEND_SCT:AVERAGE \
DEF:DISK_1_OFFL_UNCORR=$RRD_LOCATION:DISK_1_OFFL_UNCORR:AVERAGE \
DEF:DISK_2_OFFL_UNCORR=$RRD_LOCATION:DISK_2_OFFL_UNCORR:AVERAGE \
DEF:DISK_1_UDMA_CRC_ERR=$RRD_LOCATION:DISK_1_UDMA_CRC_ERR:AVERAGE \
DEF:DISK_2_UDMA_CRC_ERR=$RRD_LOCATION:DISK_2_UDMA_CRC_ERR:AVERAGE \
DEF:DISK_1_SEEK_ERR_RT=$RRD_LOCATION:DISK_1_SEEK_ERR_RT:AVERAGE \
DEF:DISK_2_SEEK_ERR_RT=$RRD_LOCATION:DISK_2_SEEK_ERR_RT:AVERAGE \
DEF:DISK_1_REALLOC_SCTR=$RRD_LOCATION:DISK_1_REALLOC_SCTR:AVERAGE \
DEF:DISK_2_REALLOC_SCTR=$RRD_LOCATION:DISK_2_REALLOC_SCTR:AVERAGE \
DEF:DISK_1_SPIN_RTR_CNT=$RRD_LOCATION:DISK_1_SPIN_RTR_CNT:AVERAGE \
DEF:DISK_2_SPIN_RTR_CNT=$RRD_LOCATION:DISK_2_SPIN_RTR_CNT:AVERAGE \
LINE3:DISK_1_RD_ERR_RATE#ff0000:"Disk 1 Raw Read Error Rate    " \
GPRINT:DISK_1_RD_ERR_RATE:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_RD_ERR_RATE:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_RD_ERR_RATE:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_RD_ERR_RATE#ff0000:"Disk 2 Raw Read Error Rate    " \
GPRINT:DISK_2_RD_ERR_RATE:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_RD_ERR_RATE:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_RD_ERR_RATE:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_REALLOC_EVNT#993300:"Disk 1 Reallocated Events     " \
GPRINT:DISK_1_REALLOC_EVNT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_REALLOC_EVNT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_REALLOC_EVNT:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_REALLOC_EVNT#993300:"Disk 2 Reallocated Events     " \
GPRINT:DISK_2_REALLOC_EVNT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_REALLOC_EVNT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_REALLOC_EVNT:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_CUR_PEND_SCT#00ff00:"Disk 1 Current Pending Sectors" \
GPRINT:DISK_1_CUR_PEND_SCT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_CUR_PEND_SCT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_CUR_PEND_SCT:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_CUR_PEND_SCT#00ff00:"Disk 2 Current Pending Sectors" \
GPRINT:DISK_2_CUR_PEND_SCT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_CUR_PEND_SCT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_CUR_PEND_SCT:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_OFFL_UNCORR#cc33ff:"Disk 1 Offline Uncorrectables " \
GPRINT:DISK_1_OFFL_UNCORR:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_OFFL_UNCORR:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_OFFL_UNCORR:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_OFFL_UNCORR#cc33ff:"Disk 2 Offline Uncorrectables " \
GPRINT:DISK_2_OFFL_UNCORR:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_OFFL_UNCORR:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_OFFL_UNCORR:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_UDMA_CRC_ERR#cc0033:"Disk 1 UDMA CRC Errors        " \
GPRINT:DISK_1_UDMA_CRC_ERR:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_UDMA_CRC_ERR:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_UDMA_CRC_ERR:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_UDMA_CRC_ERR#cc0033:"Disk 2 UDMA CRC Errors        " \
GPRINT:DISK_2_UDMA_CRC_ERR:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_UDMA_CRC_ERR:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_UDMA_CRC_ERR:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_SEEK_ERR_RT#ffff00:"Disk 1 Seek Error Rate        " \
GPRINT:DISK_1_SEEK_ERR_RT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_SEEK_ERR_RT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_SEEK_ERR_RT:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_SEEK_ERR_RT#ffff00:"Disk 2 Seek Error Rate        " \
GPRINT:DISK_2_SEEK_ERR_RT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_SEEK_ERR_RT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_SEEK_ERR_RT:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_REALLOC_SCTR#999900:"Disk 1 Reallocated Sectors    " \
GPRINT:DISK_1_REALLOC_SCTR:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_REALLOC_SCTR:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_REALLOC_SCTR:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_REALLOC_SCTR#999900:"Disk 2 Reallocated Sectors    " \
GPRINT:DISK_2_REALLOC_SCTR:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_REALLOC_SCTR:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_REALLOC_SCTR:MAX:"Maximum\:%8.0lf\n" \
COMMENT:" \n" \
LINE3:DISK_1_SPIN_RTR_CNT#0000ff:"Disk 1 Spin Retries           " \
GPRINT:DISK_1_SPIN_RTR_CNT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_1_SPIN_RTR_CNT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_1_SPIN_RTR_CNT:MAX:"Maximum\:%8.0lf\n" \
LINE3:DISK_2_SPIN_RTR_CNT#0000ff:"Disk 1 Spin Retries           " \
GPRINT:DISK_2_SPIN_RTR_CNT:LAST:"Current\:%8.0lf"  \
GPRINT:DISK_2_SPIN_RTR_CNT:AVERAGE:"Average\:%8.0lf"  \
GPRINT:DISK_2_SPIN_RTR_CNT:MAX:"Maximum\:%8.0lf\n"
