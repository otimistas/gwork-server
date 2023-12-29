CREATE TABLE m_roles (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id TEXT REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);

CREATE INDEX idx_m_roles_name ON m_roles(name);
