■ SQL 문장의 실행 원리와 내부 동작

-- 테이블의 oid, 물리적 파일과, PK여부, toast 여부 확인
select oid,relname,relfilenode,reltoastrelid,reltoastidxid,relhaspkey from pg_class where relname = '테이블명';

ex) select oid,relname,relfilenode,reltoastrelid,reltoastidxid,relhaspkey from pg_class where relname = 'mytable';

oid | relname | relfilenode | reltoastrelid | reltoastidxid | relhaspkey
-------+---------+-------------+---------------+---------------+------------
33060 | mytable | 33060 | 33063 | 0 | t

ex) select oid,relname,relfilenode,reltoastrelid,reltoastidxid,relhaspkey from pg_class where oid=33063;
oid | relname | relfilenode | reltoastrelid | reltoastidxid | relhaspkey
-------+----------------+-------------+---------------+---------------+------------
33063 | pg_toast_33060 | 33063 | 0 | 33065 | t


select oid,relname,relfilenode,reltoastrelid,reltoastidxid,relhaspkey from pg_class where oid=33065;

oid | relname | relfilenode | reltoastrelid | reltoastidxid | relhaspkey
-------+----------------------+-------------+---------------+---------------+------------
33065 | pg_toast_33060_index | 33065 | 0 | 0 | f

--> pg_toast_16402 테이블의 인덱스


3. mytable에는 기본키가 있기 때문에(pg_class.relhaspkey = ‘t’) 이 객체 확인
edb=# select oid,conname,conrelid,conindid from pg_constraint where conrelid = 33060;
oid | conname | conrelid | conindid
-------+--------------+----------+----------
33067 | mytable_pkey | 33060 | 33066

edb=# select oid,relname,relfilenode from pg_class where oid =33066;
oid | relname | relfilenode
-------+--------------+-------------
33066 | mytable_pkey | 33066
(1 row)

--> mytable_pkey라는 제약조건이며 33066 oid의 객체를 인덱스로 사용


각 객체들의 실제 물리적인 파일 위치 확인
edb=# select pg_relation_filepath('mytable');
pg_relation_filepath
----------------------
base/14313/33060

edb=# select pg_relation_filepath('pg_toast.pg_toast_33060');
pg_relation_filepath
----------------------
base/14313/33063

edb=# select pg_relation_filepath('pg_toast.pg_toast_33060_index');
pg_relation_filepath
----------------------
base/14313/33065

edb=# select pg_relation_filepath('mytable_pkey');
pg_relation_filepath
----------------------
base/14313/33066


