CREATE TABLE t_user_channel (
    user_id BINARY(16) NOT NULL,
    channel_id BINARY(16) NOT NULL,
    connected_at TIMESTAMP NOT NULL,
    disconnected_at TIMESTAMP NULL,
    PRIMARY KEY (user_id, channel_id),
    CONSTRAINT fk_user_channel_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_user_channel_channel_id FOREIGN KEY (channel_id) REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE
);
