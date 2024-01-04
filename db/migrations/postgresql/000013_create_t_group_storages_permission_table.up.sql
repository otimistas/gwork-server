CREATE TABLE t_group_storage_permission (
    storage_id UUID REFERENCES m_storages(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
    group_id UUID REFERENCES m_groups(id) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	access_permission_id UUID REFERENCES m_storage_access_permissions(id) ON UPDATE RESTRICT ON DELETE RESTRICT NOT NULL,
    attached_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    last_changed_by UUID REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL,
    attached_at TIMESTAMPTZ NOT NULL,
    last_changed_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (storage_id, group_id)
);
