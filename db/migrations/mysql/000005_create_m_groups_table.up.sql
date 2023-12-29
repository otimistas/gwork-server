CREATE TABLE m_groups (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    is_open BOOLEAN NOT NULL,
    is_primitive BOOLEAN NOT NULL,
    is_personal BOOLEAN NOT NULL,
    created_by BINARY(16) NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_groups_name (name),
    CONSTRAINT fk_group_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);
