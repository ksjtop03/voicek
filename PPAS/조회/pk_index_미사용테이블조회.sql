-- pk, index 미사용 테이블 조회

select c.table_schema, c.table_name, c.table_type
from information_schema.tables c
where c.table_schema IN('iotown') AND c.table_type = 'BASE TABLE'
AND NOT EXISTS(SELECT i.tablename
from pg_catalog.pg_indexes i
where i.schemaname = c.table_schema
and i.tablename = c.table_name and indexdef like '%UNIQUE%')
and not exists (select cu.table_name
from information_schema.key_column_usage cu
where cu.table_name = c.table_name)
order by c.table_schema, c.table_name;