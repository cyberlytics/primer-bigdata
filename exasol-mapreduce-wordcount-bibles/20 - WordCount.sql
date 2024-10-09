
CREATE OR REPLACE LUA SCALAR SCRIPT bible.map_words(tb varchar(2000000))
EMITS (word varchar(99)) AS
function run(ctx)
	for itr in unicode.utf8.gmatch(ctx.tb,'([%w%p]+)')
	do
	    ctx.emit(itr)
	end
end
;

-- American Standard-ASV1901 (ASV)
-- Bible in Basic English (BBE)
-- Darby English Bible (DARBY)
-- King James Version (KJV)
-- Webster's Bible (WBT)
-- World English Bible (WEB)
-- Young's Literal Translation (YLT)
SELECT word, COUNT(*) AS occurrence
  FROM (SELECT bible.map_words("t") FROM bible.allbibles)
 GROUP BY word
 ORDER BY occurrence DESC
 --LIMIT 50 -- about 68k words
;


-- Ignoring English stopwords:
SELECT * FROM
        (SELECT word, COUNT(*) AS occurrence
          FROM (SELECT bible.map_words("t") FROM bible.allbibles)
         GROUP BY word) t
 WHERE lower(t.word) NOT IN (SELECT stopword FROM bible."stopwords_en")
 ORDER BY t.occurrence DESC
 -- LIMIT 50 -- about 68k words
;
