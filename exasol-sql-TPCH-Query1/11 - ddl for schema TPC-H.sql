
OPEN SCHEMA tpch;

CREATE TABLE REGION (
    R_REGIONKEY DECIMAL(11,0),
    R_NAME      CHAR(25) UTF8,
    R_COMMENT   VARCHAR(152) UTF8
);

CREATE TABLE PART (
    P_PARTKEY     DECIMAL(11,0),
    P_NAME        VARCHAR(55) UTF8,
    P_MFGR        CHAR(25) UTF8,
    P_BRAND       CHAR(10) UTF8,
    P_TYPE        VARCHAR(25) UTF8,
    P_SIZE        DECIMAL(10,0),
    P_CONTAINER   CHAR(10) UTF8,
    P_RETAILPRICE DECIMAL(12,2),
    P_COMMENT     VARCHAR(23) UTF8,
    DISTRIBUTE BY P_PARTKEY
);

CREATE TABLE SUPPLIER (
    S_SUPPKEY   DECIMAL(11,0),
    S_NAME      CHAR(25) UTF8,
    S_ADDRESS   VARCHAR(40) UTF8,
    S_NATIONKEY DECIMAL(11,0),
    S_PHONE     CHAR(15) UTF8,
    S_ACCTBAL   DECIMAL(12,2),
    S_COMMENT   VARCHAR(101) UTF8,
    DISTRIBUTE BY S_SUPPKEY
);

CREATE TABLE PARTSUPP (
    PS_PARTKEY    DECIMAL(11,0),
    PS_SUPPKEY    DECIMAL(11,0),
    PS_AVAILQTY   DECIMAL(10,0),
    PS_SUPPLYCOST DECIMAL(12,2),
    PS_COMMENT    VARCHAR(199) UTF8,
    DISTRIBUTE BY PS_PARTKEY
);

CREATE TABLE CUSTOMER (
    C_CUSTKEY    DECIMAL(11,0),
    C_NAME       VARCHAR(25) UTF8,
    C_ADDRESS    VARCHAR(40) UTF8,
    C_NATIONKEY  DECIMAL(11,0),
    C_PHONE      CHAR(15) UTF8,
    C_ACCTBAL    DECIMAL(12,2),
    C_MKTSEGMENT CHAR(10) UTF8,
    C_COMMENT    VARCHAR(117) UTF8,
    DISTRIBUTE BY C_CUSTKEY
);

CREATE TABLE ORDERS (
    O_ORDERKEY      DECIMAL(11,0),
    O_CUSTKEY       DECIMAL(11,0),
    O_ORDERSTATUS   CHAR(1) UTF8,
    O_TOTALPRICE    DECIMAL(12,2),
    O_ORDERDATE     DATE,
    O_ORDERPRIORITY CHAR(15) UTF8,
    O_CLERK         CHAR(15) UTF8,
    O_SHIPPRIORITY  DECIMAL(10,0),
    O_COMMENT       VARCHAR(79) UTF8,
    DISTRIBUTE BY O_CUSTKEY
);

CREATE TABLE LINEITEM (
    L_ORDERKEY      DECIMAL(11,0),
    L_PARTKEY       DECIMAL(11,0),
    L_SUPPKEY       DECIMAL(11,0),
    L_LINENUMBER    DECIMAL(10,0),
    L_QUANTITY      DECIMAL(12,2),
    L_EXTENDEDPRICE DECIMAL(12,2),
    L_DISCOUNT      DECIMAL(12,2),
    L_TAX           DECIMAL(12,2),
    L_RETURNFLAG    CHAR(1) UTF8,
    L_LINESTATUS    CHAR(1) UTF8,
    L_SHIPDATE      DATE,
    L_COMMITDATE    DATE,
    L_RECEIPTDATE   DATE,
    L_SHIPINSTRUCT  CHAR(25) UTF8,
    L_SHIPMODE      CHAR(10) UTF8,
    L_COMMENT       VARCHAR(44) UTF8,
    DISTRIBUTE BY L_ORDERKEY
);

CREATE TABLE NATION (
    N_NATIONKEY DECIMAL(11,0),
    N_NAME      CHAR(25) UTF8,
    N_REGIONKEY DECIMAL(11,0),
    N_COMMENT   VARCHAR(152) UTF8
);

ALTER TABLE REGION ADD CONSTRAINT PK_REGION PRIMARY KEY(R_REGIONKEY) ENABLE;
ALTER TABLE PART ADD CONSTRAINT PK_PART PRIMARY KEY(P_PARTKEY) ENABLE;
ALTER TABLE SUPPLIER ADD CONSTRAINT PK_SUPPLIER PRIMARY KEY(S_SUPPKEY) ENABLE;
ALTER TABLE PARTSUPP ADD CONSTRAINT PK_PARTSUPP PRIMARY KEY(PS_PARTKEY, PS_SUPPKEY) ENABLE;
ALTER TABLE CUSTOMER ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY(C_CUSTKEY) ENABLE;
ALTER TABLE ORDERS ADD CONSTRAINT PK_ORDERS PRIMARY KEY(O_ORDERKEY) ENABLE;
ALTER TABLE LINEITEM ADD CONSTRAINT PK_LINEITEM PRIMARY KEY(L_ORDERKEY, L_LINENUMBER) ENABLE;
ALTER TABLE NATION ADD CONSTRAINT PK_NATION PRIMARY KEY(N_NATIONKEY) ENABLE;
ALTER TABLE SUPPLIER ADD CONSTRAINT FK_NATION FOREIGN KEY(S_NATIONKEY) REFERENCES NATION ENABLE;
ALTER TABLE PARTSUPP ADD CONSTRAINT FK_PART FOREIGN KEY(PS_PARTKEY) REFERENCES PART ENABLE;
ALTER TABLE PARTSUPP ADD CONSTRAINT FK_SUPP FOREIGN KEY(PS_SUPPKEY) REFERENCES SUPPLIER ENABLE;
ALTER TABLE CUSTOMER ADD CONSTRAINT FK_NATION FOREIGN KEY(C_NATIONKEY) REFERENCES NATION ENABLE;
ALTER TABLE ORDERS ADD CONSTRAINT FK_CUSTOMER FOREIGN KEY(O_CUSTKEY) REFERENCES CUSTOMER ENABLE;
ALTER TABLE LINEITEM ADD CONSTRAINT FK_ORDER FOREIGN KEY(L_ORDERKEY) REFERENCES ORDERS ENABLE;
ALTER TABLE LINEITEM ADD CONSTRAINT FK_PARTSUPP FOREIGN KEY(L_PARTKEY, L_SUPPKEY) REFERENCES PARTSUPP ENABLE;
ALTER TABLE NATION ADD CONSTRAINT FK_REGION FOREIGN KEY(N_REGIONKEY) REFERENCES REGION ENABLE;

FUNCTION "SUBSTRING" (QUELLE VARCHAR(25), BEGINN DECIMAL, LAENGE DECIMAL) 
RETURN VARCHAR(25) 
IS 
BEGIN 
  RETURN SUBSTR(QUELLE, BEGINN, LAENGE); 
END "SUBSTRING"
;

CREATE VIEW "LU_REGION" AS SELECT * FROM REGION
;

CREATE VIEW "FACT_ORDERS" (O_ORDERKEY, C_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE, O_ORDERPRIORITY, O_CLERK, O_SHIPPRIORITY, O_COMMENT) AS SELECT * FROM ORDERS
;

CREATE VIEW "LU_NATION" (N_NATIONKEY, N_NAME, R_REGIONKEY, N_COMMENT) AS SELECT * FROM NATION
;

CREATE VIEW "FACT_LINEITEM" (O_ORDERKEY, P_PARTKEY, S_SUPPKEY, L_LINENUMBER, L_QUANTITY, L_EXTENDEDPRICE, L_DISCOUNT, L_TAX, L_RETURNFLAG, L_LINESTATUS, L_SHIPDATE, L_COMMITDATE, L_RECEIPTDATE, L_SHIPINSTRUCT, L_SHIPMODE, L_COMMENT) AS SELECT * FROM LINEITEM
;

CREATE VIEW "LU_PART" (P_PARTKEY, P_NAME, P_MFGR, P_BRAND, P_TYPE, P_SIZE, P_CONTAINER, P_RETAILPRICE, P_COMMENT) AS SELECT * FROM PART
;

CREATE VIEW "LU_PARTSUPP" (P_PARTKEY, S_SUPPKEY, PS_AVAILQTY, PS_SUPPLYCOST, PS_COMMENT) AS SELECT * FROM PARTSUPP
;

CREATE VIEW "LU_CUSTOMER" (C_CUSTKEY, C_NAME, C_ADDRESS, N_NATIONKEY, C_PHONE, C_ACCTBAL, C_MKTSEGMENT, C_COMMENT) AS SELECT * FROM CUSTOMER
;

CREATE VIEW "LU_SUPPLIER" (S_SUPPKEY, S_NAME, S_ADDRESS, N_NATIONKEY, S_PHONE, S_ACCTBAL, S_COMMENT) AS SELECT * FROM SUPPLIER
;

COMMIT;