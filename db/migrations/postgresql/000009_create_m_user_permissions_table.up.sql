CREATE TABLE m_user_permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id UUID REFERENCES m_user_permission_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);
CREATE INDEX idx_m_user_permissions_name ON m_user_permissions(name);
