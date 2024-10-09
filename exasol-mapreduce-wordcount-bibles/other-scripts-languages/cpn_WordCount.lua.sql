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

CREATE OR REPLACE LUA SCALAR SCRIPT
lua_map_words(in_text VARCHAR(2000000))
EMITS (mapped_word CHAR(99)) AS
function run(ctx)
	local textblock = ctx.in_text
		if textblock == nil then
		return NULL
	end
	for iter in unicode.utf8.gmatch(textblock,'([%w%p]+)')
	do
	    ctx.emit(iter)
	end
end
;
SELECT COUNT(*) AS "#words" FROM (
	SELECT lua_map_words(textblock) FROM text_table_small
);
SELECT COUNT(*) AS "#words" FROM (
	SELECT lua_map_words(textblock) FROM text_table_large
); -- takes about 1.1 sec on sandbox

/* ------------------------------------------- */
/* REDUCE */
/* ------------------------------------------- */

/* Using built-in function and no UDF for recude phase */
SELECT mapped_word AS reduced_word, COUNT(*) AS reduced_count FROM (
	SELECT lua_map_words(textblock) FROM text_table_large
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 1.3 sec on sandbox

CREATE OR REPLACE LUA SET SCRIPT
lua_reduce_words(in_word CHAR(99))
EMITS (reduced_word CHAR(99), reduced_count DOUBLE) AS
function run(ctx)
	local reduced_count = 0
	local reduced_word = ctx.in_word
	if reduced_word == nil then
		return NULL
	end
	repeat
		reduced_count = reduced_count + 1
	until not ctx.next()
	ctx.emit(reduced_word, reduced_count)
end
;
SELECT lua_reduce_words(mapped_word) FROM (
	SELECT lua_map_words(textblock) FROM text_table_small
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
;
SELECT lua_reduce_words(mapped_word) FROM (
	SELECT lua_map_words(textblock) FROM text_table_large
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about 1.9 sec on sandbox (see above: ~ 1.1 seconds for map function)


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
	SELECT lua_map_words(textblock) FROM text_table_verylarge
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about "2:05 m" (125 sec) on sandbox

SELECT lua_reduce_words(mapped_word) FROM (
	SELECT lua_map_words(textblock) FROM text_table_verylarge
)
 GROUP BY mapped_word
 ORDER BY reduced_count DESC
; -- takes about "2:55 m" (175 sec) on sandbox
