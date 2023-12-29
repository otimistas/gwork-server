CREATE TABLE m_user_permissions (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id BINARY(16) NOT NULL,
    INDEX idx_m_user_permissions_name (name),
    CONSTRAINT fk_permission_category_id FOREIGN KEY (category_id) REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);
