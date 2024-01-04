CREATE TABLE t_group_storage_permission (
    storage_id TEXT REFERENCES m_storages(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id TEXT REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	access_permission_id TEXT REFERENCES m_storage_access_permissions(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    attached_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    last_changed_by TEXT REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMP NOT NULL,
    last_changed_at TIMESTAMP NOT NULL,
    PRIMARY KEY (storage_id, group_id)
);
