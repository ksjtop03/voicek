#######################################################################################################
######################################### OBJECT 기타 조회쿼리 ########################################
############################################    FK 조회     ###########################################
#######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                                      FK(Foreign KEY) 조회
---------------------------------------------------------------------------------------------------- */
--방법_1)
select * from pg_constraint where contype = 'f';


--방법_2) 해당 쿼리의 경우 테스트 해 볼 것! 

select tc.table_name AS child_table,
kcu.column_name AS child_column,
ccu.table_name AS foreign_table,
ccu.column_name AS foreign_column
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu on tc.constraint_name::text = kcu.constraint_name::text
join information_schema.constraint_column_usage ccu on ccu.constraint_name::text = tc.constraint_name::text
where tc.constraint_type = 'FOREIGN KEY';
