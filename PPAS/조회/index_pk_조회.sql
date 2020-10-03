-- index
select tablename, indexname, indexdef from pg_indexes where schemaname = 'iotown' order by tablename, indexname;

-- pk
select schema_name,constraint_name, table_name, index_name, constraint_def from dba_constraints where schema_name IN ('IOTOWN') order by table_name;