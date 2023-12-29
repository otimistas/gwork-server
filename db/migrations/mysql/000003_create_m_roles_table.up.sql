CREATE TABLE m_roles (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id BINARY(16) NOT NULL,
    INDEX idx_m_roles_name (name),
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);
