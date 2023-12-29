CREATE TABLE m_channels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    admin_group_id UUID REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    connectable_group_id UUID REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    last_activity_at TIMESTAMP,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    updated_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_channels_name ON m_channels(name);
CREATE INDEX idx_m_channels_last_activity_at ON m_channels(last_activity_at);
