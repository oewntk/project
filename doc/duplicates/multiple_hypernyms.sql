-- hypernym code
SELECT * 
FROM relations;

-- hypernym relations
SELECT * 
FROM semrelations
WHERE relationid = 1;

-- number of hypernyms per synset
SELECT synset1id, count(*)
FROM semrelations 
WHERE relationid = 1
GROUP BY synset1id;

-- synset ids having multiple hypernyms
SELECT synset1id
FROM semrelations 
WHERE relationid = 1
GROUP BY synset1id HAVING count(*) > 1;

-- synsets having multiple hypernyms
SELECT *
FROM synsets 
WHERE synsetid IN (
	SELECT synset1id
	FROM semrelations 
	WHERE relationid = 1
	GROUP BY synset1id HAVING count(*) > 1);

-- synsets having multiple hypernyms
SELECT synsetid, definition, count(*) 
FROM semrelations 
LEFT JOIN synsets ON synset1id = synsetid
WHERE relationid = 1
GROUP BY synset1id HAVING count(*) > 1;

-- count of synsets having multiple hypernyms
SELECT count(*)
FROM synsets 
WHERE synsetid IN (
	SELECT synset1id
	FROM semrelations 
	WHERE relationid = 1
	GROUP BY synset1id HAVING count(*) > 1);

-- synsets having multiple hypernyms, with members
SELECT synsetid, definition, GROUP_CONCAT(word)
FROM synsets 
LEFT JOIN senses USING (synsetid)
LEFT JOIN words USING (wordid)
WHERE synsetid IN (
	SELECT synset1id
	FROM semrelations 
	WHERE relationid = 1
	GROUP BY synset1id HAVING count(*) > 1)
GROUP BY synsetid;

-- synsets having multiple hypernyms, with members
SELECT synsetid, definition, GROUP_CONCAT(word)
FROM synsets 
LEFT JOIN senses USING (synsetid)
LEFT JOIN words USING (wordid)
WHERE synsetid IN (
	SELECT synset1id
	FROM semrelations 
	WHERE relationid = 1
	GROUP BY synset1id HAVING count(*) > 1) AND (word = 'decoy' OR word = 'being')
GROUP BY synsetid;
