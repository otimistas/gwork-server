CREATE TABLE t_chats (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    content TEXT NOT NULL,
    channel_id TEXT REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    user_id TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    posted_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_chats_posted_at ON t_chats(posted_at);
