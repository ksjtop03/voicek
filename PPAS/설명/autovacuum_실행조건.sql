/* ----------------------------------------------------------------------------------------------------
                                            Autovacuum 실행 조건
---------------------------------------------------------------------------------------------------- */

vacuum threshold = vacuum (base) threshold (50) + vacuum scale factor(0.2) * number of tuples

update 되거나 delete된 rows 수가 vacuum threshold보다 커지면 autovacuum 수행된다.
예를들어 dept테이블이 4 rows 변동이 있으면, vacuum threshold 은 50.8 = 50 + 0.2 * 4이되며

update(or delete)가 51번 수행되면 vacuum threshold 50.8을 넘어서 autovacuum이 수행된다

autovacuum_* 으로 시작하는 환경 변수로 autovacuum on/off, 실행 주기, 작동 시점 등 조절 가능


*autovacuum: VACCUM Table_name (to prevent wraparound)라는 프로세스가 발생하는 지 확인해야 한다.
 만약 발생할 경우 명시적으로 VACCUM 작업 수행을 해야 데이터베이스가 안정적으로 운영될 수 있다.