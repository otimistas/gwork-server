DO $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 0..777 LOOP
        INSERT INTO m_storage_access_permissions (mode) VALUES (LPAD(i::text, 3, '0'));
    END LOOP;
END $$;
