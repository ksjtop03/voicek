/* ----------------------------------------------------------------------------------------------------
                                          INDEX SCAN 조회 
---------------------------------------------------------------------------------------------------- */

■ INDEX SCAN 조회 목적
: (PK)인덱스 스캔 횟수 조회로 인덱스를 타는지 안타는지 확인하기 위함

■ 쿼리문
select * from pg_stat_all_indexes where relname = '테이블명';

■ 테스트 및 조회결과
ex) select * from pg_stat_all_indexes where relname = 't_log_tracer';

wavdb=# select * from pg_stat_all_indexes where relname = 't_log_tracer';
 relid  | indexrelid | schemaname |   relname    |    indexrelname    | idx_scan | idx_tup_read | idx_tup_fetch
--------+------------+------------+--------------+--------------------+----------+--------------+---------------
 263830 |     263984 | wavdb      | t_log_tracer | pk_t_log_tracer    |        0 |            0 |             0
 263830 |     264056 | wavdb      | t_log_tracer | t_log_tracer_idx01 |        0 |            0 |             0
 263830 |     264057 | wavdb      | t_log_tracer | t_log_tracer_idx02 |        0 |            0 |             0
 263830 |     264058 | wavdb      | t_log_tracer | t_log_tracer_idx03 |        4 |       961660 |        961660