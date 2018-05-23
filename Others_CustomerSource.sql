/*
default
*/

SELECT source_name FROM CustomerSource
ORDER BY source_id DESC;

/*
add
*/

INSERT INTO CustomerSource(source_name)
VALUES('HAHAH');

/*
delete
*/

DELETE FROM CustomerSource
WHERE source_name = 'HAHAH';