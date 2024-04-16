SELECT y1.definition,s1.sensekey,relation,s2.sensekey,y2.definition
FROM lexrelations AS r
INNER JOIN relations USING (relationid) 
LEFT JOIN senses AS s1 ON s1.wordid = r.word1id AND s1.synsetid = r.synset1id
LEFT JOIN senses AS s2 ON s2.wordid = r.word2id AND s2.synsetid = r.synset2id
LEFT JOIN synsets AS y1 ON y1.synsetid = r.synset1id
LEFT JOIN synsets AS y2 ON y2.synsetid = r.synset2id
WHERE relation IN ('agent','material','event','instrument','location','by means of','undergoer','property','result','state','uses','destination','body_part','vehicle')
ORDER BY s1.sensekey,s2.sensekey
INTO OUTFILE 'morphosemantics.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ','
ESCAPED BY '"'
LINES TERMINATED BY 'n';

