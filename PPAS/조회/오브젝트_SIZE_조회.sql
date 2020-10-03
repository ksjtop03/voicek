#######################################################################################################
######################################### OBJECT SIZE 조회쿼리 ########################################
#######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                                        DATABASE SIZE 조회
---------------------------------------------------------------------------------------------------- */
select pg_size_pretty(pg_database_size('DB명')) as size;


/* ----------------------------------------------------------------------------------------------------
                                        TABLESPACE SIZE 조회
---------------------------------------------------------------------------------------------------- */
select spcname, pg_size_pretty(pg_tablespace_size(spcname)) from pg_tablespace;


/* ----------------------------------------------------------------------------------------------------
                                        SCHEMA SIZE 조회
---------------------------------------------------------------------------------------------------- */

select schema_name, pg_size_pretty(sum(table_size)::bigint) as "disk space",
(sum(table_size) / pg_database_size(current_database())) * 100  as "percent"
from (
select pg_catalog.pg_namespace.nspname as schema_name, pg_relation_size(pg_catalog.pg_class.oid) as table_size
from pg_catalog.pg_class
join pg_catalog.pg_namespace
on relnamespace = pg_catalog.pg_namespace.oid
) t 
group by schema_name
order by schema_name;

/* ----------------------------------------------------------------------------------------------------
                                        TABLE SIZE 조회
---------------------------------------------------------------------------------------------------- */
-- 1) SINGLE TABLE SIZE 조회
select pg_size_pretty(pg_total_relation_size('스키마명.테이블명')) as size;



-- 2) MANY TABLE SIZE(Including INDEX SIZE) 조회
SELECT
    table_name,
    pg_size_pretty(table_size) AS table_size,
    pg_size_pretty(indexes_size) AS indexes_size,
    pg_size_pretty(total_size) AS total_size
FROM (
    SELECT
        table_name,
        pg_table_size(table_name) AS table_size,
        pg_indexes_size(table_name) AS indexes_size,
        pg_total_relation_size(table_name) AS total_size
    FROM (
        SELECT ('"' || table_schema || '"."' || table_name || '"') AS table_name
        FROM information_schema.tables
        where table_schema not in ('pg_catalog','information_schema','sys') and table_name in ('테이블명','테이블명')
    ) AS all_tables
    ORDER BY table_name DESC
) AS pretty_sizes;


-- ※ 시스템 테이블까지 출력 ※
SELECT
    table_name,
    pg_size_pretty(table_size) AS table_size,
    pg_size_pretty(indexes_size) AS indexes_size,
    pg_size_pretty(total_size) AS total_size
FROM (
    SELECT
        table_name,
        pg_table_size(table_name) AS table_size,
        pg_indexes_size(table_name) AS indexes_size,
        pg_total_relation_size(table_name) AS total_size
    FROM (
        SELECT ('"' || table_schema || '"."' || table_name || '"') AS table_name
        FROM information_schema.tables
    ) AS all_tables
    ORDER BY total_size DESC
) AS pretty_sizes;


-- ※ 시스템 테이블 제외 출력 ※
SELECT
    table_name,
    pg_size_pretty(table_size) AS table_size,
    pg_size_pretty(indexes_size) AS indexes_size,
    pg_size_pretty(total_size) AS total_size
FROM (
    SELECT
        table_name,
        pg_table_size(table_name) AS table_size,
        pg_indexes_size(table_name) AS indexes_size,
        pg_total_relation_size(table_name) AS total_size
    FROM (
        SELECT ('"' || table_schema || '"."' || table_name || '"') AS table_name
        FROM information_schema.tables
        where table_schema not in ('pg_catalog','information_schema','sys')
    ) AS all_tables
    ORDER BY total_size DESC
) AS pretty_sizes;



-- 3) 개별 테이블 사이즈 조회

SELECT
    table_name,
    pg_size_pretty(table_size) AS table_size,
    pg_size_pretty(indexes_size) AS indexes_size,
    pg_size_pretty(total_size) AS total_size
FROM (
    SELECT
        table_name,
        pg_table_size(table_name) AS table_size,
        pg_indexes_size(table_name) AS indexes_size,
        pg_total_relation_size(table_name) AS total_size
    FROM (
        SELECT ('"' || table_schema || '"."' || table_name || '"') AS table_name
        FROM information_schema.tables
        where table_schema not in ('pg_catalog','information_schema','sys') and table_name in ('테이블명')
    ) AS all_tables
    ORDER BY table_name DESC
) AS pretty_sizes;

/* ----------------------------------------------------------------------------------------------------
                                        INDEX SIZE 조회
---------------------------------------------------------------------------------------------------- */
select pg_relation_size('인덱스명');

\di+ 스키마명.인덱스명

