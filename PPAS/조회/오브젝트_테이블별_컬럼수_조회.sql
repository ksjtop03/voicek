/* ----------------------------------------------------------------------------------------------------
                                          테이블별 컬럼 수 조회
---------------------------------------------------------------------------------------------------- */
 
-- 테이블별 컬럼 수 조회 ( 조회조건 : 컬럼 수 내림차 순 정렬 )
select distinct object_name "TABLE_NAME", object_type "OBJECT_TYPE", object_schema "SCHEMA_NAME",count(object_type) "COLUMN_COUNT" 
from information_schema.data_type_privileges 
where object_schema = '스키마명' and object_type = 'TABLE'  
group by 1, 2, 3 
order by "COLUMN_COUNT" desc;


ex) select distinct object_name "TABLE_NAME", object_type "OBJECT_TYPE", object_schema "SCHEMA_NAME",count(object_type) "COLUMN_COUNT" from information_schema.data_type_privileges where object_schema = 'wavdb' and object_type = 'TABLE'  group by 1, 2, 3 order by "COLUMN_COUNT" desc;

           TABLE_NAME            | OBJECT_TYPE | SCHEMA_NAME | COLUMN_COUNT
---------------------------------+-------------+-------------+--------------
 import_le_xml_back              | TABLE       | wavdb       |           49
 import_le_xml                   | TABLE       | wavdb       |           47
 import_ps_xml_back              | TABLE       | wavdb       |           36
 import_ps_xml                   | TABLE       | wavdb       |           35
 ordr_pg                         | TABLE       | wavdb       |           35
 import_package_xml_back         | TABLE       | wavdb       |           28
 import_package_xml              | TABLE       | wavdb       |           27
 import_pc_xml_back              | TABLE       | wavdb       |           26
 import_pc_xml                   | TABLE       | wavdb       |           25
 t_epg_ta_info_bk                | TABLE       | wavdb       |           25
 t_epg_ta_info                   | TABLE       | wavdb       |           24
 t_epg_om_info_bk                | TABLE       | wavdb       |           23
 t_epg_om_info                   | TABLE       | wavdb       |           22
 t_epg_ad_info_bk                | TABLE       | wavdb       |           18
 t_epg_ad_info                   | TABLE       | wavdb       |           17
 t_epg_ad_song_info_bk           | TABLE       | wavdb       |           17
 t_epg_ad_song_info              | TABLE       | wavdb       |           16
 vod_brdcst_schdul               | TABLE       | wavdb       |           16
 t_app_master_from_appstore_back | TABLE       | wavdb       |           15
 t_app_master_from_dbs_back      | TABLE       | wavdb       |           15
 t_app_master_from_appstore      | TABLE       | wavdb       |           14
 t_app_master_from_dbs           | TABLE       | wavdb       |           14
 t_trigger_info                  | TABLE       | wavdb       |           14
 vod_mngr                        | TABLE       | wavdb       |           14
 vod_optn                        | TABLE       | wavdb       |           14
 t_bdi_info                      | TABLE       | wavdb       |           12

 
 
 
-- 개별 테이블의 컬럼 수 조회
select distinct object_name "TABLE_NAME", object_type "OBJECT_TYPE", object_schema "SCHEMA_NAME",count(object_type) "COLUMN_COUNT" 
from information_schema.data_type_privileges 
where object_schema = '스키마명' and object_type = 'TABLE' and object_name = '테이블명'
group by 1, 2, 3 
order by "COLUMN_COUNT" desc;

 TABLE_NAME | OBJECT_TYPE | SCHEMA_NAME | COLUMN_COUNT
------------+-------------+-------------+--------------
 sales      | TABLE       | wavdb       |            5
(1개 행)






-- 컬럼 목록 조회
-- 1) 전체 스키마 내 테이블 모든 컬럼 조회
select table_schema, table_name, column_name, data_type from information_schema.columns
where table_schema = 'wavdb'
order by ordinal_position;

select table_schema , table_name , column_name, character_maximum_length from information_schema.columns where table_name in ('테이블명'); 


-- 2) 테이블 단위 컬럼 조회
select table_schema, table_name, column_name, data_type from information_schema.columns
where table_schema = '스키마명'
and table_name = '테이블명'
order by ordinal_position;

ex) 
select table_schema, table_name, column_name, data_type from information_schema.columns
where table_schema = 'wavdb'
and table_name = 'sales'
order by ordinal_position;

 table_schema | table_name | column_name |          data_type
--------------+------------+-------------+-----------------------------
 wavdb        | sales      | dept_no     | numeric
 wavdb        | sales      | part_no     | character varying
 wavdb        | sales      | country     | character varying
 wavdb        | sales      | date        | timestamp without time zone
 wavdb        | sales      | amount      | numeric
(5개 행)

