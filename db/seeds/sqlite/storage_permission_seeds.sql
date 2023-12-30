BEGIN;
CREATE TABLE IF NOT EXISTS temp_table(i INTEGER);
WITH RECURSIVE cnt(x) AS (VALUES(0) UNION ALL SELECT x+1 FROM cnt WHERE x<777)
INSERT INTO temp_table SELECT x FROM cnt;
INSERT INTO m_storage_access_permissions(mode) SELECT printf("%03d", i) FROM temp_table;
COMMIT;
