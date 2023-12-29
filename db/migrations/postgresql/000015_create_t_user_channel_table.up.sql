CREATE TABLE t_user_channel (
    user_id UUID REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    channel_id UUID REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    connected_at TIMESTAMPTZ NOT NULL,
    disconnected_at TIMESTAMPTZ,
    PRIMARY KEY (user_id, channel_id)
);
