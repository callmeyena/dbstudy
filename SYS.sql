DROP USER GDJ61 CASCADE;
CREATE USER GDJ61 IDENTIFIED BY 1111;
GRANT DBA TO GDJ61;

-- DBA <<< CONNECT(접속권한), RESOURCE(자원권한)