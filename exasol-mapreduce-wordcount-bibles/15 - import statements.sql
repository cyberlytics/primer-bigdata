
ALTER TABLE "BIBLE"."key_english" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."t_ylt" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."key_genre_english" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."bible_version_key" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."t_dby" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."t_kjv" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."t_web" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."t_bbe" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."key_abbreviations_english" MODIFY PRIMARY KEY disable;
ALTER TABLE "BIBLE"."t_asv" MODIFY PRIMARY KEY disable;

TRUNCATE TABLE "BIBLE"."bible_version_key";
TRUNCATE TABLE "BIBLE"."key_abbreviations_english";
TRUNCATE TABLE "BIBLE"."key_english";
TRUNCATE TABLE "BIBLE"."key_genre_english";
TRUNCATE TABLE "BIBLE"."t_asv";
TRUNCATE TABLE "BIBLE"."t_bbe";
TRUNCATE TABLE "BIBLE"."t_dby";
TRUNCATE TABLE "BIBLE"."t_kjv";
TRUNCATE TABLE "BIBLE"."t_wbt";
TRUNCATE TABLE "BIBLE"."t_web";
TRUNCATE TABLE "BIBLE"."t_ylt";

IMPORT INTO "BIBLE"."bible_version_key" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\bible_version_key.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."key_abbreviations_english" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\key_abbreviations_english.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."key_english" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\key_english.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."key_genre_english" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\key_genre_english.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_asv" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_asv.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_bbe" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_bbe.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_dby" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_dby.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_kjv" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_kjv.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_wbt" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_wbt.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_web" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_web.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;
IMPORT INTO "BIBLE"."t_ylt" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\t_ylt.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;

IMPORT INTO "BIBLE"."stopwords_en" FROM LOCAL CSV FILE 'U:\data_cpn\Documents\OTH\_gitRepos\cyberlytics-primers\primer-bigdata\exasol-mapreduce-wordcount-bibles-dockerdesktopWSL2\data\stopwords_en.csv' SKIP = 1 ENCODING = 'UTF8' ROW SEPARATOR = 'CRLF' COLUMN SEPARATOR = ',' COLUMN DELIMITER = '"' REJECT LIMIT 0;


ALTER TABLE "BIBLE"."key_english" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."t_ylt" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."key_genre_english" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."bible_version_key" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."t_dby" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."t_kjv" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."t_web" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."t_bbe" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."key_abbreviations_english" MODIFY PRIMARY KEY enable;
ALTER TABLE "BIBLE"."t_asv" MODIFY PRIMARY KEY enable;


CREATE OR REPLACE TABLE "BIBLE".allbibles
AS
SELECT * FROM (
SELECT 'asv' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_asv" UNION ALL
SELECT 'bbe' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_bbe" UNION ALL
SELECT 'dby' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_dby" UNION ALL
SELECT 'kjv' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_kjv" UNION ALL
SELECT 'wbt' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_wbt" UNION ALL
SELECT 'web' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_web" UNION ALL
SELECT 'ylt' AS bible, "b", "c", "id", "t", "v" FROM "BIBLE"."t_ylt"
);

commit;