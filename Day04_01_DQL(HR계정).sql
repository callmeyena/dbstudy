-- 테이블 구조 파악
    DESC EMPLOYEES; -- DISCRIBE
    
-- 1. EMPLOYESS 테이블에서 FIRST_NAME, LAST_NAME 조회하기
SELECT FIRST_NAME, LAST_NAME  -- 칼럼에 별명 주는 방법 1. AS 2. 공백
  FROM EMPLOYEES; -- 오너를 명시하는 방법 => 이름이 너무 기니까 별명으로 작성 !! (공백)별명 !!
  
-- 2. EMPLOYEES 테이블에서 DEPARTMENT_ID를 중복 제거하고 조회하기
SELECT DISTINCT DEPARTMENT_ID
    FROM EMPLOYEES;
  
-- 3. EMPLOYEES 테이블에서 EMPLOYEE_ID가 150인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 150; -- WHERE절(조건)의 등호(=)는 비교 연산자이다.(자바로 따지면 == 와 같다.)

-- 4. EMPLOYEES 테이블에서 급여(SALARY)가 10000 ~ 20000 사이인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM EMPLOYEES
    WHERE SALARY BETWEEN 10000 AND 20000;

-- 5. EMPLOYEES 테이블에서 DEPARTMENT_ID가 30, 40, 50인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN(30, 40, 50);
    
-- 6. EMPLOYEES 테이블에서 DEPARTMENT_ID가 NULL인 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IS NULL;       -- IS NOT NULL => NULL이 아닌
    
-- 7. EMPLOYEES 테이블에서 PHONE_NUMBER가 '515'로 시작하는 사원 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '515%';       -- % 와일드 카드: 515 뒤에는 어떤 텍스트가 와도 OK BUT 등호를 사용할 수 없음 ! LIKE 연산자 사용 ! / '515_'도 사용 가능하나 _수 만큼 글자수 제한이 있다
                                       -- PHONE_NUMBER NOT LIKE '515%'
 
-- 8. EMPLOYEES 테이블을 FIRST_NAME의 가나다순(오름차순Asending Sort)으로 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 ORDER BY FIRST_NAME ASC;   -- ASC는 생략가능하다.
 
-- 9. EMPLOYEES 테이블을 높은 SALARY를 받는 사원순으로(내림차순Descending Sort) 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
  FROM EMPLOYEES
 ORDER BY SALARY DESC;      -- DESC는 생략이 불가능하다.
  
-- 10. EMPLOYEES 테이블의 사원들을 DEPARTMENT_ID순으로 조회하고, 동일한 DEPARTMENT_ID를 가진 사원들은 높은 SALARY순으로 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY AS SAL  -- 실행 순서로 공부하기,,,,,,,
  FROM EMPLOYEES
 ORDER BY DEPARTMENT_ID, SALARY DESC;  -- 생략했으면 무조건 오름차순 ASC !! DESC는 생략 불가니까 확인 두 번 하기~!