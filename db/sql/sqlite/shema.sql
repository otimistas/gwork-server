CREATE TABLE m_users (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    last_logged_in_at TIMESTAMP,
    created_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    from_system BOOLEAN NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_users_name ON m_users(name);
CREATE INDEX idx_m_users_last_logged_in_at ON m_users(last_logged_in_at);

CREATE TABLE m_role_categories (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);

CREATE INDEX idx_m_role_categories_name ON m_role_categories(name);

CREATE TABLE m_roles (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id TEXT REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);

CREATE INDEX idx_m_roles_name ON m_roles(name);

CREATE TABLE t_user_role (
    user_id TEXT REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    role_id TEXT REFERENCES m_roles(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    from_system BOOLEAN NOT NULL,
    attached_at TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE m_groups (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    is_open BOOLEAN NOT NULL,
    is_primitive BOOLEAN NOT NULL,
    is_personal BOOLEAN NOT NULL,
    created_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_groups_name ON m_groups(name);

CREATE TABLE t_user_group (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id TEXT REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT 1,
    added_at TIMESTAMP NOT NULL
);

CREATE TABLE t_group_invites (
    user_id TEXT REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id TEXT REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT 1,
    invited_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    canceled_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    invited_at TIMESTAMP NOT NULL,
    canceled_at TIMESTAMP,
    PRIMARY KEY (user_id, group_id)
);

CREATE TABLE m_user_permission_categories (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);

CREATE INDEX idx_m_user_permission_categories_name ON m_user_permission_categories(name);

CREATE TABLE m_user_permissions (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id TEXT REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);

CREATE INDEX idx_m_user_permissions_name ON m_user_permissions(name);

CREATE TABLE t_user_group_permission (
    user_group_id INTEGER REFERENCES t_user_group(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    permission_id TEXT REFERENCES m_user_permissions(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMP NOT NULL,
    PRIMARY KEY (user_group_id, permission_id)
);

CREATE TABLE m_storage_access_permissions (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    mode CHAR(3) NOT NULL
);

CREATE INDEX idx_m_storage_access_permissions_mode ON m_storage_access_permissions(mode);

CREATE TABLE m_storages (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_by TEXT REFERENCES
    m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_storages_name ON m_storages(name);
CREATE INDEX idx_m_storages_prefix ON m_storages(prefix);

CREATE TABLE t_group_storage_permission (
    storage_id TEXT REFERENCES m_storages(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id TEXT REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    last_changed_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMP NOT NULL,
    last_changed_at TIMESTAMP NOT NULL,
    PRIMARY KEY (storage_id, group_id)
);

CREATE TABLE m_channels (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    name VARCHAR(255) NOT NULL,
    admin_group_id TEXT REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    connectable_group_id TEXT REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    last_activity_at TIMESTAMP,
    created_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    updated_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_channels_name ON m_channels(name);
CREATE INDEX idx_m_channels_last_activity_at ON m_channels(last_activity_at);

CREATE TABLE t_user_channel (
    user_id TEXT REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    channel_id TEXT REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    connected_at TIMESTAMP NOT NULL,
    disconnected_at TIMESTAMP,
    PRIMARY KEY (user_id, channel_id)
);

CREATE TABLE t_chats (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-4' || substr(lower(hex(randomblob(2))),2) || '-a' || substr('89ab',abs(random()) % 4 + 1,1) || '-'
    || lower(hex(randomblob(6))) || lower(hex(randomblob(6)))) COLLATE NOCASE,
    content TEXT NOT NULL,
    channel_id TEXT REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    user_id TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    posted_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_m_chats_posted_at ON t_chats(posted_at);
