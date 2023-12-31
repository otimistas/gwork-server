# public.t_user_role

## Description

## Columns

| Name | Type | Default | Nullable | Children | Parents | Comment |
| ---- | ---- | ------- | -------- | -------- | ------- | ------- |
| user_id | uuid |  | false |  | [public.m_users](public.m_users.md) |  |
| role_id | uuid |  | false |  | [public.m_roles](public.m_roles.md) |  |
| attached_by | uuid |  | true |  | [public.m_users](public.m_users.md) |  |
| from_system | boolean |  | false |  |  |  |
| attached_at | timestamp with time zone |  | false |  |  |  |

## Constraints

| Name | Type | Definition |
| ---- | ---- | ---------- |
| t_user_role_attached_by_fkey | FOREIGN KEY | FOREIGN KEY (attached_by) REFERENCES m_users(id) ON UPDATE SET NULL ON DELETE SET NULL |
| t_user_role_user_id_fkey | FOREIGN KEY | FOREIGN KEY (user_id) REFERENCES m_users(id) ON UPDATE CASCADE ON DELETE CASCADE |
| t_user_role_role_id_fkey | FOREIGN KEY | FOREIGN KEY (role_id) REFERENCES m_roles(id) ON UPDATE CASCADE ON DELETE CASCADE |
| t_user_role_pkey | PRIMARY KEY | PRIMARY KEY (user_id, role_id) |

## Indexes

| Name | Definition |
| ---- | ---------- |
| t_user_role_pkey | CREATE UNIQUE INDEX t_user_role_pkey ON public.t_user_role USING btree (user_id, role_id) |

## Relations

![er](public.t_user_role.svg)

---

> Generated by [tbls](https://github.com/k1LoW/tbls)
