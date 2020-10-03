/* ----------------------------------------------------------------------------------------------------
                         다수의 쿼리문들을 원하는 형식으로 출력하는 쿼리문
---------------------------------------------------------------------------------------------------- */

■ 목적
: 대량의 테이블 백업스크립트를 쿼리문(copy명령어로..)으로 쉽게 출력하여 공수를 줄이기 위함

■ 쿼리문
select '\copy '||schemaname||'.'||tablename||' to ''로그파일경로'||tablename||'.dat'' csv force quote *;' from pg_tables where schemaname='스키마명';

■ 테스트 및 결과
-- 테스트 전) 결과 로그파일로 남기기
\t        -- 순수 데이터 결과값만 출력(맨 위 컬럼X, 맨 아래 rows X)하는 옵션
\o 1.sql  -- 쿼리결과 파일로 출력
\o        -- 종료

-- 테스트)
select '\copy '||schemaname||'.'||tablename||' to ''/data/DBA/work/ksj/'||tablename||'.dat'' csv force quote *;' from pg_tables where schemaname='wavdb';

-- 결과)
wavdb=# select '\copy '||schemaname||'.'||tablename||' to ''/data/DBA/work/ksj/'||tablename||'.dat'' csv force quote *;' from pg_tables where schemaname='wavdb';
                                                          
 \copy wavdb.import_package_cate_xml_2 to '/data/DBA/work/ksj/import_package_cate_xml_2.dat' csv force quote *;
 \copy wavdb.ordr_pg to '/data/DBA/work/ksj/ordr_pg.dat' csv force quote *;
 \copy wavdb.vod_atchmnfl to '/data/DBA/work/ksj/vod_atchmnfl.dat' csv force quote *;
 \copy wavdb.sales to '/data/DBA/work/ksj/sales.dat' csv force quote *;
 \copy wavdb.sales_q1_2019 to '/data/DBA/work/ksj/sales_q1_2019.dat' csv force quote *;
 \copy wavdb.vod_perm_ip to '/data/DBA/work/ksj/vod_perm_ip.dat' csv force quote *;
 \copy wavdb.vod_mngr to '/data/DBA/work/ksj/vod_mngr.dat' csv force quote *;
