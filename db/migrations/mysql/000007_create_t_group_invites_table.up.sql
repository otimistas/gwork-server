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
