CREATE TABLE m_role_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);
CREATE INDEX idx_m_role_categories_name ON m_role_categories(name);
