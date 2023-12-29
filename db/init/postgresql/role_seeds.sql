DO $$
DECLARE
    category_id_1 UUID;
    category_id_2 UUID;
    category_id_3 UUID;
    category_id_4 UUID;
    category_id_5 UUID;
	category_id_6 UUID;

BEGIN
-- on user
INSERT INTO
	m_role_categories (name, detail)
VALUES
	(
		'USER',
		'Permissions related to the user.\nHandles operational privileges related to creating and forcibly deleting users.'
	) RETURNING id INTO category_id_1;

INSERT INTO
	m_roles (name, detail, category_id)
VALUES
	(
		'USER_CREATE',
		'Users with this privilege can create users.',
		category_id_1
	),
	(
		'USER_DELETE',
		'Users with this privilege can forcibly delete users.',
		category_id_1
	);

-- -- on role
INSERT INTO
	m_role_categories (name, detail)
VALUES
	(
		'ROLE',
		'Permissions related to roles.\nHandles roles for users.'
	) RETURNING id INTO category_id_2;

INSERT INTO
	m_roles (name, detail, category_id)
VALUES
	(
		'ROLE_ATTACH',
		'Users with this authority can grant roles to users.',
		category_id_2
	),
	(
		'ROLE_DETACH',
		'Users with this privilege can revoke roles to users.',
		category_id_2
	);

-- -- on channel
INSERT INTO
	m_role_categories (name, detail)
VALUES
	(
		'CHANNEL',
		'Permissions on channels.\nIt handles channel operations, such as creating a channel or deleting any channel, even from outside the channel.'
	) RETURNING id INTO category_id_3;

INSERT INTO
	m_roles (name, detail, category_id)
VALUES
	(
		'CHANNEL_CREATE',
		'Users with this authority can create channels.',
		category_id_3
	),
	(
		'CHANNEL_DELETE',
		'Users with this authority can forcibly delete channels.',
		category_id_3
	);

-- -- on group
INSERT INTO
	m_role_categories (name, detail)
VALUES
	(
		'GROUP',
		'Permissions related to groups.\nIt handles group operations such as creating groups and forcibly deleting groups to which no channels are attached from the outside.'
	) RETURNING id INTO category_id_4;

INSERT INTO
	m_roles (name, detail, category_id)
VALUES
	(
		'GROUP_CREATE',
		'Users with this privilege can create groups.',
		category_id_4
	),
	(
		'GROUP_DELETE',
		'Users with this privilege can delete groups.',
		category_id_4
	);

-- -- on storage
INSERT INTO
	m_role_categories (name, detail)
VALUES
	(
		'STORAGE',
		'Storage Authority.\nIt handles storage operations such as creating storage, deleting storage, etc.'
	) RETURNING id INTO category_id_5;

INSERT INTO
	m_roles (name, detail, category_id)
VALUES
	(
		'STORAGE_CREATE',
		'Users with this privilege can create storage.',
		category_id_5
	),
	(
		'STORAGE_DELETE',
		'Users with this privilege can delete storage.',
		category_id_5
	);

-- -- on storage permission
INSERT INTO
    m_role_categories (name, detail)
VALUES
	(
		'STORAGE_PERMISSION',
		'Authority related to storage permissions.\nIt handles operations of storage privileges, such as granting, changing, and revoking storage privileges for groups.'
	) RETURNING id INTO category_id_6;

INSERT INTO
	m_roles (name, detail, category_id)
VALUES
	(
		'STORAGE_PERMISSION_ATTACH',
		'Users with this privilege can grant or change storage privileges to groups.',
		category_id_6
	),
	(
		'STORAGE_PERMISSION_DETACH',
		'Users with this privilege can revoke storage privileges to the group.',
		category_id_6
	);

END $$;
