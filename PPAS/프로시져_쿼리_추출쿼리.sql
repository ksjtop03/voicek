#######################################################################################################
#########################################  프로시져 쿼리 추출  ########################################
#######################################################################################################

/* ----------------------------------------------------------------------------------------------------
                                     프로시져(PROCEDURE) 쿼리 추출
---------------------------------------------------------------------------------------------------- */
psql -h /tmp DB명 -t -c "select text from user_source where name = upper('프로시저명');" > 1.sql
ex) psql -h /tmp wavdb -t -c "select text from user_source where name = upper('sp_sdk_auth_stat_daily');" > 1.sql

*프로시저명 확인 : \df+ 스키마명.xx

-------------------------------------------------------------------------------------------------------
-- cat 1.sql 추출 결과

 CREATE OR REPLACE FUNCTION wavdb2.sp_sdk_auth_stat_daily(p_yyyymmdd text)
  RETURNS integer
  LANGUAGE plpgsql
 AS $function$

 /******************************************************************************
     내용      : FIDO SDK 인증 통계
                            (시간별, 일별, 월별 통계 생성)

     INPUT 변수:
         P_YYYYMMDD              : 년월일 YYYYMMDD
     OUT 변수:
         P_RESULT_VALUE  : 성공(1)/실패(0)

    변경내역:
    -- 2018.07.09 : 최초 작성

    테스트:  select sp_sdk_auth_stat_daily('20180709') AS P_RESULT_VALUE
 ******************************************************************************/
 DECLARE
     p_return_value integer;
     p_row_count integer;
 BEGIN

     IF $1 IS NULL OR TRIM($1) = '' THEN
         SELECT 0 INTO p_return_value;
         RETURN p_return_value;
         END IF;

         -- 시간별 통계 데이터 생성
     SELECT sp_sdk_time_auth_stat($1) INTO p_row_count;

     IF p_row_count > 0 THEN
         -- 일자별 통계 데이터 생성
         SELECT 0 INTO p_row_count;
                 SELECT sp_sdk_day_auth_stat($1) INTO p_row_count;

         IF p_row_count > 0 THEN
                 -- 월별 통계 데이터 생성
             SELECT sp_sdk_month_auth_stat($1) INTO p_return_value;
         END IF;
     END IF;

         SELECT 1 INTO p_return_value;
     RETURN p_return_value;

 END;

 $function$

 CREATE OR REPLACE FUNCTION wavdb.sp_sdk_auth_stat_daily(p_yyyymmdd text)
  RETURNS integer
  LANGUAGE plpgsql
 AS $function$

 /******************************************************************************
     내용      : FIDO SDK 인증 통계
                            (시간별, 일별, 월별 통계 생성)

     INPUT 변수:
         P_YYYYMMDD              : 년월일 YYYYMMDD
     OUT 변수:
         P_RESULT_VALUE  : 성공(1)/실패(0)

    변경내역:
    -- 2018.07.09 : 최초 작성

    테스트:  select sp_sdk_auth_stat_daily('20180709') AS P_RESULT_VALUE
 ******************************************************************************/
 DECLARE
     p_return_value integer;
     p_row_count integer;
 BEGIN

     IF $1 IS NULL OR TRIM($1) = '' THEN
         SELECT 0 INTO p_return_value;
         RETURN p_return_value;
         END IF;

         -- 시간별 통계 데이터 생성
     SELECT sp_sdk_time_auth_stat($1) INTO p_row_count;

     IF p_row_count > 0 THEN
         -- 일자별 통계 데이터 생성
         SELECT 0 INTO p_row_count;
                 SELECT sp_sdk_day_auth_stat($1) INTO p_row_count;

         IF p_row_count > 0 THEN
                 -- 월별 통계 데이터 생성
             SELECT sp_sdk_month_auth_stat($1) INTO p_return_value;
         END IF;
     END IF;

         SELECT 1 INTO p_return_value;
     RETURN p_return_value;

 END;

 $function$
-------------------------------------------------------------------------------------------------------