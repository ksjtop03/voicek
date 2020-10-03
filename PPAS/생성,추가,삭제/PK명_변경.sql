alter index 스키마명.기존PK명 rename to 변경할PK명;
ex) alter index iotown.pk_setl_item_calc_sumry rename to setl_item_calc_sumry_pk;



-- 아래 방법으로도 변경되는 것으로 확인되는데 위 쿼리문과 비교해볼 것!!!
alter table 테이블명 rename CONSTRAINT 기존 PK명 to 변경할 PK명;
ex) alter table familybox.bulk_push_master rename CONSTRAINT bulk_push_master_pkey to pk_bulk_push_master;
