CREATE TABLE m_users (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    last_logged_in_at TIMESTAMP,
    created_by BINARY(16) NULL,
    from_system BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_users_name (name),
    INDEX idx_m_users_last_logged_in_at (last_logged_in_at),
    CONSTRAINT fk_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE m_role_categories (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    INDEX idx_m_role_categories_name (name)
);

CREATE TABLE m_roles (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id BINARY(16) NOT NULL,
    INDEX idx_m_roles_name (name),
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE t_user_role (
    user_id BINARY(16) NOT NULL,
    role_id BINARY(16) NOT NULL,
    attached_by BINARY(16) NULL,
    from_system BOOLEAN NOT NULL,
    attached_at TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES m_roles(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_attached_by FOREIGN KEY (attached_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE m_groups (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    is_open BOOLEAN NOT NULL,
    is_primitive BOOLEAN NOT NULL,
    is_personal BOOLEAN NOT NULL,
    created_by BINARY(16) NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_groups_name (name),
    CONSTRAINT fk_group_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE t_user_group (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    group_id BINARY(16) NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT true,
    added_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_user_group_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_user_group_group_id FOREIGN KEY (group_id) REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE t_group_invites (
    user_id BINARY(16) NOT NULL,
    group_id BINARY(16) NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT true,
    invited_by BINARY(16) NULL,
    canceled_by BINARY(16) NULL,
    invited_at TIMESTAMP NOT NULL,
    canceled_at TIMESTAMP NULL,
    PRIMARY KEY (user_id, group_id),
    CONSTRAINT fk_invite_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_invite_group_id FOREIGN KEY (group_id) REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_invited_by FOREIGN KEY (invited_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    CONSTRAINT fk_canceled_by FOREIGN KEY (canceled_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE m_user_permission_categories (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    INDEX idx_m_user_permission_categories_name (name)
);

CREATE TABLE m_user_permissions (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id BINARY(16) NOT NULL,
    INDEX idx_m_user_permissions_name (name),
    CONSTRAINT fk_permission_category_id FOREIGN KEY (category_id) REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE t_user_group_permission (
    user_group_id INT NOT NULL,
    permission_id BINARY(16) NOT NULL,
    attached_by BINARY(16) NULL,
    attached_at TIMESTAMP NOT NULL,
    PRIMARY KEY (user_group_id, permission_id),
    CONSTRAINT fk_user_group_permission_user_group_id FOREIGN KEY (user_group_id) REFERENCES t_user_group(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_user_group_permission_permission_id FOREIGN KEY (permission_id) REFERENCES m_user_permissions(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_permission_attached_by FOREIGN KEY (attached_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE m_storage_access_permissions (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    mode CHAR(3) NOT NULL,
    INDEX idx_m_storage_access_permissions_mode (mode)
);

CREATE TABLE m_storages (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_by BINARY(16) NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    INDEX idx_m_storages_name (name),
    INDEX idx_m_storages_prefix (prefix),
    CONSTRAINT fk_storage_created_by FOREIGN KEY (created_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE t_group_storage_permission (
    storage_id BINARY(16) NOT NULL,
    group_id BINARY(16) NOT NULL,
    attached_by BINARY(16) NULL,
    last_changed_by BINARY(16) NULL,
    attached_at TIMESTAMP NOT NULL,
    last_changed_at TIMESTAMP NOT NULL,
    PRIMARY KEY (storage_id, group_id),
    CONSTRAINT fk_group_storage_permission_storage_id FOREIGN KEY (storage_id) REFERENCES m_storages(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_group_storage_permission_group_id FOREIGN KEY (group_id) REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_storage_attached_by FOREIGN KEY (attached_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    CONSTRAINT fk_storage_last_changed_by FOREIGN KEY (last_changed_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL
);

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

CREATE TABLE t_user_channel (
    user_id BINARY(16) NOT NULL,
    channel_id BINARY(16) NOT NULL,
    connected_at TIMESTAMP NOT NULL,
    disconnected_at TIMESTAMP NULL,
    PRIMARY KEY (user_id, channel_id),
    CONSTRAINT fk_user_channel_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_user_channel_channel_id FOREIGN KEY (channel_id) REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE
);

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
