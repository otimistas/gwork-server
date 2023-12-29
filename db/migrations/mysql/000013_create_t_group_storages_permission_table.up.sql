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
