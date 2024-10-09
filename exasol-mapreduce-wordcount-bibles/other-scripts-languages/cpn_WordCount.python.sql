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

CREATE OR REPLACE PYTHON SCALAR SCRIPT
python_map_words(in_text VARCHAR(2000000))
EMITS (mapped_word CHAR(99)) AS
import re
import string
def run(ctx):
	textblock = ctx.in_text
	if textblock is None:
		return None
	matches = re.findall(r'([\w'+re.escape(string.punctuation)+']+)', textblock)
	for iter in matches:
		ctx.emit(iter)
;
SELECT COUNT(*) AS "#words" FROM (
	SELECT python_map_words(textblock) FROM text_table_small
);
SELECT COUNT(*) AS "#words" FROM (
	SELECT python_map_words(textblock) FROM text_table_large
); -- takes about 20 sec on sandbox

/* ------------------------------------------- */
/* REDUCE */
/* ------------------------------------------- */

/* Using built-in function and no UDF for recude phase */
SELECT mapped_word AS reduced_word, COUNT(*) AS reduced_count FROM (
	SELECT python_map_words(textblock) FROM text_table_large
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 20 sec on sandbox

CREATE OR REPLACE PYTHON SET SCRIPT
python_reduce_words(in_word CHAR(99))
EMITS (reduced_word CHAR(99), reduced_count DOUBLE) AS
def run(ctx):
	reduced_count = 0
	reduced_char = ctx.in_word
	if reduced_char is None:
		return None
	while True:
		reduced_count = reduced_count + 1
		if not ctx.next():
			break
	ctx.emit(reduced_char, reduced_count)
;
SELECT python_reduce_words(mapped_word) FROM (
	SELECT python_map_words(textblock) FROM text_table_small
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
;
SELECT python_reduce_words(mapped_word) FROM (
	SELECT python_map_words(textblock) FROM text_table_large
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 27 sec on sandbox (see above: 20 seconds for map function)


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
	SELECT python_map_words(textblock) FROM text_table_verylarge
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about "36:15 m" (2175 sec) on sandbox

SELECT python_reduce_words(mapped_word) FROM (
	SELECT python_map_words(textblock) FROM text_table_verylarge
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about "X:XX m" (XXX sec) on sandbox
