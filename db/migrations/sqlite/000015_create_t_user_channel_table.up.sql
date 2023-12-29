CREATE TABLE t_user_channel (
    user_id TEXT REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    channel_id TEXT REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    connected_at TIMESTAMP NOT NULL,
    disconnected_at TIMESTAMP,
    PRIMARY KEY (user_id, channel_id)
);
