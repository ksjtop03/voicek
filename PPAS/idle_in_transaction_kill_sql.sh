#/bin/bash

. /postgres/9.6/pg_env.sh

SQLFILE=/data/DBA/tool
LOGFILE=/data/DBA/tool/log/idle_in_transaction
FILE=/data/DBA/tool/log/idle_in_transaction/idle_in_transaction_session_info.log

psql -h /tmp  -c "select pid, client_addr, usename, case when wait_event_type = 'Lock' then 'W' else '' end as wait, case when state_change< now()+'-30sec' then 'L' end as Long, state, to_char(state_change, 'YYYY-MM-DD HH24:MI:SS') as state_change, to_char(now()- query_start, 'HH24:MI:SS:MS') as ELAPSE, left(replace(regexp_replace(regexp_replace(query,'\t|\r|\n',' ','g'),'\s\s*',' ','g'),'  ',' '),70) as query from pg_stat_activity  where state<>'idle' order by state_change asc" | sed '/row/d' | sed -e '2d' | grep "idle in transaction" | awk -F '|' '{print "  [DATE] : " "'"`date +%Y-%m-%d" "%H:%M:%S`"'" "\n" "  [PID]    :"$1"\n", " [CLIENT_IP] : " $2"\n", " [USERNAME] : " $3"\n", " [STATE] : "$6"\n",  " [QUERY] : "$9 "\n"}' >> $LOGFILE/idle_in_transaction_session_info.log 2>&1

cat $LOGFILE/idle_in_transaction_session_info.log | grep PID | awk '{print "SELECT","pg_terminate_backend("$3");"}' >> $SQLFILE/idle_in_transaction_pid_kill_list.sql

FILESIZE=`du $FILE | awk '{print $1}'`

if [ "$FILESIZE" -ne 0 ]
then
        echo "-------------------------------------------------" >> $LOGFILE/result.log
        echo " "idle in transaction Session Kill Info" "  >> $LOGFILE/result.log
        echo "-------------------------------------------------" >> $LOGFILE/result.log

        cat $LOGFILE/idle_in_transaction_session_info.log | egrep -i 'DATE|PID|CLIENT_IP|USERNAME|STATE|QUERY' >> $LOGFILE/result.log

        echo -e " [SESSION KILL RESULT] : " '\E[40;33m'"\033[1mOK\033[0m" >> $LOGFILE/result.log

        psql -h /tmp -c "\i $SQLFILE/idle_in_transaction_pid_kill_list.sql" >> $LOGFILE/result.log  2>&1
fi

find $LOGFILE/result.log -size +5M -type f -exec sed -i '1,1000d' $LOGFILE/result.log {} \;

cat /dev/null > $LOGFILE/idle_in_transaction_session_info.log
cat /dev/null > $SQLFILE/idle_in_transaction_pid_kill_list.sql