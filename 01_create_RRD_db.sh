#! /bin/bash

#  WHAT IS THIS:
#  - this script creates a RRD database pre-populated with all data sources we need in order to create system-wide health snapshots (60sec interval) for an Elrond node
#  - the script takes a single argument, which is the full system path of the RRD database
#
#  SCRIPT DEPENDENCIES: rrdtool    <- Install package before running this script
#
#  EXAMPLE: ./create_rrd_db.sh /home/user/database.rrd

rrdtool create $1 \
--step 60 \
DS:CPU_USER_ALLCORES:GAUGE:120:0:U \
DS:CPU_USER_CORE_0:GAUGE:120:0:U \
DS:CPU_USER_CORE_1:GAUGE:120:0:U \
DS:CPU_USER_CORE_2:GAUGE:120:0:U \
DS:CPU_USER_CORE_3:GAUGE:120:0:U \
DS:CPU_USER_CORE_4:GAUGE:120:0:U \
DS:CPU_USER_CORE_5:GAUGE:120:0:U \
DS:CPU_USER_CORE_6:GAUGE:120:0:U \
DS:CPU_USER_CORE_7:GAUGE:120:0:U \
DS:CPU_TOTAL_ALLCORES:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_0:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_1:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_2:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_3:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_4:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_5:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_6:GAUGE:120:0:U \
DS:CPU_TOTAL_CORE_7:GAUGE:120:0:U \
DS:TEMP_CPUZONE_0:GAUGE:120:0:U \
DS:TEMP_CPUZONE_1:GAUGE:120:0:U \
DS:TEMP_CPUZONE_2:GAUGE:120:0:U \
DS:TEMP_CPUZONE_3:GAUGE:120:0:U \
DS:TASKS_ALL:GAUGE:120:0:U \
DS:TASKS_RUNNING:GAUGE:120:0:U \
DS:TASKS_SLEEPING:GAUGE:120:0:U \
DS:TASKS_STOPPED:GAUGE:120:0:U \
DS:TASKS_ZOMBIE:GAUGE:120:0:U \
DS:MEMORY_TOTAL_MB:GAUGE:120:0:U \
DS:MEMORY_USED_MB:GAUGE:120:0:U \
DS:MEMORY_CACHED_MB:GAUGE:120:0:U \
DS:SWAP_TOTAL_MB:GAUGE:120:0:U \
DS:SWAP_USED_MB:GAUGE:120:0:U \
DS:SPACE_ROOT_PART_MB:GAUGE:120:0:U \
DS:DB_SIZE_NODE_0_MB:GAUGE:120:0:U \
DS:DB_SIZE_NODE_1_MB:GAUGE:120:0:U \
DS:DISK_1_OPS_PER_SEC:GAUGE:120:0:U \
DS:DISK_2_OPS_PER_SEC:GAUGE:120:0:U \
DS:DISK_1_READ_KBS:GAUGE:120:0:U \
DS:DISK_2_READ_KBS:GAUGE:120:0:U \
DS:DISK_1_WRITE_KBS:GAUGE:120:0:U \
DS:DISK_2_WRITE_KBS:GAUGE:120:0:U \
DS:DISK_1_RD_ERR_RATE:GAUGE:120:0:U \
DS:DISK_1_THROUGHPUT:GAUGE:120:0:U \
DS:DISK_1_SPINUP_TIME:GAUGE:120:0:U \
DS:DISK_1_SRTSTP_CNT:GAUGE:120:0:U \
DS:DISK_1_REALLOC_SCTR:GAUGE:120:0:U \
DS:DISK_1_SEEK_ERR_RT:GAUGE:120:0:U \
DS:DISK_1_SEEK_TM_PERF:GAUGE:120:0:U \
DS:DISK_1_PWR_ON_HRS:GAUGE:120:0:U \
DS:DISK_1_SPIN_RTR_CNT:GAUGE:120:0:U \
DS:DISK_1_PWR_CYCL_CNT:GAUGE:120:0:U \
DS:DISK_1_PWROFF_RTRCT:GAUGE:120:0:U \
DS:DISK_1_LD_CYCLE_CNT:GAUGE:120:0:U \
DS:DISK_1_TEMP_C:GAUGE:120:0:U \
DS:DISK_1_REALLOC_EVNT:GAUGE:120:0:U \
DS:DISK_1_CUR_PEND_SCT:GAUGE:120:0:U \
DS:DISK_1_OFFL_UNCORR:GAUGE:120:0:U \
DS:DISK_1_UDMA_CRC_ERR:GAUGE:120:0:U \
DS:DISK_2_RD_ERR_RATE:GAUGE:120:0:U \
DS:DISK_2_THROUGHPUT:GAUGE:120:0:U \
DS:DISK_2_SPINUP_TIME:GAUGE:120:0:U \
DS:DISK_2_SRTSTP_CNT:GAUGE:120:0:U \
DS:DISK_2_REALLOC_SCTR:GAUGE:120:0:U \
DS:DISK_2_SEEK_ERR_RT:GAUGE:120:0:U \
DS:DISK_2_SEEK_TM_PERF:GAUGE:120:0:U \
DS:DISK_2_PWR_ON_HRS:GAUGE:120:0:U \
DS:DISK_2_SPIN_RTR_CNT:GAUGE:120:0:U \
DS:DISK_2_PWR_CYCL_CNT:GAUGE:120:0:U \
DS:DISK_2_PWROFF_RTRCT:GAUGE:120:0:U \
DS:DISK_2_LD_CYCLE_CNT:GAUGE:120:0:U \
DS:DISK_2_TEMP_C:GAUGE:120:0:U \
DS:DISK_2_REALLOC_EVNT:GAUGE:120:0:U \
DS:DISK_2_CUR_PEND_SCT:GAUGE:120:0:U \
DS:DISK_2_OFFL_UNCORR:GAUGE:120:0:U \
DS:DISK_2_UDMA_CRC_ERR:GAUGE:120:0:U \
DS:EGRESS_PPS:GAUGE:120:0:U \
DS:INGRESS_PPS:GAUGE:120:0:U \
DS:EGRESS_MBPS:GAUGE:120:0:U \
DS:INGRESS_MBPS:GAUGE:120:0:U \
DS:PHY_MEM_USD_N0:GAUGE:120:0:U \
DS:PHY_MEM_USD_N1:GAUGE:120:0:U \
DS:VIRT_MEM_USD_N0:GAUGE:120:0:U \
DS:VIRT_MEM_USD_N1:GAUGE:120:0:U \
DS:PHY_MEM_USD_ARWN_0:GAUGE:120:0:U \
DS:PHY_MEM_USD_ARWN_1:GAUGE:120:0:U \
DS:VIRT_MEM_USD_ARWN_0:GAUGE:120:0:U \
DS:VIRT_MEM_USD_ARWN_1:GAUGE:120:0:U \
DS:N0_CURRENT_ROUND:GAUGE:120:0:U \
DS:N0_SYNCED_ROUND:GAUGE:120:0:U \
DS:N0_SHARD_ID:GAUGE:120:0:U \
DS:N0_EPOCH_NUMBER:GAUGE:120:0:U \
DS:N0_CONNECTED_PEERS:GAUGE:120:0:U \
DS:N0_ACTIVE_VALID:GAUGE:120:0:U \
DS:N0_ACTIVE_OBS:GAUGE:120:0:U \
DS:N0_ALL_NODES_SEEN:GAUGE:120:0:U \
DS:N0_CNT_CONSENSUS:GAUGE:120:0:U \
DS:N0_CONS_ACPT_BLCKS:GAUGE:120:0:U \
DS:N0_COUNT_LEADER:GAUGE:120:0:U \
DS:N0_ACCEPTED_BLOCKS:GAUGE:120:0:U \
DS:N1_CURRENT_ROUND:GAUGE:120:0:U \
DS:N1_SYNCED_ROUND:GAUGE:120:0:U \
DS:N1_SHARD_ID:GAUGE:120:0:U \
DS:N1_EPOCH_NUMBER:GAUGE:120:0:U \
DS:N1_CONNECTED_PEERS:GAUGE:120:0:U \
DS:N1_ACTIVE_VALID:GAUGE:120:0:U \
DS:N1_ACTIVE_OBS:GAUGE:120:0:U \
DS:N1_ALL_NODES_SEEN:GAUGE:120:0:U \
DS:N1_CNT_CONSENSUS:GAUGE:120:0:U \
DS:N1_CONS_ACPT_BLCKS:GAUGE:120:0:U \
DS:N1_COUNT_LEADER:GAUGE:120:0:U \
DS:N1_ACCEPTED_BLOCKS:GAUGE:120:0:U \
RRA:AVERAGE:0.5:1:2880 \
RRA:AVERAGE:0.5:15:2880 \
RRA:AVERAGE:0.5:60:2880