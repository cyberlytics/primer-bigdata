set autocommit=0;

CREATE USER 'TPCUSER' IDENTIFIED BY 'TPCUSER';
GRANT USAGE ON *.* TO 'TPCUSER'@'%' IDENTIFIED BY 'TPCUSER';
SHOW GRANTS FOR 'TPCUSER'@'%';

commit;
