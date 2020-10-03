/* ----------------------------------------------------------------------------------------------------
                                     파라미터 값(postgresql.conf) 조회
---------------------------------------------------------------------------------------------------- */

-- 1) 전체 파라미터 값 조회
select name , setting , unit , context , sourcefile from pg_settings;

-- 2) 일부 파라미터 값 조회
select name , setting , unit , context , sourcefile from pg_settings where name in ( 'shared_buffers','work_mem','maintenance_work_mem','max_connections','edb_dynatune'); 

-- 3) 아카이브관련 파라미터 조회
select name,setting from pg_settings where name like 'archive%';