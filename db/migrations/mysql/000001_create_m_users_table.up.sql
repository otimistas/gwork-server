CREATE TABLE m_users (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    last_logged_in_at TIMESTAMP,
    created_by BINARY(16) NULL,
    from_system BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_users_name (name),
    INDEX idx_m_users_last_logged_in_at (last_logged_in_at),
    CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);
