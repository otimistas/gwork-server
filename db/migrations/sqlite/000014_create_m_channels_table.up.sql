CREATE TABLE m_channels (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    admin_group_id TEXT REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    connectable_group_id TEXT REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    last_activity_at TIMESTAMP,
    created_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    updated_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_channels_name ON m_channels(name);
CREATE INDEX idx_m_channels_last_activity_at ON m_channels(last_activity_at);
