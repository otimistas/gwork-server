CREATE TABLE m_roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id UUID REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);
CREATE INDEX idx_m_roles_name ON m_roles(name);
