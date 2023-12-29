CREATE TABLE m_user_permission_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);
CREATE INDEX idx_m_user_permission_categories_name ON m_user_permission_categories(name);
