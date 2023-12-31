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
