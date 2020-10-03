#######################################################################################################
######################################### OBJECT 기타 조회쿼리 ########################################
#########################################      SCHEMA 조회      #######################################
#######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                        Lists all foreign keys in the database 조회
---------------------------------------------------------------------------------------------------- */
select specific_schema,specific_name,routine_schema,routine_name,routine_type from information_schema.routines where routine_schema in ('테이블명'); 

ex) select specific_schema,specific_name,routine_schema,routine_name,routine_type from information_schema.routines where routine_schema in ('wavdb');
 specific_schema |         specific_name         | routine_schema |      routine_name      | routine_type
-----------------+-------------------------------+----------------+------------------------+--------------
 wavdb           | sp_sdk_auth_stat_daily_278773 | wavdb          | sp_sdk_auth_stat_daily | FUNCTION
(1개 행)



/* ----------------------------------------------------------------------------------------------------
                                   List all check constraints 조회
---------------------------------------------------------------------------------------------------- */
select * from information_schema.check_constraints where constraint_schema = '스키마명'

ex ) wavdb=# select * from information_schema.check_constraints where constraint_schema = 'wavdb'
 constraint_catalog | constraint_schema |     constraint_name      |    check_clause
--------------------+-------------------+--------------------------+---------------------
 wavdb              | wavdb             | 263696_263818_1_not_null | back_no IS NOT NULL
 wavdb              | wavdb             | 263696_263697_4_not_null | PRO_SEQ IS NOT NULL

 
 
/* ----------------------------------------------------------------------------------------------------
                                    List all of the sequence 조회
---------------------------------------------------------------------------------------------------- */
select * from information_schema.sequences where sequence_schema = '스키마명';
 
ex ) wavdb=# select * from information_schema.sequences where sequence_schema = 'wavdb';
 sequence_catalog | sequence_schema |     sequence_name     | data_type | numeric_precision | numeric_precision_radix | numeric_scale | start_value | minimum_value |    maximum_value    | increment | cycle_option
------------------+-----------------+-----------------------+-----------+-------------------+-------------------------+---------------+-------------+---------------+---------------------+-----------+--------------
 wavdb            | wavdb           | seq_vod_atchmnfl      | bigint    |                64 |                       2 |             0 | 1           | 1             | 9223372036854775807 | 1         | NO
 wavdb            | wavdb           | seq_vod_brdcst_schdul | bigint    |                64 |                       2 |             0 | 1           | 1             | 9223372036854775807 | 1         | NO
 wavdb            | wavdb           | seq_vod_goods         | bigint    |                64 |                       2 |             0 | 1           | 1             | 9223372036854775807 | 1         | NO
 wavdb            | wavdb           | seq_vod_optn          | bigint    |                64 |                       2 |             0 | 1           | 1             | 9223372036854775807 | 1         | NO
 wavdb            | wavdb           | seq_vod_sopmal_server | bigint    |                64 |                       2 |             0 | 1           | 1             | 9223372036854775807 | 1         | NO
(5개 행)


/* ----------------------------------------------------------------------------------------------------
                                        List all triggers 조회
---------------------------------------------------------------------------------------------------- */

ex ) wavdb=# select * from information_schema.triggers;
 trigger_catalog | trigger_schema | trigger_name | event_manipulation | event_object_catalog | event_object_schema | event_object_table | action_order | action_condition | action_statement | action_orientation | action_timing | action_reference_old_table | action_reference_new_table | action_reference_old_row | action_reference_new_row | created
-----------------+----------------+--------------+--------------------+----------------------+---------------------+--------------------+--------------+------------------+------------------+--------------------+---------------+----------------------------+----------------------------+--------------------------+--------------------------+---------
(0개 행)

 

/* ----------------------------------------------------------------------------------------------------
                                    List all views in the database 조회
---------------------------------------------------------------------------------------------------- */
select * from information_schema.views where table_schema = '스키마명';

ex) wavdb=# select * from information_schema.views limit 2;
 table_catalog | table_schema | table_name |                                            view_definition                                             | check_option | is_updatable | is_insertable_into | is_trigger_updatable | is_trigger_deletable | is_trigger_insertable_into
---------------+--------------+------------+--------------------------------------------------------------------------------------------------------+--------------+--------------+--------------------+----------------------+----------------------+----------------------------
 wavdb         | pg_catalog   | pg_shadow  |  SELECT pg_authid.rolname AS usename,                                                                 +| NONE         | NO           | NO                 | NO                   | NO                   | NO
               |              |            |     pg_authid.oid AS usesysid,                                                                        +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolcreatedb AS usecreatedb,                                                             +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolcreatedblink AS usecreatedblink,                                                     +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolcreatepublicdblink AS usecreatepublicdblink,                                         +|              |              |                    |                      |                      |
               |              |            |     pg_authid.roldroppublicdblink AS usedroppublicdblink,                                             +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolsuper AS usesuper,                                                                   +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolreplication AS userepl,                                                              +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolbypassrls AS usebypassrls,                                                           +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolpassword AS passwd,                                                                  +|              |              |                    |                      |                      |
               |              |            |     (pg_authid.rolvaliduntil)::abstime AS valuntil,                                                   +|              |              |                    |                      |                      |
               |              |            |     pg_authid.rolaccountstatus AS useaccountstatus,                                                   +|              |              |                    |                      |                      |
               |              |            |     (pg_authid.rollockdate)::abstime AS uselockdate,                                                  +|              |              |                    |                      |                      |
               |              |            |     (pg_authid.rolpasswordexpire)::abstime AS usepasswordexpire,                                      +|              |              |                    |                      |                      |
               |              |            |     s.setconfig AS useconfig                                                                          +|              |              |                    |                      |                      |
               |              |            |    FROM (pg_authid                                                                                    +|              |              |                    |                      |                      |
               |              |            |      LEFT JOIN pg_db_role_setting s ON (((pg_authid.oid = s.setrole) AND (s.setdatabase = (0)::oid))))+|              |              |                    |                      |                      |
               |              |            |   WHERE pg_authid.rolcanlogin;                                                                         |              |              |                    |                      |                      |

 
 
 
 
/* ----------------------------------------------------------------------------------------------------
                                    List all privileges on columns 조회
---------------------------------------------------------------------------------------------------- */
select * from information_schema.column_privileges where table_schema = '스키마명';
 
ex) wavdb=# select * from information_schema.column_privileges where table_schema = 'wavdb' limit 2;
  grantor   | grantee | table_catalog | table_schema | table_name |    column_name    | privilege_type | is_grantable
------------+---------+---------------+--------------+------------+-------------------+----------------+--------------
 wavdb_user | PUBLIC  | wavdb         | wavdb        | ordr_pg    | dps_pam_amt       | INSERT         | NO
 wavdb_user | PUBLIC  | wavdb         | wavdb        | ordr_pg    | dps_conf_msg_sbst | REFERENCES     | NO
(2개 행)

 
/* ----------------------------------------------------------------------------------------------------
                                    List all privileges on functions 조회
---------------------------------------------------------------------------------------------------- */
select * from information_schema.role_routine_grants where specific_schema = '스키마명'; 

ex) wavdb=# select * from information_schema.role_routine_grants where specific_schema = 'wavdb';
   grantor    |   grantee    | specific_catalog | specific_schema |         specific_name         | routine_catalog | routine_schema |      routine_name      | privilege_type | is_grantable
--------------+--------------+------------------+-----------------+-------------------------------+-----------------+----------------+------------------------+----------------+--------------
 enterprisedb | PUBLIC       | wavdb            | wavdb           | sp_sdk_auth_stat_daily_278773 | wavdb           | wavdb          | sp_sdk_auth_stat_daily | EXECUTE        | NO
 enterprisedb | enterprisedb | wavdb            | wavdb           | sp_sdk_auth_stat_daily_278773 | wavdb           | wavdb          | sp_sdk_auth_stat_daily | EXECUTE        | YES
(2개 행)

 
 
/* ----------------------------------------------------------------------------------------------------
                                    List all of the table privileges 조회
---------------------------------------------------------------------------------------------------- */
select * from information_schema.role_table_grants where table_schema = '스키마명';


ex) wavdb=# select * from information_schema.role_table_grants where table_schema = 'wavdb';
   grantor    |    grantee    | table_catalog | table_schema |           table_name            | privilege_type | is_grantable | with_hierarchy
--------------+---------------+---------------+--------------+---------------------------------+----------------+--------------+----------------
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | INSERT         | YES          | NO
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | SELECT         | YES          | YES
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | UPDATE         | YES          | NO
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | DELETE         | YES          | NO
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | TRUNCATE       | YES          | NO
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | REFERENCES     | YES          | NO
 enterprisedb | enterprisedb  | wavdb         | wavdb        | import_package_cate_xml_2       | TRIGGER        | YES          | NO
 wavdb_user   | wavdb_user    | wavdb         | wavdb        | ordr_pg                         | INSERT         | YES          | NO
 wavdb_user   | wavdb_user    | wavdb         | wavdb        | ordr_pg                         | SELECT         | YES          | YES


 
 


-- OBJECT TYPE (테이블 X)
select distinct object_name "TABLE_NAME", object_type "OBJECT_TYPE", object_schema "SCHEMA_NAME" from information_schema.data_type_privileges where object_schema = '스키마명' and object_type <> 'TABLE'  group by 1, 2, 3;
ex) select distinct object_name "TABLE_NAME", object_type "OBJECT_TYPE", object_schema "SCHEMA_NAME" from information_schema.data_type_privileges where object_schema = 'wavdb' and object_type <> 'TABLE'  group by 1, 2, 3;
 
           TABLE_NAME           | OBJECT_TYPE | SCHEMA_NAME
-------------------------------+-------------+-------------
 sp_sdk_auth_stat_daily_278773 | ROUTINE     | wavdb
(1개 행)

 
 
 
 