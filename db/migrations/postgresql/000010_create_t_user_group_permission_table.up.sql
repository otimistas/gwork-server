CREATE TABLE t_user_group_permission (
    user_group_id INT REFERENCES t_user_group(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    permission_id UUID REFERENCES m_user_permissions(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    attached_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_group_id, permission_id)
);
