// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.24.0

package pgquery

import (
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
)

type MChannel struct {
	ID                 uuid.UUID        `json:"id"`
	Name               string           `json:"name"`
	AdminGroupID       uuid.UUID        `json:"admin_group_id"`
	ConnectableGroupID uuid.UUID        `json:"connectable_group_id"`
	LastActivityAt     pgtype.Timestamp `json:"last_activity_at"`
	CreatedBy          pgtype.UUID      `json:"created_by"`
	UpdatedBy          pgtype.UUID      `json:"updated_by"`
	CreatedAt          time.Time        `json:"created_at"`
	UpdatedAt          time.Time        `json:"updated_at"`
}

type MGroup struct {
	ID          uuid.UUID   `json:"id"`
	Name        string      `json:"name"`
	IsOpen      bool        `json:"is_open"`
	IsPrimitive bool        `json:"is_primitive"`
	IsPersonal  bool        `json:"is_personal"`
	CreatedBy   pgtype.UUID `json:"created_by"`
	CreatedAt   time.Time   `json:"created_at"`
	UpdatedAt   time.Time   `json:"updated_at"`
}

type MRole struct {
	ID         uuid.UUID `json:"id"`
	Name       string    `json:"name"`
	Detail     string    `json:"detail"`
	CategoryID uuid.UUID `json:"category_id"`
}

type MRoleCategory struct {
	ID     uuid.UUID `json:"id"`
	Name   string    `json:"name"`
	Detail string    `json:"detail"`
}

type MStorage struct {
	ID        uuid.UUID   `json:"id"`
	Name      string      `json:"name"`
	Prefix    string      `json:"prefix"`
	CreatedBy pgtype.UUID `json:"created_by"`
	CreatedAt time.Time   `json:"created_at"`
	UpdatedAt time.Time   `json:"updated_at"`
}

type MStorageAccessPermission struct {
	ID   uuid.UUID `json:"id"`
	Mode string    `json:"mode"`
}

type MUser struct {
	ID             uuid.UUID        `json:"id"`
	LoginID        string           `json:"login_id"`
	Password       string           `json:"password"`
	Name           string           `json:"name"`
	LastLoggedInAt pgtype.Timestamp `json:"last_logged_in_at"`
	CreatedBy      pgtype.UUID      `json:"created_by"`
	FromSystem     bool             `json:"from_system"`
	CreatedAt      time.Time        `json:"created_at"`
	UpdatedAt      time.Time        `json:"updated_at"`
}

type MUserPermission struct {
	ID         uuid.UUID `json:"id"`
	Name       string    `json:"name"`
	Detail     string    `json:"detail"`
	CategoryID uuid.UUID `json:"category_id"`
}

type MUserPermissionCategory struct {
	ID     uuid.UUID `json:"id"`
	Name   string    `json:"name"`
	Detail string    `json:"detail"`
}

type TChat struct {
	ID        uuid.UUID   `json:"id"`
	Content   string      `json:"content"`
	ChannelID uuid.UUID   `json:"channel_id"`
	UserID    pgtype.UUID `json:"user_id"`
	PostedAt  time.Time   `json:"posted_at"`
}

type TGroupInvite struct {
	UserID     uuid.UUID          `json:"user_id"`
	GroupID    uuid.UUID          `json:"group_id"`
	IsValid    bool               `json:"is_valid"`
	InvitedBy  pgtype.UUID        `json:"invited_by"`
	CanceledBy pgtype.UUID        `json:"canceled_by"`
	InvitedAt  time.Time          `json:"invited_at"`
	CanceledAt pgtype.Timestamptz `json:"canceled_at"`
}

type TGroupStoragePermission struct {
	StorageID     uuid.UUID   `json:"storage_id"`
	GroupID       uuid.UUID   `json:"group_id"`
	AttachedBy    pgtype.UUID `json:"attached_by"`
	LastChangedBy pgtype.UUID `json:"last_changed_by"`
	AttachedAt    time.Time   `json:"attached_at"`
	LastChangedAt time.Time   `json:"last_changed_at"`
}

type TUserChannel struct {
	UserID         uuid.UUID          `json:"user_id"`
	ChannelID      uuid.UUID          `json:"channel_id"`
	ConnectedAt    time.Time          `json:"connected_at"`
	DisconnectedAt pgtype.Timestamptz `json:"disconnected_at"`
}

type TUserGroup struct {
	ID      int32     `json:"id"`
	UserID  uuid.UUID `json:"user_id"`
	GroupID uuid.UUID `json:"group_id"`
	IsValid bool      `json:"is_valid"`
	AddedAt time.Time `json:"added_at"`
}

type TUserGroupPermission struct {
	UserGroupID  int32       `json:"user_group_id"`
	PermissionID uuid.UUID   `json:"permission_id"`
	AttachedBy   pgtype.UUID `json:"attached_by"`
	AttachedAt   time.Time   `json:"attached_at"`
}

type TUserRole struct {
	UserID     uuid.UUID   `json:"user_id"`
	RoleID     uuid.UUID   `json:"role_id"`
	AttachedBy pgtype.UUID `json:"attached_by"`
	FromSystem bool        `json:"from_system"`
	AttachedAt time.Time   `json:"attached_at"`
}
