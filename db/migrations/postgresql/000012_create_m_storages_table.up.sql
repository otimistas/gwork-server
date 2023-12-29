CREATE TABLE m_storages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_storages_name ON m_storages(name);
CREATE INDEX idx_m_storages_prefix ON m_storages(prefix);
