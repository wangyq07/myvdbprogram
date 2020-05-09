SELECT
ST.NAME TABLE_NAME
,C.name COLUMN_NAME
,C.column_id ORDINAL_POSITION
,CASE WHEN C.is_nullable=0 THEN 'No' else 'Yes' end IS_NULLABLE
,T.name DATA_TYPE
,C.max_length CHARACTER_MAXIMUM_LENGTH
FROM SYS.columns C
INNER JOIN SYS.tables ST
ON ST.object_id=C.object_id
INNER JOIN SYS.types T
ON T.system_type_id=C.system_type_id
AND T.user_type_id=C.user_type_id
ORDER BY ST.NAME,C.column_id