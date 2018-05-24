/*default display*/

SELECT department_name, description FROM Department ORDER BY department_id DESC;

/*
add
*/

INSERT INTO Department(department_name, description)
VALUES 
(
    'Mars',
    'Just kidding'
);


/*delete*/

DELETE FROM Department WHERE department_name = 'Mars';