CREATE TABLE m_storage_access_permissions (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    mode CHAR(3) NOT NULL,
    INDEX idx_m_storage_access_permissions_mode (mode)
);
