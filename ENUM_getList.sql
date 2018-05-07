SELECT SUBSTRING(COLUMN_TYPE,5)
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA='databasename' 
    AND TABLE_NAME='tablename'
    AND COLUMN_NAME='columnname'