CREATE TABLE m_users (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
	login_id VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    last_logged_in_at TIMESTAMP,
    created_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    from_system BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_users_name ON m_users(name);
CREATE INDEX idx_m_users_last_logged_in_at ON m_users(last_logged_in_at);
