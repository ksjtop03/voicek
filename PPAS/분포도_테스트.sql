/* ----------------------------------------------------------------------------------------------------
                                           분포도 테스트
---------------------------------------------------------------------------------------------------- */

■ 분포도 테스트 목적
분포도가 우수한(중복 값이 적음) 컬럼으로 올바른 인덱스를 생성하여 성능향상을 가져오기 위함

실례로, 잘못된 복합인덱스를 사용하여(분포도가 좋지 않은 컬럼으로 복합 인덱스 생성..) 인덱스 컬럼 순서 변경(재배치)작업이 있었음


■ 인덱스 개념 정리

분포도가 넓다 = 분포도 값이 크다 = 분포도가 안 좋다   --> 중복 값이 많다   ex) 성별(남, 여)
분포도가 좁다 = 분포도 값이 작다 = 분포도가 좋다      --> 중복 값이 적다   ex) 출생지(서울,대전,대구,부산,인천,경기 등등)



보통 테이블에 자료가 100건이 있다고 가정해 보면,
데이터 값이 중복되는 것이 평균 15건을 넘으면 (15% 이상) 해당 필드를 가지고 인덱스를 만들면 오히려 수행 속도가 느려진다고 한다(--> 경험적인 수치)

이러한 경우 ( 이름, 나이, 성별 )의 순으로 인덱스를 생성하는 것이 좋다

분포도(selectivity)가 좋다는 것은 같은 키 값을 가지는 row의 수가 적다는 것을 의미하며
이는 인덱스를 통한 조회시에 DISK I/O량을 줄일 수 있고 또한 키 사이즈가 작으면 한 번의 DISK I/O로 많은 키 값을 Check할 수 있으므로
이것은 또한 DISK I/O 를 줄일 수 있는 효과를 가져 온다.

예를들어, '성별'이 맨앞에 위치하는 인덱스를 생성하면 총 데이터에서 1/2을 추출한 이후에
'나이'를 check하고 다음으로 '이름'을 check하므로 전체 데이터를 check(table full scan)하는 것보다 더 나은 것이 없는 결과를 초래한다

인덱스(INDEX)를 사용하는 것은
1) RANGE Scan이 가장 속도에 좋으며
2) 분포도(selectivity)는 "해당 컬럼의 전체 count수와 distinct 된 수와의 비율이다"
3) distinct 된 수라는 것은 "중복되지 않은 내용의 count 수" 이다

ex) A 컬럼 : 전체 건 수 100건, 값들은 모두 A, B, C의 3가지뿐일 경우
    B 컬럼 : 전체 건 수 100건, 값들은 모두 1, 2, 3, 4, 5, 6의 6가지일 경우
	
	분포도(selectivity)는 
	A 컬럼의 경우에는 : 3% (값 / 전체 건 수 : 3 / 100 * 100 )
	B 컬럼의 경우에는 : 6% (값 / 전체 건 수 : 6 / 100 * 100 )

하여 당연히 분포도는 B 컬럼이 좋다고 할 수 있고,
인덱스를 생성하더라도 더 좋은 성능을 보일 것이다.


■ 우수 분포도 선별 조건
아래 쿼리문 조회 결과 correlation 값이 -1 혹은 1에 가까울수록 분포도가 좋음

■ 쿼리문
\x  -- 가독성 좋은 출력결과를 위한 쿼리 수행 전 옵션

select schemaname, tablename, attname, correlation from pg_stats where tablename = '테이블명' and attname = '컬럼명';

■ 테스트

ex) 
-- 테이블명 : t_log_tracer
-- 컬럼명 : said
wavdb=# select schemaname, tablename, attname, correlation from pg_stats where tablename = 't_log_tracer' and attname = 'said';
-[ RECORD 1 ]-------------
schemaname  | wavdb
tablename   | t_log_tracer
attname     | said
correlation | 0.0899038


-- 테이블명 : t_log_tracer
-- 컬럼명 : seqno
wavdb=# select schemaname, tablename, attname, correlation from pg_stats where tablename = 't_log_tracer' and attname = 'seqno';
-[ RECORD 1 ]-------------
schemaname  | wavdb
tablename   | t_log_tracer
attname     | seqno
correlation | 0.429316


■ 결론 : 상기 두 컬럼의 correlation 조회 결과, seqno컬럼이 said컬럼보다 1에 더 가까우므로 분포도가 좀 더 좋다.



/* ----------------------------------------------------------------------------------------------------
                         인덱스 재설정 작업 (*이전 작업참고 : CRM19051742564)
---------------------------------------------------------------------------------------------------- */

-- 1) 삭제 전 INDEX 조회
\dS+ vital.topic_trend
\di+ vital.topic_trend_term_analysis_date_i

-- 2) 기존 INDEX 삭제 
DROP INDEX vital.topic_trend_term_analysis_date_i;  -- INDEX SIZE : 7081MB

\dS+ vital.topic_trend
\di+ vital.topic_trend_term_analysis_date_i

-- 3) INDEX 재생성 (테스트 시 약 53초 소요)
\di+ vital.topic_trend_term_analysis_date_i_01

CREATE INDEX topic_trend_term_analysis_date_i_01 ON vital.topic_trend(analysis_date, term);

\dS+ vital.topic_trend
\di+ vital.topic_trend_term_analysis_date_i_01

-- 4) vacuum full 수행 (물리메모리 : 16GB)
show maintenance_work_mem;
set maintenance_work_mem to '1.6GB';
show maintenance_work_mem;

VACUUM FULL VERBOSE vital.topic_trend;

-- 테이블 정보 갱신
ANALYZE VERBOSE vital.topic_trend;
