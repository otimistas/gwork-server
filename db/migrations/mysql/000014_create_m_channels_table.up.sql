CREATE TABLE m_channels (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    admin_group_id BINARY(16) NOT NULL,
    connectable_group_id BINARY(16) NOT NULL,
    last_activity_at TIMESTAMP,
    created_by BINARY(16) NULL,
	updated_by BINARY(16) NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_channels_name (name),
    INDEX idx_m_channels_last_activity_at (last_activity_at),
    CONSTRAINT fk_channel_admin_group_id FOREIGN KEY (admin_group_id) REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT fk_channel_connectable_group_id FOREIGN KEY (connectable_group_id) REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    CONSTRAINT fk_channel_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    CONSTRAINT fk_channel_updated_by FOREIGN KEY (updated_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);
