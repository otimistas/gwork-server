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
