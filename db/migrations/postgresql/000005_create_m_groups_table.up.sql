CREATE TABLE m_groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    is_open BOOLEAN NOT NULL,
    is_primitive BOOLEAN NOT NULL,
    is_personal BOOLEAN NOT NULL,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_groups_name ON m_groups(name);
