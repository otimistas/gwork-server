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
