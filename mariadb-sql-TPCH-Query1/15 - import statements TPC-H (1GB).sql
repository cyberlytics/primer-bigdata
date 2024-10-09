set autocommit=0;
SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE TPCH.nation;
TRUNCATE TABLE TPCH.region;
TRUNCATE TABLE TPCH.part;
TRUNCATE TABLE TPCH.supplier;
TRUNCATE TABLE TPCH.partsupp;
TRUNCATE TABLE TPCH.customer;
TRUNCATE TABLE TPCH.orders;
TRUNCATE TABLE TPCH.lineitem;

LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.nation.csv'   INTO TABLE TPCH.nation   FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.region.csv'   INTO TABLE TPCH.region   FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.part.csv'     INTO TABLE TPCH.part     FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.supplier.csv' INTO TABLE TPCH.supplier FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.partsupp.csv' INTO TABLE TPCH.partsupp FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.customer.csv' INTO TABLE TPCH.customer FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.orders.csv'   INTO TABLE TPCH.orders   FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;
LOAD DATA INFILE 'U:\\data_cpn\\Documents\\OTH\\_gitRepos\\cyberlytics-primers\\primer-bigdata\\exasol-sql-TPCH-Query1\\tpch_1g.lineitem.csv' INTO TABLE TPCH.lineitem FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' IGNORE 1 LINES;

commit;