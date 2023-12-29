CREATE TABLE t_chats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    content TEXT NOT NULL,
    channel_id UUID REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    posted_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_chats_posted_at ON t_chats(posted_at);
