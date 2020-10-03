■ Explain
- 옵티마이저가 세우는 쿼리 실행 계획을 확인 가능
edb=# explain (ANALYZE true, VERBOSE true, COSTS true, BUFFERS true, TIMING true)

edb=# explain (ANALYZE true, VERBOSE true, COSTS true, BUFFERS true, TIMING true) select * from mytable where num = 10; 
QUERY PLAN ---------------------------------------------------------------------------------------------- 
Index Scan using mytable_pkey on public.mytable (cost=0.00..8.27 rows=1 width=22) 
(actual time=0.100..0.102 rows=1 loops=1) Output: num, name Index Cond: (mytable.num = 10) 
Buffers: shared hit=4 Total runtime: 0.138 ms (5 rows)

index scan 작업을 할 것이며, 비용은 8.27 정도 들고, 하나의 row가 나올 것 같고, 
그 row 자료를 추출하기 위한 공간이 22 정도 들고, 공유 메모리에 있는 버퍼 캐시를 4개 읽을 것으로 추정

explain option 중 timing true 옵션이 추가된 경우 plan이 길고 복잡한 쿼리의 경우 explain analyze를 하는 시간이 추가되므로 실제 쿼리 수행시간과 편차가 발생함. 
정확한 시간 추출을 위해 timing false 옵션 추가해야 함


explain 에서 ANALYZE를 사용할 경우 실제 쿼리가 실행 됨에 주의. 
데이터의 변경 없이 ANALYZE 옵션을 사용하고자 한다면 트랜잭션으로 처리하여 rollback 처리를 해야 함

Analyze
–옵티마이저가 올바른 쿼리 실행 계획을 세우기 위해 테이블의 통계 정보를 수집
–테이블 통계 정보를 수집하기 위해 Analyze 명령어를 사용하며 pg_stat_all_tables에 last analyze 정보 조회가 가능하며 pg_class에 실제 통계 정보들이 저장 됨(일반적으로 vacuum과 함께 사용)


데이터 삭제 작업의 경우,
삭제된 row 수가 실행계획과 pg_class에 반영이 되지 않음
하여 통계정보를 갱신하기 위해서는 반드시 

analyze 테이블명;  으로 갱신해야 함.

-- 결과확인
explain select * from 테이블명;
select reltuples from pg_class where relname='테이블명';


***주의) 반드시 DML 작업 실행계획 테스트를 할 경우에는
        트랜잭션으로 처리하여 쿼리 실행계획을 수행해야 한다.
		
ex) begin;
    explain analyze delete from jobhist;
	rollback;
	
	
