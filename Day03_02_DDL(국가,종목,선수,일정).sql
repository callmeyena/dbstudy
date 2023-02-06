-- 기본키 제거하기
alter table nation_tbl
    drop primary key;           -- 테이블의 기본키는 오직 1개이므로 제약조건의 이름을 몰라도 삭제할 수 있다.
alter table event_tbl
    drop primary key;
alter table plaryer_tbl
    drop primary key;
alter table schedule_tbl
    drop primary key;

-- 기본키 추가하기
alter table nation_tbl
    add constraint pk_nation primary key(n_code);
alter table event_tbl
    add constraint pk_event primary key(e_code);
alter table player_tbl
    add constraint pk_player primary key(p_code);
alter table schedule_tbl
    add constraint pk_schedule primary key(s_no);
        
-- 외래키 제거하기
alter table player_tbl
    drop constraint fk_player_nation;
alter table player_tbl
    drop constraint fk_player_event;
alter table schedule_tbl
    drop constraint fk_schedule_nation;
alter table schedule_tbl
    drop constraint fk_schedule_event;
    
-- 외래키 추가하기
alter table player_tbl
    add constraint fk_player_nation foreign key(n_code)
        references nation_tbl(n_code)
            on delete cascade;
alter table player_tbl
    add constraint fk_player_event foreign key(e_code)
        references event_tbl(e_code)
            on delete cascade;
alter table schedule_tbl
    add constraint fk_schedule_nation foreign key(n_code)
        references nation_tbl(n_code)
            on delete set null;     -- on delete cascade도 가능하다.
alter table schedule_tbl
    add constraint fk_schedule_event foreign key(e_code)
        references event_tbl(e_cdoe)
            on delete set null;     -- on delete cascade도 가능하다.
            
-- 연습. nation_tbl의 기본키 제거하기
-- 외래키(FK)에 의해서 참조 중인 기본키(PK)는 "반드시" 외래키를 먼저 삭제해야 한다.
alter table player_tbl
    drop constraint fk_player_nation;
alter table schedule_tbl
    drop constraint fk_schedule_nation;
alter table nation_tbl
    drop primary key;          

-- 외래키 제약 조건 일시 중지(비활성화)
alter table player_tbl
    disable constraint fk_player_event;
    
-- 외래키 제약 조건 다시 시작(활성화)
alter table player_tbl
    enable constraint fk_player_event;