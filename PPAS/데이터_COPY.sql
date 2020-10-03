■ 대량의 데이터를 Load하기 위해서 Copy 명령어 사용
- export : \copy 테이블명 to '경로/파일명';
- import : \copy 테이블명 from '경로/파일명';

-- export할 테이블 데이터 확인
\copy (select empno from empno = '1') to '/tmp/emp.csv';

-- export 실행
\copy emp to '/tmp/emp.txt' delimiter '|' null '\N' encoding 'utf8';


-- 파일생성 확인
\! cat /tmp/emp.txt;

-- import 실행할 테스트 테이블 생성
create table emp_tmp as select * from emp limit 0;

-- import 실행
\copy emp_tmp from '/tmp/emp.txt' delimiter '|' null '\N' encoding 'utf8';

select * from emp_tmp;

-----------------------------------------------------------------------------

■ Copy와 OS명령어를 같이 쓸 수 있는 부가 옵션 기능을 9.3부터 지원
- 데이터의 크기가 클 경우 압축, split 명령과 같이 사용할 경우 유용

*import : \copy 테이블명 to PROGRAM '명령어';
*export : \copy 테이블명 from PROGRAM '명령어';

ex) 
\copy employees to PROGRAM 'gzip > /tmp/hr.emp.gz'
\! ls -l /tmp/hr.emp.gz
