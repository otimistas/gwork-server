CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE m_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
	login_id VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    last_logged_in_at TIMESTAMP,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    from_system BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_users_name ON m_users(name);
CREATE INDEX idx_m_users_last_logged_in_at ON m_users(last_logged_in_at);
