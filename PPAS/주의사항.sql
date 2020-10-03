/* ----------------------------------------------------------------------------------------------------
                                           주의 사항
---------------------------------------------------------------------------------------------------- */

■ 파라미터 적용관련 ( 주의 !!! )
-hba.conf : 맨 위의 파라미터값이 적용
-postgresql.conf : 맨 마지막 파라미터값이 적용



■ postgres에서 kill -9는 절대사용하지 말 것!!
-> kill -9를 사용하여 하나의 하위 프로세스를 죽이면 부모프로세스가 모든 자식프로세스를 죽이므로 PID가 변경된다.
   그러므로 PID를 죽일때는 반드시 kill [PID]로 죽인다
   만약 kill [PID]로 프로세스가 죽지 않는다면 여러번 시도해본 후 그래도 죽지 않는다면 DB장애는 아니므로 OS행, 디스크장애, 네트워크 이슈 등의 이슈이다!
  
*수많은 프로세스가 죽어도 postgres프로세스만 살아도 DB는 살아있다


■ 일전에 회의 시 요청 하신 Postgresql 내 Vacuum process 기본 정책 내용 공유 드립니다.
 
1. Autovacuum 의 종류
    vacuum : 불필요해진 공간을 재사용 하기 위한 내부 I/O (defrag) 
                    => autovacuum: VACUUM [TableName]
					
    analyze : 통계 정보를 갱신하기 위해 테이블 변동 정보 수집 
                    => autovacuum: ANALYZE [TableName]
 
2. Autovacuum 수행 식
    vacuum 동작 임계치 =   autovacuum_vacuum_threshold + (autovacuum_vacuum_scale_factor * number of tuples)
    analyze 동작 임계치 =   autovacuum_analyze_threshold + (autovacuum_analyze_scale_factor * number of tuples)
 
 
3. 통합쿠폰 작업을 통한 확인
    vacuum 동작 임계치  : 50+(0.2*62924900) = 12585030.0    # 총 튜플 수는 아래 표 참고 : 배포파일업로드내역(wdstr_file_upld_txn)
    => 삭제가 12,585,030건 초과 할 때 마다 실행됨
 
    analyze 동작 임계치  :  50+(0.1*62924900) = 6292540.0   # 총 튜플 수는 아래 표 참고 : 배포파일업로드내역(wdstr_file_upld_txn)
    => 삭제가 6,292,540건 초과 할 때 마다 실행됨
 
[통합쿠폰 DB Server Info.]
- 통합쿠폰 DB Autovacuum 설정값
-[ RECORD 1 ]----------------------------
name    | autovacuum
setting | on
-[ RECORD 2 ]----------------------------
name    | autovacuum_analyze_scale_factor
setting | 0.1
-[ RECORD 3 ]----------------------------
name    | autovacuum_analyze_threshold
setting | 50
-[ RECORD 4 ]----------------------------
name    | autovacuum_freeze_max_age
setting | 200000000
-[ RECORD 5 ]----------------------------
name    | autovacuum_max_workers
setting | 9
-[ RECORD 6 ]----------------------------
name    | autovacuum_naptime
setting | 60
-[ RECORD 7 ]----------------------------
name    | autovacuum_vacuum_cost_delay
setting | 20
-[ RECORD 8 ]----------------------------
name    | autovacuum_vacuum_cost_limit
setting | -1
-[ RECORD 9 ]----------------------------
name    | autovacuum_vacuum_scale_factor
setting | 0.2
-[ RECORD 10 ]---------------------------
name    | autovacuum_vacuum_threshold
setting | 50
 
- 배포파일업로드내역(wdstr_file_upld_txn) 테이블의 3/23 통계내역
pcpdb=# select * from pg_stat_all_tables where relname='wdstr_file_upld_txn';
-[ RECORD 1 ]-----+---------------------------------
relid             | 102110
schemaname        | pcpdb
relname           | wdstr_file_upld_txn
seq_scan          | 1928778
seq_tup_read      | 5704209379
idx_scan          | 30338599553
idx_tup_fetch     | 160912106636
n_tup_ins         | 64189087
n_tup_upd         | 117580879
n_tup_del         | 72014318
n_tup_hot_upd     | 11098357
n_live_tup        | 44937997
n_dead_tup        | 7244
last_vacuum       | 03-MAR-17 05:11:47.207441 +09:00
last_autovacuum   | 20-MAR-18 07:16:09.460362 +09:00 
last_analyze      | 03-MAR-17 05:11:55.454461 +09:00
last_autoanalyze  | 20-MAR-18 03:55:33.75766 +09:00
vacuum_count      | 1
autovacuum_count  | 21
analyze_count     | 1
autoanalyze_count | 27

-------------------------------------------------------------------------


■ 만약 하기와 같이 pg_catalog. pg_attribute 토탈사이즈가 클 경우 해당 부분은 테이블?이 삭제와 생성을 반복하여 발생한 bloating값이 쌓이는 것이다
ex)플랫폼인프라팀 소속 당시 GiGA지오펜싱 서비스가 해당 이슈로 주기적으로 테이블 rename 작업 했었음
                          table_name                          | table_size | indexes_size | total_size

--------------------------------------------------------------+------------+--------------+------------
 "pg_catalog"."pg_attribute"                                  | 606 GB     | 456 GB       | 1062 GB

wrap arround, vacuum에서 사용



■ 대량 데이터 insert 혹은 delete 시 exclusive lock이 걸리므로 반드시 윗단의 web/was를 차단하고 vacuum full 작업이 필요!!!
  상기 내용 작업 시 session level에서 maintenance_work_mem 사이즈 늘려서 수행필요!!
  
  
  
  
  
  
  
  
  
  
  