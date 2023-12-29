CREATE TABLE t_user_group (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    group_id BINARY(16) NOT NULL,
    is_valid BOOLEAN NOT NULL DEFAULT true,
    added_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_user_group_user_id FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_user_group_group_id FOREIGN KEY (group_id) REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE
);
