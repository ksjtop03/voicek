/* ----------------------------------------------------------------------------------------------------
                                          파라미터 관련
---------------------------------------------------------------------------------------------------- */

--컨피그 반영 시 
select setting,name,context from pg_settings where name ilike 'arch%';

**context확인
1)sighup --> 세션레벨이므로 reload로 적용할 수 있다(**주의!! pg_ctl reload가 아닌 쿼리로 설정변경할 것!!!)
2)postmaster --> DB 재부팅을 해야만 컨피그 반영됨



-- OS상에서 아카이브 파라미터값 설정 확인
psql -P pager=off -h /tmp -c "select name, setting, unit from pg_settings where name in ('max_connections', 'stats_temp_directory', 'checkpoint_segments', 'archive_mode', 'archive_command') order by name" 