CREATE TABLE m_storages (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_by TEXT REFERENCES
    m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_storages_name ON m_storages(name);
CREATE INDEX idx_m_storages_prefix ON m_storages(prefix);
