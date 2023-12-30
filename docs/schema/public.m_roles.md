# public.m_roles

## Description

## Columns

| Name | Type | Default | Nullable | Children | Parents | Comment |
| ---- | ---- | ------- | -------- | -------- | ------- | ------- |
| id | uuid | uuid_generate_v4() | false | [public.t_user_role](public.t_user_role.md) |  |  |
| name | varchar(255) |  | false |  |  |  |
| detail | text |  | false |  |  |  |
| category_id | uuid |  | false |  | [public.m_role_categories](public.m_role_categories.md) |  |

## Constraints

| Name | Type | Definition |
| ---- | ---- | ---------- |
| m_roles_category_id_fkey | FOREIGN KEY | FOREIGN KEY (category_id) REFERENCES m_role_categories(id) ON UPDATE RESTRICT ON DELETE RESTRICT |
| m_roles_pkey | PRIMARY KEY | PRIMARY KEY (id) |

## Indexes

| Name | Definition |
| ---- | ---------- |
| m_roles_pkey | CREATE UNIQUE INDEX m_roles_pkey ON public.m_roles USING btree (id) |
| idx_m_roles_name | CREATE INDEX idx_m_roles_name ON public.m_roles USING btree (name) |

## Relations

![er](public.m_roles.svg)

---

> Generated by [tbls](https://github.com/k1LoW/tbls)