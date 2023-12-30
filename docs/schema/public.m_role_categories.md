# public.m_role_categories

## Description

## Columns

| Name | Type | Default | Nullable | Children | Parents | Comment |
| ---- | ---- | ------- | -------- | -------- | ------- | ------- |
| id | uuid | uuid_generate_v4() | false | [public.m_roles](public.m_roles.md) |  |  |
| name | varchar(255) |  | false |  |  |  |
| detail | text |  | false |  |  |  |

## Constraints

| Name | Type | Definition |
| ---- | ---- | ---------- |
| m_role_categories_pkey | PRIMARY KEY | PRIMARY KEY (id) |

## Indexes

| Name | Definition |
| ---- | ---------- |
| m_role_categories_pkey | CREATE UNIQUE INDEX m_role_categories_pkey ON public.m_role_categories USING btree (id) |
| idx_m_role_categories_name | CREATE INDEX idx_m_role_categories_name ON public.m_role_categories USING btree (name) |

## Relations

![er](public.m_role_categories.svg)

---

> Generated by [tbls](https://github.com/k1LoW/tbls)