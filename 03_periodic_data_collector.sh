#! /bin/bash

# Uncomment for debugging output in Syslog
# exec 1> >(logger -s -t $(basename $0)) 2>&1

#  WHAT IS THIS:
# 
#  - This script is collecting multiple data points for all physical and logical components of an Elrond Validator Node
#  - It's scraping the output of a few standard linux commands 
#  - Its aim is to create a snapshot of a node's health status everytime the script runs
#  - The snapshot is saved in a Round-Robin Db (RRD), because of low footprint, (lack of) management requirements and risk of memory leaks
#  - The script was built to be executed every 60s and thus must consume as few resources as possible
#  - It's also written as simple as possible, so it can be understood & troubleshot fast when required 
#
#  SCRIPT DEPENDENCIES: sysstat smartmontools rrdtool    <- Install these packages before running this script
#
#  SCRIPT VARIABLES:
PRODUCTION_INTERFACE="eth1"
RRD_LOCATION="/home/user/database.rrd"
ELROND_USER_HOME_FOLDER="/home/user"

# Because CRON has limited environment variables, to avoid runtime errorrs we will import the full system PATH as well as the SHELL whenever we involve this script
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/bin
SHELL=/bin/bash



################ DATASET 1: CPU USAGE ################
#
# DESCRIPTION: Measuring global and per-core CPU usage, both for USER processes and TOTAL = (SYSTEM + USERLAND)

IFS=$' '
CPU_USAGE_OUTPUT=$(mpstat -A | sed -n 4,12p)

#       EXAMPLE OUTPUT (TRUNCATED) FOR 'mpstat -A' 
#       ------------------------------------------
#        user@SERVER:~$ mpstat -A
#
#        11:14:54 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
#        11:14:54 PM  all   19.29    0.00    1.75    0.59    0.00    0.35    0.00    0.00    0.00   78.02
#        11:14:54 PM    0   16.35    0.00    1.73    0.54    0.00    0.55    0.00    0.00    0.00   80.83
#        11:14:54 PM    1   15.54    0.00    1.59    0.56    0.00    0.13    0.00    0.00    0.00   82.17
#        11:14:54 PM    2   14.48    0.00    1.60    0.54    0.00    0.06    0.00    0.00    0.00   83.31
#        11:14:54 PM    3   16.53    0.00    1.72    0.47    0.00    0.20    0.00    0.00    0.00   81.08
#        11:14:54 PM    4   14.09    0.00    1.68    0.72    0.00    0.07    0.00    0.00    0.00   83.43
#        11:14:54 PM    5   29.33    0.00    1.84    0.65    0.00    0.65    0.00    0.00    0.00   67.52
#        11:14:54 PM    6   19.70    0.00    1.91    0.76    0.00    0.37    0.00    0.00    0.00   77.27
#        11:14:54 PM    7   28.42    0.00    1.94    0.48    0.00    0.73    0.00    0.00    0.00   68.43

# Userland CPU usage
CPU_USER_ALLCORES=$(echo $CPU_USAGE_OUTPUT | sed -n 1p | awk '{print $4}')
CPU_USER_CORE_0=$(echo $CPU_USAGE_OUTPUT | sed -n 2p | awk '{print $4}')
CPU_USER_CORE_1=$(echo $CPU_USAGE_OUTPUT | sed -n 3p | awk '{print $4}')
CPU_USER_CORE_2=$(echo $CPU_USAGE_OUTPUT | sed -n 4p | awk '{print $4}')
CPU_USER_CORE_3=$(echo $CPU_USAGE_OUTPUT | sed -n 5p | awk '{print $4}')
CPU_USER_CORE_4=$(echo $CPU_USAGE_OUTPUT | sed -n 6p | awk '{print $4}')
CPU_USER_CORE_5=$(echo $CPU_USAGE_OUTPUT | sed -n 7p | awk '{print $4}')
CPU_USER_CORE_6=$(echo $CPU_USAGE_OUTPUT | sed -n 8p | awk '{print $4}')
CPU_USER_CORE_7=$(echo $CPU_USAGE_OUTPUT | sed -n 9p | awk '{print $4}')

# Total CPU usage (SYSTEM + USERLAND including ELrond Node, Arwen etc.)
CPU_TOTAL_ALLCORES=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 1p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_0=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 2p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_1=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 3p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_2=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 4p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_3=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 5p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_4=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 6p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_5=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 7p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_6=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 8p | awk '{print $13}')"| bc )
CPU_TOTAL_CORE_7=$(echo "100-$(echo $CPU_USAGE_OUTPUT | sed -n 9p | awk '{print $13}')"| bc )



################ DATASET 2: CPU ZONE TEMPERATURE ################
#
# DESCRIPTION: Collecting temperature measurements from all CPU probes (this script assumes a max of 4 probes)

TEMP_CPUZONE_0=$(echo "scale=1; $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 "| bc -l)
TEMP_CPUZONE_1=$(echo "scale=1; $(cat /sys/class/thermal/thermal_zone1/temp) / 1000 "| bc -l)
TEMP_CPUZONE_2=$(echo "scale=1; $(cat /sys/class/thermal/thermal_zone2/temp) / 1000 "| bc -l)
TEMP_CPUZONE_3=$(echo "scale=1; $(cat /sys/class/thermal/thermal_zone3/temp) / 1000 "| bc -l)



################ DATASET 3: MEMORY / SWAP / TASKS STATS ################
#
# DESCRIPTION: Collecting physical memory usage, swap usage and measurements for ongoing system processes / tasks

TOP_OUTPUT=$(top -b -n 1 | sed -n 2,5p )

#       EXAMPLE OUTPUT (TRUNCATED) FOR 'top -n 1' 
#       ------------------------------------------
#        user@SERVER:~$ top -n 1
#        top - 23:17:32 up 5 days, 11:16,  3 users,  load average: 3.36, 2.65, 2.38
#        Tasks: 180 total,   1 running, 103 sleeping,   0 stopped,   0 zombie
#        %Cpu(s): 19.3 us,  1.8 sy,  0.0 ni, 78.0 id,  0.6 wa,  0.0 hi,  0.3 si,  0.0 st
#        KiB Mem : 32618560 total, 22512808 free,  2653004 used,  7452748 buff/cache
#        KiB Swap:  1046520 total,  1046520 free,        0 used. 30491400 avail Mem

TASKS_ALL=$(echo $TOP_OUTPUT | sed -n 1p | awk '{print $2}' | bc )
TASKS_RUNNING=$(echo $TOP_OUTPUT | sed -n 1p | awk '{print $4}' | bc )
TASKS_SLEEPING=$(echo $TOP_OUTPUT | sed -n 1p | awk '{print $6}' | bc )
TASKS_STOPPED=$(echo $TOP_OUTPUT | sed -n 1p | awk '{print $8}' | bc )
TASKS_ZOMBIE=$(echo $TOP_OUTPUT | sed -n 1p | awk '{print $10}' | bc )

# Values in MB
MEMORY_TOTAL_MB=$(echo $TOP_OUTPUT | sed -n 3p | awk '{print $4}' | bc  )
MEMORY_USED_MB=$(echo $TOP_OUTPUT | sed -n 3p | awk '{print $8}' | bc  )
MEMORY_CACHED_MB=$(echo $TOP_OUTPUT | sed -n 3p | awk '{print $10}' | bc  )

SWAP_TOTAL_MB=$(echo $TOP_OUTPUT | sed -n 4p | awk '{print $3}' | bc )
SWAP_USED_MB=$(echo $TOP_OUTPUT | sed -n 4p | awk '{print $7}' | bc )




################ DATASET 4: HDD FREE SPACE  ################
#
# DESCRIPTION: Computing the used disk space percentage on the ROOT partition. This script assumes one single ROOT partition where the entire system resides in, without any secondary mountpoints within a ROOT directory

DF_OUTPUT=$(df)

#       EXAMPLE OUTPUT FOR 'df' 
#       ------------------------
#        user@SERVER:~$ df
#        Filesystem      1K-blocks    Used  Available Use% Mounted on
#        udev             16277412       0   16277412   0% /dev
#        tmpfs             3261856     856    3261000   1% /run
#        /dev/md3       3844027432 8211572 3640527392   1% /
#        tmpfs            16309280       0   16309280   0% /dev/shm
#        tmpfs                5120       0       5120   0% /run/lock
#        tmpfs            16309280       0   16309280   0% /sys/fs/cgroup
#        /dev/md2           498468  151581     316631  33% /boot
#        /dev/sda1          522228    6196     516032   2% /boot/efi
#        tmpfs             3261856       0    3261856   0% /run/user/1000

SPACE_ROOT_PART_MB=$(echo "scale=2; $((`echo $DF_OUTPUT | egrep md3 | awk '{print $4}'`)) * 100 / $((`echo $DF_OUTPUT | egrep md3 | awk '{print $2}'`)) "| bc -l)



################ DATASET 5: HDD LOGICAL OPERATIONS  ################
#
# DESCRIPTION: Measuring the READ and WRITE rates in KBps as well as the rate of disk operations. This script assumes the server has two disks.

IOSTAT_OUTPUT=$(iostat)

#       EXAMPLE OUTPUT FOR 'iostat' 
#       ---------------------------
#        user@SERVER:~$ iostat
#
#        avg-cpu:  %user   %nice %system %iowait  %steal   %idle
#                19.30    0.00    2.10    0.59    0.00   78.01
#
#        Device             tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
#        loop0             0.00         0.00         0.00          5          0
#        sda              37.38         0.85      1551.32     404131  733312347
#        sdb              37.35         0.44      1551.32     209951  733312346
#        md3              48.08         1.20      1534.64     569513  725430164
#        md2               0.00         0.01         0.15       3614      69931

DISK_1_OPS_PER_SEC=$(echo $IOSTAT_OUTPUT | sed -n 8,8p | awk '{print $2}' | bc)
DISK_2_OPS_PER_SEC=$(echo $IOSTAT_OUTPUT | sed -n 9,9p | awk '{print $2}' | bc)

DISK_1_READ_KBS=$(echo $IOSTAT_OUTPUT | sed -n 8,8p | awk '{print $3}' | bc)
DISK_2_READ_KBS=$(echo $IOSTAT_OUTPUT | sed -n 9,9p | awk '{print $3}' | bc)

DISK_1_WRITE_KBS=$(echo $IOSTAT_OUTPUT | sed -n 8,8p | awk '{print $4}' | bc)
DISK_2_WRITE_KBS=$(echo $IOSTAT_OUTPUT | sed -n 9,9p | awk '{print $4}' | bc)



################ DATASET 6: HDD PHYSICAL STATS ################
#
# DESCRIPTION: This section is extracting HDD/SSD low-level monitoring data from S.M.A.R.T.

SMART_DISK_1_OUTPUT=$(sudo smartctl -a /dev/sda | sed -n 58,74p)
SMART_DISK_2_OUTPUT=$(sudo smartctl -a /dev/sdb | sed -n 58,74p)

#       EXAMPLE OUTPUT (TRUNCATED) FOR 'sudo smartctl -a /dev/sda' 
#       ----------------------------------------------------------
#        SMART Attributes Data Structure revision number: 16
#        Vendor Specific SMART Attributes with Thresholds:
#        ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
#        1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail  Always       -       0
#        2 Throughput_Performance  0x0005   130   130   054    Pre-fail  Offline      -       100
#        3 Spin_Up_Time            0x0007   158   158   024    Pre-fail  Always       -       261 (Average 274)
#        4 Start_Stop_Count        0x0012   100   100   000    Old_age   Always       -       23
#        5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       -       0
#        7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       -       0
#        8 Seek_Time_Performance   0x0005   128   128   020    Pre-fail  Offline      -       18
#        9 Power_On_Hours          0x0012   100   100   000    Old_age   Always       -       509
#        10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       -       0
#        12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       23
#        192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       43
#        193 Load_Cycle_Count        0x0012   100   100   000    Old_age   Always       -       43
#        194 Temperature_Celsius     0x0002   181   181   000    Old_age   Always       -       33 (Min/Max 21/45)
#        196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
#        197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       -       0
#        198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   Offline      -       0
#        199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       -       0

DISK_1_RD_ERR_RATE=$(echo $SMART_DISK_1_OUTPUT | sed -n 1,1p | awk '{print $10}' | bc)
DISK_1_THROUGHPUT=$(echo $SMART_DISK_1_OUTPUT | sed -n 2,2p | awk '{print $10}' | bc)
DISK_1_SPINUP_TIME=$(echo $SMART_DISK_1_OUTPUT | sed -n 3,3p | awk '{print $10}' | bc)
DISK_1_SRTSTP_CNT=$(echo $SMART_DISK_1_OUTPUT | sed -n 4,4p | awk '{print $10}' | bc)
DISK_1_REALLOC_SCTR=$(echo $SMART_DISK_1_OUTPUT | sed -n 5,5p | awk '{print $10}' | bc)
DISK_1_SEEK_ERR_RT=$(echo $SMART_DISK_1_OUTPUT | sed -n 6,6p | awk '{print $10}' | bc)
DISK_1_SEEK_TM_PERF=$(echo $SMART_DISK_1_OUTPUT | sed -n 7,7p | awk '{print $10}' | bc)
DISK_1_PWR_ON_HRS=$(echo $SMART_DISK_1_OUTPUT | sed -n 8,8p | awk '{print $10}' | bc)
DISK_1_SPIN_RTR_CNT=$(echo $SMART_DISK_1_OUTPUT | sed -n 9,9p | awk '{print $10}' | bc)
DISK_1_PWR_CYCL_CNT=$(echo $SMART_DISK_1_OUTPUT | sed -n 10,10p | awk '{print $10}' | bc)
DISK_1_PWROFF_RTRCT=$(echo $SMART_DISK_1_OUTPUT | sed -n 11,11p | awk '{print $10}' | bc)
DISK_1_LD_CYCLE_CNT=$(echo $SMART_DISK_1_OUTPUT | sed -n 12,12p | awk '{print $10}' | bc)
DISK_1_TEMP_C=$(echo $SMART_DISK_1_OUTPUT | sed -n 13,13p | awk '{print $10}' | bc)
DISK_1_REALLOC_EVNT=$(echo $SMART_DISK_1_OUTPUT | sed -n 14,14p | awk '{print $10}' | bc)
DISK_1_CUR_PEND_SCT=$(echo $SMART_DISK_1_OUTPUT | sed -n 15,15p | awk '{print $10}' | bc)
DISK_1_OFFL_UNCORR=$(echo $SMART_DISK_1_OUTPUT | sed -n 16,16p | awk '{print $10}' | bc)
DISK_1_UDMA_CRC_ERR=$(echo $SMART_DISK_1_OUTPUT | sed -n 17,17p | awk '{print $10}' | bc)

DISK_2_RD_ERR_RATE=$(echo $SMART_DISK_2_OUTPUT | sed -n 1,1p | awk '{print $10}' | bc)
DISK_2_THROUGHPUT=$(echo $SMART_DISK_2_OUTPUT | sed -n 2,2p | awk '{print $10}' | bc)
DISK_2_SPINUP_TIME=$(echo $SMART_DISK_2_OUTPUT | sed -n 3,3p | awk '{print $10}' | bc)
DISK_2_SRTSTP_CNT=$(echo $SMART_DISK_2_OUTPUT | sed -n 4,4p | awk '{print $10}' | bc)
DISK_2_REALLOC_SCTR=$(echo $SMART_DISK_2_OUTPUT | sed -n 5,5p | awk '{print $10}' | bc)
DISK_2_SEEK_ERR_RT=$(echo $SMART_DISK_2_OUTPUT | sed -n 6,6p | awk '{print $10}' | bc)
DISK_2_SEEK_TM_PERF=$(echo $SMART_DISK_2_OUTPUT | sed -n 7,7p | awk '{print $10}' | bc)
DISK_2_PWR_ON_HRS=$(echo $SMART_DISK_2_OUTPUT | sed -n 8,8p | awk '{print $10}' | bc)
DISK_2_SPIN_RTR_CNT=$(echo $SMART_DISK_2_OUTPUT | sed -n 9,9p | awk '{print $10}' | bc)
DISK_2_PWR_CYCL_CNT=$(echo $SMART_DISK_2_OUTPUT | sed -n 10,10p | awk '{print $10}' | bc)
DISK_2_PWROFF_RTRCT=$(echo $SMART_DISK_2_OUTPUT | sed -n 11,11p | awk '{print $10}' | bc)
DISK_2_LD_CYCLE_CNT=$(echo $SMART_DISK_2_OUTPUT | sed -n 12,12p | awk '{print $10}' | bc)
DISK_2_TEMP_C=$(echo $SMART_DISK_2_OUTPUT | sed -n 13,13p | awk '{print $10}' | bc)
DISK_2_REALLOC_EVNT=$(echo $SMART_DISK_2_OUTPUT | sed -n 14,14p | awk '{print $10}' | bc)
DISK_2_CUR_PEND_SCT=$(echo $SMART_DISK_2_OUTPUT | sed -n 15,15p | awk '{print $10}' | bc)
DISK_2_OFFL_UNCORR=$(echo $SMART_DISK_2_OUTPUT | sed -n 16,16p | awk '{print $10}' | bc)
DISK_2_UDMA_CRC_ERR=$(echo $SMART_DISK_2_OUTPUT | sed -n 17,17p | awk '{print $10}' | bc)



################ DATASET 7: PPS / BPS THROUGHPUT STATS ################
#
# DESCRIPTION: Computing the PPS and Mbps traffic rate for the production interface. Since on Linux we don't have this data raedily available, the script takes two snapshots 1sec apart and computes the diff.

RX_PPS_1=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/rx_packets`
RX_BPS_1=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/rx_bytes`
TX_PPS_1=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/tx_packets`
TX_BPS_1=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/tx_bytes`
sleep 1
RX_PPS_2=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/rx_packets`
RX_BPS_2=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/rx_bytes`
TX_PPS_2=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/tx_packets`
TX_BPS_2=`cat /sys/class/net/$PRODUCTION_INTERFACE/statistics/tx_bytes`

EGRESS_PPS=$(( $TX_PPS_2 - $TX_PPS_1 ))
INGRESS_PPS=$(( $RX_PPS_2 - $RX_PPS_1))
EGRESS_MBPS=$(echo "scale=2; ( $TX_BPS_2 - $TX_BPS_1 ) * 8 / 1048576 "| bc -l)
INGRESS_MBPS=$(echo "scale=2; ( $RX_BPS_2 - $RX_BPS_1 ) * 8 / 1048576 "| bc -l)



################ DATASET 8: ELROND NODE / ARWEN PROCESS MEMORY FOOTPRINT AND DB SIZE ################
#
# DESCRIPTION: Measuring the memory footprint for the Elrond node process, the Arwen process and the size of the Elrond database. This script assumes two nodes are running on the same physical server.

PS_OUTPUT=$(ps aux | egrep elrond)

#       EXAMPLE OUTPUT  FOR 'ps aux | egrep elrond' 
#       -------------------------------------------
#        user@SERVER:~$ ps aux | egrep elrond
#        user  3301  0.0  0.0  13144  1052 pts/2    S+   23:22   0:00 grep -E elrond
#        user 31006  105  3.8 4148520 1262464 ?     Ssl  22:18  67:40 /home/user/elrond-nodes/node-0/node -use-log-view -log-logger-name -log-correlation -log-level *:INFO -rest-api-interface localhost:8080
#        user 31037  100  3.6 4301404 1194816 ?     Ssl  22:18  64:16 /home/user/elrond-nodes/node-1/node -use-log-view -log-logger-name -log-correlation -log-level *:INFO -rest-api-interface localhost:8081
#        user 31119  0.0  0.0 1107448 15572 ?       Sl   22:19   0:00 /home/user/elrond-nodes/node-1/arwen
#        user 31125  0.0  0.0 1107448 14988 ?       Sl   22:19   0:00 /home/user/elrond-nodes/node-0/arwen

# Values in MB
PHY_MEM_USD_N0=$((`echo $PS_OUTPUT | egrep localhost | egrep node-0 | awk '{print $5}'` / 1024))
PHY_MEM_USD_N1=$((`echo $PS_OUTPUT | egrep localhost | egrep node-1 | awk '{print $5}'` / 1024))

VIRT_MEM_USD_N0=$((`echo $PS_OUTPUT | egrep localhost | egrep node-0 | awk '{print $6}'` / 1024))
VIRT_MEM_USD_N1=$((`echo $PS_OUTPUT | egrep localhost | egrep node-1 | awk '{print $6}'` / 1024))

DB_SIZE_NODE_0_MB=$(echo $(du -s $ELROND_USER_HOME_FOLDER/elrond-nodes/node-0/db/ | awk '{print $1}') / 1024 | bc)
DB_SIZE_NODE_1_MB=$(echo $(du -s $ELROND_USER_HOME_FOLDER/elrond-nodes/node-1/db/ | awk '{print $1}') / 1024 | bc)

# We need to do a bit of tweaking for the Arwen memory footprint, because Arwen doesn't run on the node when it is part of Metashard

# First we record Arwen output for each node
ARWEN_NODE_0=$(echo $PS_OUTPUT | egrep arwen | egrep node-0)
ARWEN_NODE_1=$(echo $PS_OUTPUT | egrep arwen | egrep node-1)

# Then, only if Arwen is running for that node calculate its memory footprint, else just record 0, just so we can update the RRD with all required data sources
PHY_MEM_USD_ARWN_0=$(if [ -n "$ARWEN_NODE_0" ]; then echo "$((`echo $PS_OUTPUT | egrep arwen | egrep node-0 | awk '{print $5}'` / 1024 ))" ; else echo 0; fi)
PHY_MEM_USD_ARWN_1=$(if [ -n "$ARWEN_NODE_1" ]; then echo "$((`echo $PS_OUTPUT | egrep arwen | egrep node-1 | awk '{print $5}'` / 1024 ))" ; else echo 0; fi)

VIRT_MEM_USD_ARWN_0=$(if [ -n "$ARWEN_NODE_0" ]; then echo "$((`echo $PS_OUTPUT | egrep arwen | egrep node-0 | awk '{print $6}'` / 1024 ))" ; else echo 0; fi)
VIRT_MEM_USD_ARWN_1=$(if [ -n "$ARWEN_NODE_1" ]; then echo "$((`echo $PS_OUTPUT | egrep arwen | egrep node-1 | awk '{print $6}'` / 1024 ))" ; else echo 0; fi)



################ DATASET 9: ELROND NODE OPERATIONAL STATS ################
#
# DESCRIPTION: Here we're taking a health snapshot of each Elrond node process. This script assumes we have two nodes running on the same server, hence two node processes.

ELROND_NODE_0_STATUS_OUTPUT=$(curl -sSL http://localhost:8080/node/status )
ELROND_NODE_1_STATUS_OUTPUT=$(curl -sSL http://localhost:8081/node/status )
ELROND_NODE_0_HEARTBEAT_STATUS_OUTPUT=$(curl -sSL http://localhost:8080/node/heartbeatstatus )
ELROND_NODE_1_HEARTBEAT_STATUS_OUTPUT=$(curl -sSL http://localhost:8081/node/heartbeatstatus )

ELROND_NODE_0_BLS=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_public_key_block_sign )
ELROND_NODE_1_BLS=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_public_key_block_sign )

N0_CURRENT_ROUND=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_current_round )
N0_SYNCED_ROUND=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_synchronized_round )
N0_SHARD_ID=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_shard_id | head -c2 )
N0_EPOCH_NUMBER=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_epoch_number )
N0_CONNECTED_PEERS=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq .data.metrics.erd_num_connected_peers )
N0_ACTIVE_VALID=$(echo $ELROND_NODE_0_HEARTBEAT_STATUS_OUTPUT | jq '.' | grep peerType | grep -c -v observer )
N0_ACTIVE_OBS=$(echo $ELROND_NODE_0_HEARTBEAT_STATUS_OUTPUT | jq '.' | grep peerType | grep -c observer )
N0_ALL_NODES_SEEN=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq .data.metrics.erd_connected_nodes )
N0_CNT_CONSENSUS=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_count_consensus )
N0_CONS_ACPT_BLCKS=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_count_consensus_accepted_blocks )
N0_COUNT_LEADER=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_count_leader )
N0_ACCEPTED_BLOCKS=$(echo $ELROND_NODE_0_STATUS_OUTPUT | jq -r .data.metrics.erd_count_accepted_blocks )

N1_CURRENT_ROUND=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_current_round )
N1_SYNCED_ROUND=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_synchronized_round )
N1_SHARD_ID=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_shard_id | head -c2 )
N1_EPOCH_NUMBER=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_epoch_number )
N1_CONNECTED_PEERS=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq .data.metrics.erd_num_connected_peers )
N1_ACTIVE_VALID=$(echo $ELROND_NODE_1_HEARTBEAT_STATUS_OUTPUT | jq '.' | grep peerType | grep -c -v observer )
N1_ACTIVE_OBS=$(echo $ELROND_NODE_1_HEARTBEAT_STATUS_OUTPUT | jq '.' | grep peerType | grep -c observer )
N1_ALL_NODES_SEEN=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq .data.metrics.erd_connected_nodes )
N1_CNT_CONSENSUS=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_count_consensus )
N1_CONS_ACPT_BLCKS=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_count_consensus_accepted_blocks )
N1_COUNT_LEADER=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_count_leader )
N1_ACCEPTED_BLOCKS=$(echo $ELROND_NODE_1_STATUS_OUTPUT | jq -r .data.metrics.erd_count_accepted_blocks )



################ ROUND-ROBIN DATABASE UPDATE ################
#
# DESCRIPTION: Here we are feeding all data points collected by the script during the current run into a RRD, as a snapshot.
#
# SYNTAX EXAMPLE: rrdtool update /home/user/DATABASE.rrd [-t datasource1:datasource2] N:$VAR1:$VAR2

rrdtool update $RRD_LOCATION N:$CPU_USER_ALLCORES:$CPU_USER_CORE_0:$CPU_USER_CORE_1:$CPU_USER_CORE_2:$CPU_USER_CORE_3:$CPU_USER_CORE_4:$CPU_USER_CORE_5:$CPU_USER_CORE_6:$CPU_USER_CORE_7:$CPU_TOTAL_ALLCORES:$CPU_TOTAL_CORE_0:$CPU_TOTAL_CORE_1:$CPU_TOTAL_CORE_2:$CPU_TOTAL_CORE_3:$CPU_TOTAL_CORE_4:$CPU_TOTAL_CORE_5:$CPU_TOTAL_CORE_6:$CPU_TOTAL_CORE_7:$TEMP_CPUZONE_0:$TEMP_CPUZONE_1:$TEMP_CPUZONE_2:$TEMP_CPUZONE_3:$TASKS_ALL:$TASKS_RUNNING:$TASKS_SLEEPING:$TASKS_STOPPED:$TASKS_ZOMBIE:$MEMORY_TOTAL_MB:$MEMORY_USED_MB:$MEMORY_CACHED_MB:$SWAP_TOTAL_MB:$SWAP_USED_MB:$SPACE_ROOT_PART_MB:$DB_SIZE_NODE_0_MB:$DB_SIZE_NODE_1_MB:$DISK_1_OPS_PER_SEC:$DISK_2_OPS_PER_SEC:$DISK_1_READ_KBS:$DISK_2_READ_KBS:$DISK_1_WRITE_KBS:$DISK_2_WRITE_KBS:$DISK_1_RD_ERR_RATE:$DISK_1_THROUGHPUT:$DISK_1_SPINUP_TIME:$DISK_1_SRTSTP_CNT:$DISK_1_REALLOC_SCTR:$DISK_1_SEEK_ERR_RT:$DISK_1_SEEK_TM_PERF:$DISK_1_PWR_ON_HRS:$DISK_1_SPIN_RTR_CNT:$DISK_1_PWR_CYCL_CNT:$DISK_1_PWROFF_RTRCT:$DISK_1_LD_CYCLE_CNT:$DISK_1_TEMP_C:$DISK_1_REALLOC_EVNT:$DISK_1_CUR_PEND_SCT:$DISK_1_OFFL_UNCORR:$DISK_1_UDMA_CRC_ERR:$DISK_2_RD_ERR_RATE:$DISK_2_THROUGHPUT:$DISK_2_SPINUP_TIME:$DISK_2_SRTSTP_CNT:$DISK_2_REALLOC_SCTR:$DISK_2_SEEK_ERR_RT:$DISK_2_SEEK_TM_PERF:$DISK_2_PWR_ON_HRS:$DISK_2_SPIN_RTR_CNT:$DISK_2_PWR_CYCL_CNT:$DISK_2_PWROFF_RTRCT:$DISK_2_LD_CYCLE_CNT:$DISK_2_TEMP_C:$DISK_2_REALLOC_EVNT:$DISK_2_CUR_PEND_SCT:$DISK_2_OFFL_UNCORR:$DISK_2_UDMA_CRC_ERR:$EGRESS_PPS:$INGRESS_PPS:$EGRESS_MBPS:$INGRESS_MBPS:$PHY_MEM_USD_N0:$PHY_MEM_USD_N1:$VIRT_MEM_USD_N0:$VIRT_MEM_USD_N1:$PHY_MEM_USD_ARWN_0:$PHY_MEM_USD_ARWN_1:$VIRT_MEM_USD_ARWN_0:$VIRT_MEM_USD_ARWN_1:$N0_CURRENT_ROUND:$N0_SYNCED_ROUND:$N0_SHARD_ID:$N0_EPOCH_NUMBER:$N0_CONNECTED_PEERS:$N0_ACTIVE_VALID:$N0_ACTIVE_OBS:$N0_ALL_NODES_SEEN:$N0_CNT_CONSENSUS:$N0_CONS_ACPT_BLCKS:$N0_COUNT_LEADER:$N0_ACCEPTED_BLOCKS:$N1_CURRENT_ROUND:$N1_SYNCED_ROUND:$N1_SHARD_ID:$N1_EPOCH_NUMBER:$N1_CONNECTED_PEERS:$N1_ACTIVE_VALID:$N1_ACTIVE_OBS:$N1_ALL_NODES_SEEN:$N1_CNT_CONSENSUS:$N1_CONS_ACPT_BLCKS:$N1_COUNT_LEADER:$N1_ACCEPTED_BLOCKS