/* ----------------------------------------------------------------------------------------------------
                                          계정(USER) 생성
---------------------------------------------------------------------------------------------------- */

CREATE ROLE 계정명 LOGIN ENCRYPTED PASSWORD '패스워드' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2099-12-31 00:00:00';

ex) CREATE ROLE bizsch LOGIN ENCRYPTED PASSWORD 'new1234!' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2099-12-31 00:00:00';


** 주의 : PPAS의 경우 계정생성 시 대,소문자를 구분하므로 대문자로 계정을 생성하게 될 경우 반드시 계정명 양쪽에 double quotation ""  를 넣어준다!! (double quotation 미포함 시 소문자로 인식)
ex) "METAAPP" 


/* ----------------------------------------------------------------------------------------------------
                                          계정 사용기간 변경
---------------------------------------------------------------------------------------------------- */

ALTER ROLE 계정명 LOGIN ENCRYPTED PASSWORD '패스워드' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL '2099-12-31 00:00:00';


/* ----------------------------------------------------------------------------------------------------
                                        계정생성+그룹롤 권한 부여
---------------------------------------------------------------------------------------------------- */

CREATE USER ttokdb PASSWORD '패스워드' IN ROLE 그룹롤명;
ex) CREATE USER ttokdb PASSWORD 'new1234!' IN ROLE b2b_DML;


/* ----------------------------------------------------------------------------------------------------
                                        사용자 추가된 그룹 롤 확인
---------------------------------------------------------------------------------------------------- */

select g.groname "grp_nm", g.grosysid "grp_id", u.usename "usr_nm", u.usesysid "user_id" 
from pg_auth_members a 
inner join pg_group g 
on a.roleid=g.grosysid 
inner join pg_user u 
on a.member=u.usesysid;




/* ----------------------------------------------------------------------------------------------------
                                    개인계정 삭제가 안될 시
---------------------------------------------------------------------------------------------------- */

reassign owned by voduser to enterprisedb;
drop owned by voduser;

drop role voduser;