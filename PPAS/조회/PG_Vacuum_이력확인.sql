/* ----------------------------------------------------------------------------------------------------
                                         PG vacuum 이력 확인
---------------------------------------------------------------------------------------------------- */

select relname, last_vacuum, last_autovacuum, last_analyze, last_autoanalyze from pg_stat_user_tables order by relname;