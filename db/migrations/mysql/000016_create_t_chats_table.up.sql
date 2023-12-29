CREATE TABLE t_chats (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    content TEXT NOT NULL,
    channel_id BINARY(16) NOT NULL,
    user_id BINARY(16) NULL,
    posted_at TIMESTAMP NOT NULL,
    INDEX idx_m_chats_posted_at (posted_at),
    CONSTRAINT fk_chat_channel_id FOREIGN KEY (channel_id) REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_chat_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);
