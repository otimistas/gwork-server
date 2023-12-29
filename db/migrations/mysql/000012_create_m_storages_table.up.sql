CREATE TABLE m_storages (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_by BINARY(16) NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_storages_name (name),
    INDEX idx_m_storages_prefix (prefix),
    CONSTRAINT fk_storage_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);
