/* ----------------------------------------------------------------------------------------------------
                            PPAS/PostgreSQL logging스크립트 백그라운드 실행
---------------------------------------------------------------------------------------------------- */

-- 1) logging 백그라운드 수행
nohup /data/DBA/tool/logging.pl -t 시간 -d DB명 -p 포트 -l 로깅경로 & 
ex) nohup /data/DBA/tool/logging.pl -t 60 -d gigabeacon -p 5444 -l /data/DBA/tool/log & 

-- 2) track 백그라운드 수행
nohup /data/DBA/tool/track.pl -d DB명 -t 시간 -f 로깅경로 & 
ex) nohup /data/DBA/tool/track.pl -d plany -t 60 -f /data/DBA/tool/log/track/track & 

