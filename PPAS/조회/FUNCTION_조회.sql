/* ----------------------------------------------------------------------------------------------------
                                            FUNCTION 조회
---------------------------------------------------------------------------------------------------- */

select pg_get_functiondef(p.oid) as src
from pg_proc p join pg_namespace n on p.pronamespace = n.oid
where n.nspname<>'pg_catalog'
and n.nspname<>'information_schema'
and p.proname in ('FUNCTION명'); 

ex)
select pg_get_functiondef(p.oid) as src
from pg_proc p join pg_namespace n on p.pronamespace = n.oid
where n.nspname<>'pg_catalog'
and n.nspname<>'information_schema'
and p.proname in ('if_kos_cont_bas_ins'); 




-- FUNCTION 권한 확인
select grantor, grantee , specific_schema, specific_name, routine_schema , routine_name , privilege_type 
from information_schema.routine_privileges 
where routine_schema = 'familybox' and routine_name like '%imd_push_queue01%';



