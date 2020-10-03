######################################################################################################
#########################################      권한 부여      ########################################
######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                                        데이터베이스 권한 부여
---------------------------------------------------------------------------------------------------- */

-- 사용자에게 모든권한부여하기
grant all privileges on database DB명 to 계정명;

-- 계정에 DB 로그인 권한 추가하기
alter role splunk with login;

/* ----------------------------------------------------------------------------------------------------
                                        스키마 권한 부여 및 삭제
---------------------------------------------------------------------------------------------------- */
-- 1) 권한 부여
grant usage on schema 스키마명 to 유저명;                    -- 스키마를 사용할 수 있도록 권한부여

grant all on schema 스키마명 to 유저명;                      -- 해당 스키마에 모든 권한 부여
grant select on all tables in schema 스키마명 to "계정명";   -- 해당 스키마에 select 권한만 부여

-->select * from pg_namespace where nspname = '스키마명'; 으로 확인가능
all로 권한으로 부여하게 되면 UC(usage, create)


-- 2) 권한 삭제
revoke usage on schema 스키마명 from "계정명";

revoke select on all tables in schema 스키마명 from "계정명";


/* ----------------------------------------------------------------------------------------------------
                                        테이블 소유자 부여
---------------------------------------------------------------------------------------------------- */
ALTER TABLE 테이블명 OWNER TO 유저명;
ex) ALTER TABLE ctfl.melon OWNER TO ksj;

/* ----------------------------------------------------------------------------------------------------
                                        테이블 권한 부여
---------------------------------------------------------------------------------------------------- */

grant select on all tables in schema 스키마명 to 유저명;

grant select, insert, delete, update on all tables in schema 스키마명 to 유저명;
ex) grant select, insert, delete, update on all tables in schema ibaf to ibaf;


grant all on TB_TMP_20200109_01 to "A82058465";

/* ----------------------------------------------------------------------------------------------------
                                        시퀀스 권한 부여 및 삭제
---------------------------------------------------------------------------------------------------- */

grant all on all sequences in schema 스키마명 to 유저명;

revoke all on all sequences in schema 스키마명 from 유저명;


/* ----------------------------------------------------------------------------------------------------
                                        FUNCTION 권한 부여/해제
---------------------------------------------------------------------------------------------------- */

--권한부여
grant all on all functions in schema 스키마명 to 유저명;

--권한해제
revoke function on all tables in schema 스키마명 from 유저명;

revoke all on all functions in schema 스키마명 from 유저명;


/* ----------------------------------------------------------------------------------------------------
                                        VIEW 권한 부여 및 삭제
---------------------------------------------------------------------------------------------------- */

■ view 조회
  \dvS+ view명

■ view 권한부여
  1) view에 모든권한 부여
  GRANT ALL ON splunk_temp_v_dtl TO 계정명;
  ex) GRANT ALL ON splunk_temp_v_dtl TO splunk;
  
  2) view에 select 권한만 부여
  ex) GRANT SELECT ON splunk_temp_v_dtl TO splunk;


■ view 권한해제
  1) view에 모든권한 해제
  REVOKE ALL ON splunk_temp_v_dtl FROM 계정명;
  ex) REVOKE ALL ON splunk_temp_v_dtl FROM splunk;
  
  2) view에 select 권한만 부여
  ex) REVOKE SELECT ON splunk_temp_v_dtl FROM splunk;

/* ----------------------------------------------------------------------------------------------------
                                    alter default privileges 권한부여 및 삭제
---------------------------------------------------------------------------------------------------- */
**해당 명령어(alter default privileges)로 권한을 부여하게 될 경우, 기존 오브젝트에 대한 권한은 부여되지 않고 권한부여 이후에 생성된 오브젝트 생성 건에 대해서만 권한부여가 적용 됨

--권한 부여
alter default privileges in schema 스키마명 grant insert, select, update, delete on tables to 계정명; 

ex)alter default privileges in schema ksj grant insert, select, update, delete on tables to test; 
->상기 쿼리를 해석하면 ksj스키마에 대해 test라는 계정이 테이블에 대한 DML권한을 이후 오브젝트 생성건부터 적용한다는 말

-- alter default privileges로 권한부여할 경우 해당 오브젝트 권한 조회
\ddp

--권한 해제
alter default privileges in schema 스키마명
revoke all on all tables in schema 스키마명 from 유저명;


--권한삭제
revoke all on all tables in schema 스키마명 from 유저명;




alter default privileges in schema 스키마명
revoke all on all sequences in schema 스키마명 from 유저명;

alter default privileges in schema 스키마명
revoke all on all functions in schema 스키마명 from 유저명;
