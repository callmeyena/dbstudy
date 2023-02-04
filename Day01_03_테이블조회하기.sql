/*
        DQL
        1. Data Query Language
        2. 데이터 질의(조회) 언어
        3. 테이블의 데이터를 조회하는 언어이다.
        4. 테이블의 내용에 변경이 생기진 않는다
            (트랜잭션의 대상이 아니고, COMMIT이 필요하지 않다.)
            (트랜잭션 처리 대상: 내용이 바뀌는 작업:삽입, 수정, 삭제)
        5. 형식([] 는 생략가능)
            SELECT 조회할칼럼, 조화할칼럼, 조회할칼럼, ... 
            FROM 테이블 이름 
            (SELECT절, FROM절 각 절 별로 한 줄씩 쓰기)
            [WHERE 조건식]
            [GROUP BY 그룹화할칼럼 EX) 남/녀 [HAVINGR 그룹조건식 EX) 남/녀 중에 남자만 보겠다, 여자만 보겠다]]
            [ORDER BY 정렬할칼럼 정렬방식]
        6. 순서
            4번: SELECT 조회할칼럼, 조화할칼럼, 조회할칼럼, ... 
            1번: FROM 테이블 이름
            2번: [WHERE 조건식]
            3번: [GROUP BY 그룹화할칼럼 [HAVINGR 그룹조건식]]
            5번: [ORDER BY 정렬할칼럼 정렬방식 EX) 사원의 뭐 급여 높은 순 정렬, 입사일순, 순서대로 정렬]
*/

/*
    트랜잭션
    1. Transaction
    2. 여러 개의 세부 작업으로 구성 된 하나의 작업을 의미한다.
    3. 모든 세부 작업이 성공하면 COMMIT이라고 하고, 하나라도 실패하면 모든 세부 작업의 취소를 진행한다.
        (All or Nothing)
*/

-- 조회 실습.
-- 1. 사원 테이블에서 사원명 조회하기
-- 1) 기본 방식
SELECT ENAME 
  FROM EMP;

-- 2) 오너 명시하기(테이블을 가지고 있는 계정)
SELECT ENAME
  FROM SCOTT.EMP;

-- 3) 테이블 명시하기(칼럼을 가지고 있는 테이블)
SELECT EMP.ENAME
  FROM EMP;

-- 4) 테이블 별명 지정하기
SELECT E.ENAME
  FROM EMP E; -- EMP의 별명을 E 로 부여한다는 뜻. AS(ALIAS)를 사용할 수 없다.

-- 5) 칼럼 별명 지정하기
SELECT E.ENAME AS 사원명 --- E.NAME 칼럼의 별명을 '사원명'으로 부여한다. AS(ALIAS)를 사용할 수 있다.
  FROM EMP E;
  
  
  -- 2. 사원 테이블의 모든 칼럼 조회하기
  -- 1) * 활용하기(SELECT절에서 *는 모든 칼럼을 의미한다.)
SELECT *      -- 불려가기 싫으면 사용금지!
  FROM EMP;
    
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO 
  FROM EMP;

-- 3. 동일한 데이터는 한 번만 조회하기
--     DISTINCT
SELECT DISTINCT JOB
  FROM EMP;
  
  
-- 4. JOB이 MANAGER 사원목록 조회하기
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE JOB = 'MANAGER';
 
 
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE JOB IN('MANAGER');
   
   
-- 5. SAL이 1500 초과인 사원 목록 조회하기
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE SAL > 1500;

-- 6. SAL이 2000~2999 인 사원 목록 조회하기
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE SAL BETWEEN 2000 AND 2999;

-- 7. COMM을 받는 사원 목록 조회하기
--   1) NULL 이다  : IS NULL
--   2) NULL 아니다: IN NOT NULL
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
  FROM EMP
 WHERE COMM IS NOT NULL 
   AND COMM != 0;
   
-- 사원들만 급여 내림차순으로 사원명이랑 급여만 출력되게 쿼리 짜기
SELECT ENAME, SAL
FROM EMP
WHERE JOB = 'CLERK'
ORDER BY SAL ASC;

-- 8. ENAME이 A로 시작하는 사원 목록 조회하기
--  1) WILD CARD
--     (1) % : 글자 수 제한 없는 모든 문자 / %는 글자수를 가리지 않는다.
--     (2) _ : 1글자로 제한된 모든 문자
--  2) 연산자
--      1) LIKE     : WILD CARD를 포함한다.
--      2) NOT LIKE : WILD CARD를 포함하지 않는다.

SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO
FROM EMP
WHERE ENAME LIKE '%A%';

-- 급여가 2850 이상인 사원의 이름 및 급여를 표시하는 출력하라.
SELECT ENAME, SAL, JOB
  FROM EMP
 WHERE SAL >= 2850;

--5> 사원번호가 7566인 사원의 이름 및 부서번호를 출력하라
SELECT ENAME, DEPTNO
  FROM EMP
 WHERE EMPNO = 7566;
 
-- 6> 급여가 1500이상 ~ 2850이하의 범위에 속하지 않는 모든 사원의 이름 및 급여를 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE SAL NOT BETWEEN 1500 AND 2850; 

-- 7> 1981년 2월 20일 ~ 1981년 5월 1일에 입사한 사원의 이름,직업 및 입사일을 출력하라.
-- 입사일을 기준으로 해서 오름차순으로 정렬하라.
SELECT ENAME, JOB, HIREDATE
  FROM EMP
 WHERE HIREDATE BETWEEN '81/02/20' AND '81/05/01'
 ORDER BY HIREDATE ASC;

--8> 10번 및 30번 부서에 속하는 모든 사원의 이름과 부서 번호를 출력하되,
-- 이름을 알파벳순으로 정렬하여 출력하라.
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO IN(10, 30)
ORDER BY ENAME ASC;
 
-- 9> 10번 및 30번 부서에 속하는 모든 사원 중 급여가 1500을 넘는 사원의
-- 이름 및 급여를 출력하라.
-- (단 컬럼명을 각각 employee 및 Monthly Salary로 지정하시오)
/*
SELECT ENAME AS 'EMPLOYEE', SAL AS 'MONTHLONTHLY SALARY'
FROM EMP 
WHERE DEPTNO IN(10, 30)
  AND SAL <= 1500;
*/


