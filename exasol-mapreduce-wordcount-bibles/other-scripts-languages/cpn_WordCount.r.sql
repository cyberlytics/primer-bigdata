/* ------------------------------------------- */
/* Testing Data */
/* ------------------------------------------- */

CREATE OR REPLACE TABLE text_table_small (textblock VARCHAR(2000000));
INSERT INTO text_table_small VALUES ('aaa bb');
INSERT INTO text_table_small VALUES ('bb c');
SELECT textblock FROM text_table_small;

SELECT COUNT(textblock) AS "#rows"
     , ROUND(AVG(CHARACTER_LENGTH(textblock)),2) AS "avg_charlength_of_row"
     , SUM(CHARACTER_LENGTH(textblock)) AS "#characters"
  FROM text_table_small;


CREATE OR REPLACE VIEW text_table_large AS SELECT L_COMMENT AS textblock FROM TPCH_1G.LINEITEM;

SELECT COUNT(textblock) AS "#rows" -- #rows = 6.001.215
     , ROUND(AVG(CHARACTER_LENGTH(textblock)),2) AS "avg_charlength_of_row"
     , SUM(CHARACTER_LENGTH(textblock)) AS "#characters"
  FROM text_table_large; -- takes about 0.4 sec

/* ------------------------------------------- */
/* MAP */
/* ------------------------------------------- */

CREATE OR REPLACE R SCALAR SCRIPT
r_map_words(in_text VARCHAR(2000000))
EMITS (mapped_word CHAR(99)) AS
run <- function (ctx) {
	if (is.na(ctx$in_text)){return(NA)}
	v_chars <- unlist(strsplit(ctx$in_text, "\\s+"))
	ctx$emit(v_chars)
}
;
SELECT COUNT(*) AS "#words" FROM (
	SELECT r_map_words(textblock) FROM text_table_small
);
SELECT COUNT(*) AS "#words" FROM (
	SELECT r_map_words(textblock) FROM text_table_large
); -- takes about 46 sec on sandbox

CREATE OR REPLACE R SET SCRIPT
r_map_words_batched(in_text VARCHAR(2000000))
EMITS (mapped_word CHAR(99)) AS
run <- function (ctx) {
	invector_size = ctx$size()
	repeat {
           	batchvector_size = min(invector_size, 50000);
		if (batchvector_size == 0) break;
		invector_size = invector_size - batchvector_size;
		ctx$next_row(batchvector_size);
		corelogic(ctx)
	}
}
corelogic <- function (ctx) {
	v_chars <- unlist(strsplit(ctx$in_text, "\\s+"))
	ctx$emit(v_chars)
}
;
SELECT COUNT(*) AS "#words" FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_small
	GROUP BY CAST(ROWNUM/50000 AS INT)
);
SELECT COUNT(*) AS "#words" FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_large
	GROUP BY CAST(ROWNUM/50000 AS INT)
); -- takes about 12 sec on sandbox

/* ------------------------------------------- */
/* REDUCE */
/* ------------------------------------------- */

/* Using built-in function and no UDF for recude phase */
SELECT mapped_word AS reduced_word, COUNT(*) AS reduced_count FROM (
	SELECT r_map_words(textblock) FROM text_table_large
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 49 sec on sandbox
SELECT mapped_word AS reduced_word, COUNT(*) AS reduced_count FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_large
	GROUP BY CAST(ROWNUM/50000 AS INT)
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 11 sec on sandbox

CREATE OR REPLACE R SET SCRIPT
r_reduce_words(in_word CHAR(99))
EMITS (reduced_word CHAR(99), reduced_count DOUBLE) AS
run <- function (ctx) {
	reduced_word <- ctx$in_word
	if (is.na(reduced_word)) {return(NA)}
	reduced_count <- ctx$size()
	ctx$emit(reduced_word, reduced_count)
}
;
SELECT r_reduce_words(mapped_word) FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_small
	GROUP BY CAST(ROWNUM/50000 AS INT)
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
;
SELECT r_reduce_words(mapped_word) FROM (
	SELECT r_map_words(textblock) FROM text_table_large
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 53 sec on sandbox (see above: ~ 49 seconds for map function)
SELECT r_reduce_words(mapped_word) FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_large
	GROUP BY CAST(ROWNUM/50000 AS INT)
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 16 sec on sandbox (see above: ~ 12 seconds for map function)


/* ================================================= */
/* ------------------------------------------------- */
/* Verifying the algorithm on a VERY large data set: */
/* ------------------------------------------------- */
/* ================================================= */
CREATE OR REPLACE VIEW text_table_verylarge AS SELECT L_COMMENT AS textblock FROM TPC.LINEITEM;

SELECT COUNT(textblock) AS "#rows" -- #rows = 600.037.902
     , ROUND(AVG(CHARACTER_LENGTH(textblock)),2) AS "avg_charlength_of_row"
     , SUM(CHARACTER_LENGTH(textblock)) AS "#characters"
  FROM text_table_verylarge; -- takes about 13 sec on sandbox

/* Using built-in function and no UDF for recude phase */
SELECT mapped_word AS reduced_word, COUNT(*) AS reduced_count FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_verylarge
	 --WHERE RAND() < 0.05
	 --GROUP BY MOD(ROWNUM, 128) -- #rows = 600.037.902 / 128 »» ~4,7 Mio Zeilen je Gruppe
	 GROUP BY CAST(ROWNUM/50000 AS INT) -- #rows in 50.000 Zeilen je Gruppe
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about "X:XX m" (XXX sec) on sandbox (Session-ID: 1449881422444253323)
/*  der TEMP_DB_RAM_USAGE anfänglich 15000, kontinuierlich steigend,
    mindestens auch als 200702.3 ... 298181.6 ... 335936.5 ... beobachtet worden.
    Dann irgendwann Abbruch mit:
    17:58:54.264    Fehler:  [22002] VM error: Internal error: VM crashed
*/

SELECT r_reduce_words(mapped_word) FROM (
	SELECT r_map_words_batched(textblock) FROM text_table_verylarge
	GROUP BY CAST(ROWNUM/50000 AS INT)
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about "X:XX m" (XXX sec) on sandbox
