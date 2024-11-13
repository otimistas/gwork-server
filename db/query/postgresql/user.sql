-- name: CreateUser :one
INSERT INTO m_users (
  login_id,
  password,
  name,
  created_by,
  from_system,
  created_at,
  updated_at
) VALUES (
  $1, $2, $3, $4, $5, NOW(), NOW()
) RETURNING *;

-- name: FindUser :one
SELECT * FROM m_users
WHERE id = $1 LIMIT 1;

-- name: FindUserForLogin :one
SELECT * FROM m_users
WHERE login_id = $1 LIMIT 1;

-- name: GetUsers :many
SELECT * FROM m_users
ORDER BY last_logged_in_at DESC, created_at ASC;

-- name: GetUsersFromName :many
SELECT * FROM m_users
WHERE name ILIKE '%' || $1 || '%'
ORDER BY name DESC, created_at ASC;

-- name: UpdateUserName :one
UPDATE m_users
SET name = $2, updated_at = NOW()
WHERE id = $1
RETURNING *;

-- name: UpdateUserLoggedAt :one
UPDATE m_users
SET last_logged_in_at = NOW(), updated_at = NOW()
WHERE id = $1
RETURNING *;

-- name: UpdateUserPassword :one
UPDATE m_users
SET password = $2, updated_at = NOW()
WHERE id = $1
RETURNING *;

-- name: DeleteUser :exec
DELETE FROM m_users
WHERE id = $1;
