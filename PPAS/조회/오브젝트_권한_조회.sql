#######################################################################################################
######################################### OBJECT 권한 조회쿼리 ########################################
#######################################################################################################

alter table 스키마.테이블명 owner to 계정명;


/* ----------------------------------------------------------------------------------------------------
                                        SCHEMA 권한 조회
---------------------------------------------------------------------------------------------------- */
select * from pg_namespace where nspname = '스키마명';


/* ----------------------------------------------------------------------------------------------------
                                          TABLE 권한 조회
---------------------------------------------------------------------------------------------------- */
-- 1) 테이블명으로 권한 조회
select grantor, grantee, table_schema "schema_name", table_name, privilege_type from information_schema.role_table_grants where table_name = '테이블명';
ex) select grantor, grantee, table_schema "schema_name", table_name, privilege_type from information_schema.role_table_grants where table_name = 't_log_tracer';

-- 2) 계정별 권한 조회
select * from information_schema.role_table_grants where grantee = '권한부여받은 유저';
ex) select * from information_schema.role_table_grants where grantee = 'enterprisedb';

/* ----------------------------------------------------------------------------------------------------
                                        TABLE 권한 조회(TABLE OWNER 확인)
---------------------------------------------------------------------------------------------------- */
select * from pg_tables where tablename in('테이블명');

\dt+ 스키마명.테이블명


/* ----------------------------------------------------------------------------------------------------
                                        TABLE 권한 조회(TABLE OWNER 확인)
---------------------------------------------------------------------------------------------------- */





