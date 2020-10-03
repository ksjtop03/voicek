-- 베큠정보
select * from pg_stat_all_tables where schemaname = '스키마명';

** vacuum 후에도 oid는 바뀌지 않으며,
   vacuum full 시에는 새로운 파일로 객체가 다시 생성되는데 이때에도 oid는 그대로이고 relfilenode 값만 바뀐다. ( vacuum full 실행 시에는 pg_class의 relfilenode 값이 변경된다 )

-- 물리적인 파일위치 확인 ( relfilenode 값은 디스크에 저장되는 파일명과 동일하며 아래 쿼리로 물리적인 파일의 위치를 찾을 수 있다. )
select oid, pg_relation_filepath(oid), relname, relfilenode from pg_class limit 10;