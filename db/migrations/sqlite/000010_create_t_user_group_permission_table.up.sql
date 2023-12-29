CREATE TABLE t_user_group_permission (
    user_group_id INTEGER REFERENCES t_user_group(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    permission_id TEXT REFERENCES m_user_permissions(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMP NOT NULL,
    PRIMARY KEY (user_group_id, permission_id)
);
