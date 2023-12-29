CREATE TABLE m_role_categories (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    INDEX idx_m_role_categories_name (name)
);
