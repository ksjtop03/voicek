-- 데이터베이스, 테이블 OID 조회
select pg_relation_filepath('테이블명');

vanilla=# select pg_relation_filepath('tb_agnc_loyalty_trns');
 pg_relation_filepath
----------------------
 base/16422/31522069
(1 row)

