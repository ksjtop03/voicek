#######################################################################################################
######################################### PARTITION 테이블 조회 #######################################
#######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                                        PARTITION 테이블 조회
---------------------------------------------------------------------------------------------------- */

select c.relname "partition table",h.inhparent::regclass " parent table" from pg_class c inner join pg_inherits h on(c.oid=h.inhrelid);


--파티션 테이블 제약조건 확인
select  c.relname as "Partition Table" 
,h.inhparent::regclass as "parent table",b.usename as "OWNER",z.column_name as "Constraint Key",y.data_type as "TYPE"
,d.consrc as "Constraint check"
from pg_class c
inner join pg_inherits h on(c.oid = h.inhrelid)
inner join pg_user b on(c.relowner= b.usesysid)
inner join pg_constraint d on(c.relfilenode = d.conrelid and d.consrc is not null)
inner join information_schema.constraint_column_usage z on (c.relname = z.table_name)
inner join information_schema.columns y on
(z.column_name = y.column_name and z.table_name = y.table_name and z.table_schema = y.table_schema)
order by c.relname; 


--파티션테이블
select  h.inhparent::regclass as "parent_table", (''||b.nspname || '.' || c.relname||'') as "partition_table" from pg_class c inner join pg_inherits h on(c.oid = h.inhrelid)
 join pg_namespace b on b.oid = c.relnamespace
 order by partition_table; 
 
  
--파티션테이블
SELECT nmsp_parent.nspname AS parent_schema, parent.relname AS parent, max(child.relname) as relname, count(*)
FROM pg_inherits JOIN pg_class parent ON pg_inherits.inhparent = parent.oid JOIN pg_class child ON pg_inherits.inhrelid = child.oid JOIN pg_namespace nmsp_parent ON nmsp_parent.oid = parent.relnamespace JOIN pg_namespace nmsp_child ON nmsp_child.oid = child.relnamespace
group by parent_schema, parent
order by parent_schema, parent, relname; 

-- 파티션 테이블 조회(부모/자식 schema 포함)
SELECT pn.nspname || '.' || p.relname AS parent,
 (''||cn.nspname ||'.'||c.relname||'') AS child
FROM pg_inherits
JOIN pg_class AS c ON (inhrelid=c.oid)
JOIN pg_class as p ON (inhparent=p.oid)
JOIN pg_namespace pn ON pn.oid = p.relnamespace
JOIN pg_namespace cn ON cn.oid = c.relnamespace
order by 1, 2; 




-- oracle 방식 조회
select table_owner,schema_name , table_name , partition_name , high_value from dba_tab_partitions where table_name in ('accum_rat_info_hmcm2m');

-- postgres 방식 조회
SELECT pn.nspname AS schema_parent, p.relname AS parent, cn.nspname AS schema_child, c.relname AS child
FROM pg_inherits 
JOIN pg_class AS c ON (inhrelid=c.oid)
JOIN pg_class as p ON (inhparent=p.oid)
JOIN pg_namespace pn ON pn.oid = p.relnamespace
JOIN pg_namespace cn ON cn.oid = c.relnamespace
where p.relname = 'accum_rat_info_hmcm2m'
order by 2, 4 ;




============================================================================================


-- 파티션 테이블 조회 (전체)
select u.usename as "owner"
	 , h.inhparent::regclass as "table"
     , c.relname as "partition"
	 , case when ((position('<' in t.consrc) = 0 and position('>' in t.consrc) = 0) or position('<>' in t.consrc) <> 0) then 'list'
	        else 'range'
	   end as "partition_type"
	 , case when (tri.tgisinternal = 't') then 'oracle'
			when (tri.tgisinternal = 'f') then 'inherit'
	   end "create_type"
 from pg_class c, pg_inherits h, pg_user u, pg_constraint t, pg_trigger tri
where 1=1
  and c.oid = h.inhrelid
  and c.oid = t.conrelid
  and h.inhparent = tri.tgrelid
  and u.usesysid = c.relowner
  and t.consrc is not null
  and c.relname not ilike '%null%'
  --and ((tri.tgisinternal = 'f' and tri.tgconstrrelid = 0)
  -- or (tri.tgisinternal = 't' and tri.tgconstrrelid = 0))
order by h.inhparent asc, c.relname asc, partition_type asc;

-- 파티션 테이블 조회 (최소, 최대값)
select u.usename as "owner"	 
	 , h.inhparent::regclass as "table"
	 , case when ((position('<' in t.consrc) = 0 and position('>' in t.consrc) = 0) or position('<>' in t.consrc) <> 0) then 'list'
	        else 'range'
	   end as "partition_type"
	 , min(c.relname) as "min_value"
	 , max(c.relname) as "max_value"
	 , case when (tri.tgisinternal = 't') then 'oracle'
			when (tri.tgisinternal = 'f') then 'inherit'
	   end "create_type"	 
 from pg_class c, pg_inherits h, pg_user u, pg_constraint t, pg_trigger tri
where 1=1
  and c.oid = h.inhrelid
  and c.oid = t.conrelid
  and h.inhparent = tri.tgrelid  
  and u.usesysid = c.relowner
  and t.consrc is not null
  and c.relname not ilike '%null%'
  --and ((tri.tgisinternal = 'f' and tri.tgconstrrelid = 0)
  -- or (tri.tgisinternal = 't' and tri.tgconstrrelid = 0))
group by u.usename, h.inhparent, partition_type, create_type
	   --, tri.tgisinternal
order by h.inhparent asc;





============================================================================================







##파티션 테이블 삭제
alter table 부모테이블 drop partition 자테이블;
alter table api_clng_hist drop partition par_201802;





