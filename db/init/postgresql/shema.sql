CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE m_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    last_logged_in_at TIMESTAMP,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    from_system BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_users_name ON m_users(name);
CREATE INDEX idx_m_users_last_logged_in_at ON m_users(last_logged_in_at);

CREATE TABLE m_role_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);
CREATE INDEX idx_m_role_categories_name ON m_role_categories(name);

CREATE TABLE m_roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id UUID REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);
CREATE INDEX idx_m_roles_name ON m_roles(name);

CREATE TABLE t_user_role (
    user_id UUID REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    role_id UUID REFERENCES m_roles(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    from_system BOOLEAN NOT NULL,
    attached_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE m_groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    is_open BOOLEAN NOT NULL,
    is_primitive BOOLEAN NOT NULL,
    is_personal BOOLEAN NOT NULL,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_groups_name ON m_groups(name);

CREATE TABLE t_user_group (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id UUID REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT true,
    added_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE t_group_invites (
    user_id UUID REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id UUID REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT true,
    invited_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    canceled_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    invited_at TIMESTAMPTZ NOT NULL,
    canceled_at TIMESTAMPTZ,
    PRIMARY KEY (user_id, group_id)
);

CREATE TABLE m_user_permission_categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL
);
CREATE INDEX idx_m_user_permission_categories_name ON m_user_permission_categories(name);

CREATE TABLE m_user_permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    category_id UUID REFERENCES m_user_permission_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL
);
CREATE INDEX idx_m_user_permissions_name ON m_user_permissions(name);

CREATE TABLE t_user_group_permission (
    user_group_id INT REFERENCES t_user_group(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    permission_id UUID REFERENCES m_user_permissions(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_group_id, permission_id)
);

CREATE TABLE m_storage_access_permissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    mode CHAR(3) NOT NULL
);
CREATE INDEX idx_m_storage_access_permissions_mode ON m_storage_access_permissions(mode);

CREATE TABLE m_storages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    prefix VARCHAR(255) NOT NULL UNIQUE,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_storages_name ON m_storages(name);
CREATE INDEX idx_m_storages_prefix ON m_storages(prefix);

CREATE TABLE t_group_storage_permission (
    storage_id UUID REFERENCES m_storages(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id UUID REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    last_changed_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMPTZ NOT NULL,
    last_changed_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (storage_id, group_id)
);

CREATE TABLE m_channels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    admin_group_id UUID REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    connectable_group_id UUID REFERENCES m_groups(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    last_activity_at TIMESTAMP,
    created_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    updated_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_channels_name ON m_channels(name);
CREATE INDEX idx_m_channels_last_activity_at ON m_channels(last_activity_at);

CREATE TABLE t_user_channel (
    user_id UUID REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    channel_id UUID REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    connected_at TIMESTAMPTZ NOT NULL,
    disconnected_at TIMESTAMPTZ,
    PRIMARY KEY (user_id, channel_id)
);

CREATE TABLE t_chats (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    content TEXT NOT NULL,
    channel_id UUID REFERENCES m_channels(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    posted_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_m_chats_posted_at ON t_chats(posted_at);
