CREATE TABLE m_storage_access_permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    mode CHAR(3) NOT NULL
);
CREATE INDEX idx_m_storage_access_permissions_mode ON m_storage_access_permissions(mode);
