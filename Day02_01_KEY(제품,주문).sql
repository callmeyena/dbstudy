/*
    KEY 제약조건
    1. 기본키(PK: PRIMARY KEY)
        1) 개체무결성
        2) PK는 NOT NULL + UNIQUE 해야한다.
    2. 외래키(FK: FOREIGN KEY)
        1) 참조무결성
        2) FK는 참조하는 값만 가질 수 있다.    
*/

/*
    일대다(1:M) 관계
    1. PK와 FK를 가진 테이블 간의 관계
        1) 부모 테이블 : 1, 즉, PK를 가진 테이블
        2) 자식 테이블 : M, FK를 가진 테이블
    2. 생성과 삭제 규칙
        1) 생성 규칙 : "반드시" 부모 테이블을 먼저 생성한다.
        2) 삭제규칙  : "반드시" 자식 테이블을 먼저 삭제한다.
*/

-- 테이블 삭제/ 삭제를 몰아서 위쪽에 배치하고 생성을 몰아서 아래로 배치 한다. 생성은 A->B 삭제는 B->A
-- 생성(만드는 거) 먼저 하고 거꾸로 삭제 ㄱㄱ

DROP TABLE ORDER_TBL;
DROP TABLE PRODUCT_TBL;


-- 제품 테이블(부모 테이블)
-- DROP TABLE PRODUCT_TBL;
CREATE TABLE PRODUCT_TBL (
           PROD_NO NUMBER NOT NULL, -- PRIMARY KEY는 거의 항상 NOT NULL 명시함, NOT NULL 지워도 NOT NULL 실행 됨
           PROD_NAME VARCHAR2(10 BYTE),
           PROD_PRICE NUMBER,
           PROD_STOCK NUMBER,
           CONSTRAINT PROD_NO PRIMARY KEY(PROD_NO)
);

-- 주문 테이블(자식 테이블)
-- DROP TABLE ORDER_TBL; -- F5누르면 부모 테이블 먼저 DROP되기 때문에 에러 발생
CREATE TABLE ORDER_TBL (
    ORDER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(10 BYTE),
    PROD_NO NUMBER, -- PRODUCT 테이블의 PROD_NO 참조한다
    ORDER_DATE DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_NO),
    CONSTRAINT FK_ORDER_PROD FOREIGN KEY(PROD_NO) REFERENCES PRODUCT_TBL(PROD_NO)
);

/*
    제약조건 테이블
    1. SYS, SYSTEM 관리 계정으로 접속해서 확인한다.
    2. 종류
        1) ALL_CONSTRAINTS: 모든 제약조건 
        2) USER_CONSTRAINTS: 사용자 제약조건 EX) GDJ61
        3) DBA_CONSTRAINTS: 관리자 제약조건
*/

-- 테이블 구조 확인하는 쿼리문 (설명)
-- DESCRIBE ALL_CONSTRAINTS;

-- SELECT * FROM ALL_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'PK_%';



CONSTRAINT PK_ORDER
