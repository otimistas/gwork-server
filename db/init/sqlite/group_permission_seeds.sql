-- on user
INSERT INTO m_user_permission_categories (name, detail)
VALUES
(
	'USER',
	'Authorization related to users.\nIt handles operations related to users, such as forcibly adding or expelling a user to a group.'
);

SELECT @category_id_1 := last_insert_rowid();

INSERT INTO m_user_permissions (name, detail, category_id)
VALUES
(
	'USER_ATTACH',
	'Users with this privilege can force users to be added to a group.',
	@category_id_1
),
(
	'USER_DETACH',
	'Users with this privilege can forcibly expel users to a group.',
	@category_id_1
);

-- on permission
INSERT INTO m_user_permission_categories (name, detail)
VALUES
(
	'PERMISSION',
	'Permissions related to user rights in a group.\nThis section deals with operations related to user privileges, such as granting or revoking privileges to users in a group.'
);

SELECT @category_id_2 := last_insert_rowid();

INSERT INTO m_user_permissions (name, detail, category_id)
VALUES
(
	'PERMISSION_ATTACH',
	'Users with this privilege can be granted group user privileges.',
	@category_id_2
),
(
	'PERMISSION_DETACH',
	'Users with this privilege can revoke user privileges in a group.',
	@category_id_2
);

-- on channel
INSERT INTO m_user_permission_categories (name, detail)
VALUES
(
	'CHANNEL',
	'Permissions for channels.\nIt handles channel operations, including the authority to attach a group to a channel and the authority to delete a channel if it is an administrative group of channels.'
);

SELECT @category_id_3 := last_insert_rowid();

INSERT INTO m_user_permissions (name, detail, category_id)
VALUES
(
	'CHANNEL_ATTACH',
	'Users with this privilege can reattach a group if the group is an administrative group and provided that the user also has this privilege after the reattachment.',
	@category_id_3
),
(
	'CHANNEL_DELETE',
	'Users with this authority can delete a channel if the group is an administrative group.',
	@category_id_3
);

-- on group
INSERT INTO m_user_permission_categories (name, detail)
VALUES
(
	'GROUP',
	'Permissions related to groups.\nPerform operations related to groups, such as deleting groups and changing their public/private status.'
);

SELECT @category_id_4 := last_insert_rowid();

INSERT INTO m_user_permissions (name, detail, category_id)
VALUES
(
	'GROUP_UPDATE',
	'Users with this authority can change the group public/private settings.',
	@category_id_4
),
(
	'GROUP_DELETE',
	'Users with this authority may only delete a group to which no channels are attached.',
	@category_id_4
);

-- on storage
INSERT INTO m_user_permission_categories (name, detail)
VALUES
(
	'STORAGE',
	'Storage Authority.\nDeals with authorization levels for storage attached to the group.'
);

SELECT @category_id_5 := last_insert_rowid();

INSERT INTO m_user_permissions (name, detail, category_id)
VALUES
(
	'STORAGE_ROOT',
	'Users with this privilege are treated as ROOT in the group privilege level for storage.',
	@category_id_5
),
(
	'STORAGE_PRIMARY',
	'Users with this privilege are treated as PRIMARY in the group privilege level for storage.',
	@category_id_5
);

-- on user invite
INSERT INTO m_user_permission_categories (name, detail)
VALUES
(
	'USER_INVITE',
	'Permissions related to user invitations.\nIt handles operations related to user invitations, such as inviting users in groups that are private and canceling invitations.'
);

SELECT @category_id_6 := last_insert_rowid();

INSERT INTO m_user_permissions (name, detail, category_id)
VALUES
(
	'USER_INVITE_DO',
	'Users with this privilege can invite users to groups that are private.',
	@category_id_6
),
(
	'USER_INVITE_CANCEL',
	'Users with this authority can cancel user invitations to groups that are private.',
	@category_id_6
);
